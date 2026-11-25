import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gestor_tareas_local/data/app_database.dart';
import 'package:gestor_tareas_local/data/validacion.dart';

void main() {
  late AppDatabase db;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
  });

  tearDown(() async {
    await db.close();
  });

  test('inserta una tarea pendiente con el título recortado', () async {
    await db.insertarTarea('  Comprar pan  ');

    final tareas = await db.observarTareas().first;

    expect(tareas, hasLength(1));
    expect(tareas.first.titulo, 'Comprar pan');
    expect(tareas.first.isCompleted, isFalse);
  });

  test('rechaza un título vacío y no escribe nada en la tabla', () async {
    await expectLater(
      db.insertarTarea('   '),
      throwsA(isA<TituloInvalidoException>()),
    );

    final tareas = await db.observarTareas().first;
    expect(tareas, isEmpty);
  });

  test('cambia el estado de una sola tarea', () async {
    final id1 = await db.insertarTarea('Uno');
    await db.insertarTarea('Dos');

    await db.cambiarEstado(id1, true);

    final tareas = await db.observarTareas().first;
    expect(tareas.firstWhere((t) => t.id == id1).isCompleted, isTrue);
    expect(tareas.where((t) => t.isCompleted), hasLength(1));
  });

  test('edita el título de una sola tarea', () async {
    final id1 = await db.insertarTarea('Uno');
    await db.insertarTarea('Dos');

    await db.actualizarTitulo(id1, 'Uno editado');

    final titulos = (await db.observarTareas().first).map((t) => t.titulo);
    expect(titulos, ['Uno editado', 'Dos']);
  });

  test('elimina solo la tarea indicada', () async {
    final id1 = await db.insertarTarea('Uno');
    await db.insertarTarea('Dos');

    await db.eliminarTarea(id1);

    final titulos = (await db.observarTareas().first).map((t) => t.titulo);
    expect(titulos, ['Dos']);
  });

  test('no reutiliza el id de una tarea eliminada (AUTOINCREMENT)', () async {
    await db.insertarTarea('Uno');
    await db.insertarTarea('Dos');
    final id3 = await db.insertarTarea('Tres');

    await db.eliminarTarea(id3);
    final id4 = await db.insertarTarea('Cuatro');

    expect(id4, isNot(id3));
    expect(id4, greaterThan(id3));
  });
}