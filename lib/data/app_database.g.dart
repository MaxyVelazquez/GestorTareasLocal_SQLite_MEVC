// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $TareasTableTable extends TareasTable
    with TableInfo<$TareasTableTable, TareasDB> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TareasTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _tituloMeta = const VerificationMeta('titulo');
  @override
  late final GeneratedColumn<String> titulo = GeneratedColumn<String>(
    'titulo',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isCompletedMeta = const VerificationMeta(
    'isCompleted',
  );
  @override
  late final GeneratedColumn<bool> isCompleted = GeneratedColumn<bool>(
    'is_completed',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_completed" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [id, titulo, isCompleted];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tareas_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<TareasDB> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('titulo')) {
      context.handle(
        _tituloMeta,
        titulo.isAcceptableOrUnknown(data['titulo']!, _tituloMeta),
      );
    } else if (isInserting) {
      context.missing(_tituloMeta);
    }
    if (data.containsKey('is_completed')) {
      context.handle(
        _isCompletedMeta,
        isCompleted.isAcceptableOrUnknown(
          data['is_completed']!,
          _isCompletedMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TareasDB map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TareasDB(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      titulo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}titulo'],
      )!,
      isCompleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_completed'],
      )!,
    );
  }

  @override
  $TareasTableTable createAlias(String alias) {
    return $TareasTableTable(attachedDatabase, alias);
  }
}

class TareasDB extends DataClass implements Insertable<TareasDB> {
  final int id;
  final String titulo;
  final bool isCompleted;
  const TareasDB({
    required this.id,
    required this.titulo,
    required this.isCompleted,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['titulo'] = Variable<String>(titulo);
    map['is_completed'] = Variable<bool>(isCompleted);
    return map;
  }

  TareasTableCompanion toCompanion(bool nullToAbsent) {
    return TareasTableCompanion(
      id: Value(id),
      titulo: Value(titulo),
      isCompleted: Value(isCompleted),
    );
  }

  factory TareasDB.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TareasDB(
      id: serializer.fromJson<int>(json['id']),
      titulo: serializer.fromJson<String>(json['titulo']),
      isCompleted: serializer.fromJson<bool>(json['isCompleted']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'titulo': serializer.toJson<String>(titulo),
      'isCompleted': serializer.toJson<bool>(isCompleted),
    };
  }

  TareasDB copyWith({int? id, String? titulo, bool? isCompleted}) => TareasDB(
    id: id ?? this.id,
    titulo: titulo ?? this.titulo,
    isCompleted: isCompleted ?? this.isCompleted,
  );
  TareasDB copyWithCompanion(TareasTableCompanion data) {
    return TareasDB(
      id: data.id.present ? data.id.value : this.id,
      titulo: data.titulo.present ? data.titulo.value : this.titulo,
      isCompleted: data.isCompleted.present
          ? data.isCompleted.value
          : this.isCompleted,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TareasDB(')
          ..write('id: $id, ')
          ..write('titulo: $titulo, ')
          ..write('isCompleted: $isCompleted')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, titulo, isCompleted);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TareasDB &&
          other.id == this.id &&
          other.titulo == this.titulo &&
          other.isCompleted == this.isCompleted);
}

class TareasTableCompanion extends UpdateCompanion<TareasDB> {
  final Value<int> id;
  final Value<String> titulo;
  final Value<bool> isCompleted;
  const TareasTableCompanion({
    this.id = const Value.absent(),
    this.titulo = const Value.absent(),
    this.isCompleted = const Value.absent(),
  });
  TareasTableCompanion.insert({
    this.id = const Value.absent(),
    required String titulo,
    this.isCompleted = const Value.absent(),
  }) : titulo = Value(titulo);
  static Insertable<TareasDB> custom({
    Expression<int>? id,
    Expression<String>? titulo,
    Expression<bool>? isCompleted,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (titulo != null) 'titulo': titulo,
      if (isCompleted != null) 'is_completed': isCompleted,
    });
  }

  TareasTableCompanion copyWith({
    Value<int>? id,
    Value<String>? titulo,
    Value<bool>? isCompleted,
  }) {
    return TareasTableCompanion(
      id: id ?? this.id,
      titulo: titulo ?? this.titulo,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (titulo.present) {
      map['titulo'] = Variable<String>(titulo.value);
    }
    if (isCompleted.present) {
      map['is_completed'] = Variable<bool>(isCompleted.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TareasTableCompanion(')
          ..write('id: $id, ')
          ..write('titulo: $titulo, ')
          ..write('isCompleted: $isCompleted')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $TareasTableTable tareasTable = $TareasTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [tareasTable];
}

typedef $$TareasTableTableCreateCompanionBuilder =
    TareasTableCompanion Function({
      Value<int> id,
      required String titulo,
      Value<bool> isCompleted,
    });
typedef $$TareasTableTableUpdateCompanionBuilder =
    TareasTableCompanion Function({
      Value<int> id,
      Value<String> titulo,
      Value<bool> isCompleted,
    });

class $$TareasTableTableFilterComposer
    extends Composer<_$AppDatabase, $TareasTableTable> {
  $$TareasTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get titulo => $composableBuilder(
    column: $table.titulo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isCompleted => $composableBuilder(
    column: $table.isCompleted,
    builder: (column) => ColumnFilters(column),
  );
}

class $$TareasTableTableOrderingComposer
    extends Composer<_$AppDatabase, $TareasTableTable> {
  $$TareasTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get titulo => $composableBuilder(
    column: $table.titulo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isCompleted => $composableBuilder(
    column: $table.isCompleted,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TareasTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $TareasTableTable> {
  $$TareasTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get titulo =>
      $composableBuilder(column: $table.titulo, builder: (column) => column);

  GeneratedColumn<bool> get isCompleted => $composableBuilder(
    column: $table.isCompleted,
    builder: (column) => column,
  );
}

class $$TareasTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TareasTableTable,
          TareasDB,
          $$TareasTableTableFilterComposer,
          $$TareasTableTableOrderingComposer,
          $$TareasTableTableAnnotationComposer,
          $$TareasTableTableCreateCompanionBuilder,
          $$TareasTableTableUpdateCompanionBuilder,
          (
            TareasDB,
            BaseReferences<_$AppDatabase, $TareasTableTable, TareasDB>,
          ),
          TareasDB,
          PrefetchHooks Function()
        > {
  $$TareasTableTableTableManager(_$AppDatabase db, $TareasTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TareasTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TareasTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TareasTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> titulo = const Value.absent(),
                Value<bool> isCompleted = const Value.absent(),
              }) => TareasTableCompanion(
                id: id,
                titulo: titulo,
                isCompleted: isCompleted,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String titulo,
                Value<bool> isCompleted = const Value.absent(),
              }) => TareasTableCompanion.insert(
                id: id,
                titulo: titulo,
                isCompleted: isCompleted,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$TareasTableTable, TareasDB>(table),
                  BaseReferences<_$AppDatabase, $TareasTableTable, TareasDB>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$TareasTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TareasTableTable,
      TareasDB,
      $$TareasTableTableFilterComposer,
      $$TareasTableTableOrderingComposer,
      $$TareasTableTableAnnotationComposer,
      $$TareasTableTableCreateCompanionBuilder,
      $$TareasTableTableUpdateCompanionBuilder,
      (TareasDB, BaseReferences<_$AppDatabase, $TareasTableTable, TareasDB>),
      TareasDB,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$TareasTableTableTableManager get tareasTable =>
      $$TareasTableTableTableManager(_db, _db.tareasTable);
}
