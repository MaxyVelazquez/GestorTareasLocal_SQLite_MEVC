

import 'package:drift/drift.dart';

@DataClassName('TareasDB')
class TareasTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get titulo=> text()();
  BoolColumn get isCompleted => boolean().withDefault(const Constant(false))();
}