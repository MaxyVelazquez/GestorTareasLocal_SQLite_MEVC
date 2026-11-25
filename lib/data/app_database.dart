import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

import 'tareas_table.dart';
import 'validacion.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [TareasTable],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _abrirConexion());

  @override
  int get schemaVersion => 1;

  //Genera una lista cada vez que se actualiza la tabla de tareas
  //Permite actualizar la interfaz adecuadamente
  Stream<List<TareasDB>> observarTareas(){
    return (select(tareasTable)..orderBy([(t)=>OrderingTerm.asc(t.id)])).watch();
  }

  //Promesa de insersión
  Future<int> insertarTarea(String titulo) async {
    exigirTituloValido(titulo);
    return into(tareasTable).insert(
      TareasTableCompanion.insert(titulo: normalizarTitulo(titulo)),
    );
  }
  //Promesa de actualización
  Future <int> actualizarTitulo(int id, String titulo){
    exigirTituloValido(titulo);
    return (update(tareasTable)..where((t)=>t.id.equals(id))).write(
      TareasTableCompanion(titulo: Value(normalizarTitulo(titulo))),
    );
  }
  //Promesa de cambio de estado: completada
  Future<int> cambiarEstado(int id, bool completada){
    
    return (update(tareasTable)..where((t)=> t.id.equals(id))).write(
      TareasTableCompanion(isCompleted: Value(completada)),
    );
  }

  Future<int> eliminarTarea(int id){
    return(delete(tareasTable)..where((t)=> t.id.equals(id))).go();
  }

  static QueryExecutor _abrirConexion() {

    return driftDatabase(
      name: 'gestor_tareas',
      web: DriftWebOptions(
        sqlite3Wasm: Uri.parse('sqlite3.wasm'),
        driftWorker: Uri.parse('drift_worker.js'),
      ),
    );
  }
}