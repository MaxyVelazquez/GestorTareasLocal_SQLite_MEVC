import 'package:flutter/material.dart';

import '../models/tarea.dart';
import '../data/app_database.dart';
import '../data/validacion.dart';

// Conserva las indicaciones TODO para orientar tu trabajo.
class TareasPage extends StatefulWidget {
  const TareasPage({super.key, this.database});

  final AppDatabase? database;
  @override
  State<TareasPage> createState() => _TareasPageState();
}

class _TareasPageState extends State<TareasPage> {
  final TextEditingController _tituloController = TextEditingController();

  late final AppDatabase _db;
  late final bool _dbPropia;
  late final Stream<List<TareasDB>> _tareasStream;

  @override
  void initState() {
    super.initState();
    _dbPropia=widget.database==null;
    _db = widget.database ?? AppDatabase();
    _tareasStream = _db.observarTareas();
  }

  @override
  void dispose() {
    _tituloController.dispose();
    if(_dbPropia)_db.close();
    super.dispose();
  }

  Future<void> _agregarTarea() async {
    try {
      await _db.insertarTarea(_tituloController.text);
      _tituloController.clear();
    } on TituloInvalidoException catch (e) {
      if (!mounted) return;
      _pendiente(e.mensaje);
    } catch (e) {
      if (!mounted) return;
      _pendiente("No se pudo guardar la tarea: $e");
    }
  }

  Future<void> _alternarCompletada(Tarea tarea, bool completada) async {
    try {
      await _db.cambiarEstado(tarea.id, completada);
    } catch (e) {
      if (!mounted) return;
      _pendiente("No se pudo actualizar la tarea: $e");
    }
  }

  Future<void> _editarTarea(Tarea tarea) async {
    final nuevoTitulo = await showDialog<String>(
      context: context,
      builder: (context) => _DialogoEditarTitulo(tituloInicial: tarea.titulo),
    );
    if (nuevoTitulo == null) return;
    try {
      await _db.actualizarTitulo(tarea.id, nuevoTitulo);
    } on TituloInvalidoException catch (e) {
      if (!mounted) return;
      _pendiente(e.mensaje);
    } catch (e) {
      if (!mounted) return;
      _pendiente("No se pudo actualizar la tarea: $e");
    }
  }

  Future<void> _eliminarTarea(Tarea tarea) async {
    try {
      await _db.eliminarTarea(tarea.id);
    } catch (e) {
      if (!mounted) return;
      _pendiente("No se pudo eliminar la tarea: $e");
    }
  }

  void _pendiente(String mensaje) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(mensaje)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Gestor de tareas')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _tituloController,
              decoration: const InputDecoration(
                labelText: 'Nueva tarea',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 8),
            FilledButton.icon(
              onPressed: _agregarTarea,
              icon: const Icon(Icons.add),
              label: const Text('Agregar tarea'),
            ),
            const SizedBox(height: 12),
            const Text('Mis tareas', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Expanded(
              child: StreamBuilder<List<TareasDB>>(
                stream: _tareasStream,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        'Error al leer las tareas: ${snapshot.error}',
                      ),
                    );
                  }
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  final tareas = snapshot.data!
                      .map(
                        (f) => Tarea(
                          id: f.id,
                          titulo: f.titulo,
                          completada: f.isCompleted,
                        ),
                      )
                      .toList();
                  if (tareas.isEmpty) {
                    return const Center(
                      child: Text('Todavía no hay tareas guardadas'),
                    );
                  }
                  return ListView.builder(
                    itemCount: tareas.length,
                    itemBuilder: (context, index) {
                      final tarea = tareas[index];
                      return Card(
                        child: ListTile(
                          leading: Checkbox(
                            value: tarea.completada,
                            onChanged: (valor) {
                              if (valor != null) {
                                _alternarCompletada(tarea, valor);
                              }
                            },
                          ),
                          title: Text(tarea.titulo),
                          subtitle: Text('ID: ${tarea.id}'),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                tooltip: 'Editar',
                                icon: const Icon(Icons.edit),
                                onPressed: () => _editarTarea(tarea),
                              ),
                              IconButton(
                                tooltip: 'Eliminar',
                                icon: const Icon(Icons.delete_outline),
                                onPressed: () => _eliminarTarea(tarea),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DialogoEditarTitulo extends StatefulWidget {
  const _DialogoEditarTitulo({required this.tituloInicial});

  final String tituloInicial;

  @override
  State<_DialogoEditarTitulo> createState() => _DialogoEditarTituloState();
}

class _DialogoEditarTituloState extends State<_DialogoEditarTitulo> {
  late final TextEditingController _controller;
  String? _error;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.tituloInicial);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _guardar() {
    final error = validarTitulo(_controller.text);
    if (error != null) {
      setState(() => _error = error);
      return;
    }
    Navigator.of(context).pop(normalizarTitulo(_controller.text));
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Editar tarea'),
      content: TextField(
        controller: _controller,
        autofocus: true,
        decoration: InputDecoration(
          labelText: 'Título',
          errorText: _error,
          border: const OutlineInputBorder(),
        ),
        onSubmitted: (_) => _guardar(),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancelar'),
        ),
        FilledButton(onPressed: _guardar, child: const Text('Guardar')),
      ],
    );
  }
}
