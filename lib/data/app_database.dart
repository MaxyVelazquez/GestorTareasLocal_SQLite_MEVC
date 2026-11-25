import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

import 'tareas_table.dart';

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
  Future<int> insertarTarea(String titulo){
    return into(tareasTable).insert(
      TareasTableCompanion.insert(titulo: titulo),
    );
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