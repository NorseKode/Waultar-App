// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drift_config.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class AppSettingsEntityCompanion extends UpdateCompanion<AppSettingsModel> {
  final Value<int> key;
  final Value<bool> darkmode;
  const AppSettingsEntityCompanion({
    this.key = const Value.absent(),
    this.darkmode = const Value.absent(),
  });
  AppSettingsEntityCompanion.insert({
    this.key = const Value.absent(),
    required bool darkmode,
  }) : darkmode = Value(darkmode);
  static Insertable<AppSettingsModel> custom({
    Expression<int>? key,
    Expression<bool>? darkmode,
  }) {
    return RawValuesInsertable({
      if (key != null) 'key': key,
      if (darkmode != null) 'darkmode': darkmode,
    });
  }

  AppSettingsEntityCompanion copyWith(
      {Value<int>? key, Value<bool>? darkmode}) {
    return AppSettingsEntityCompanion(
      key: key ?? this.key,
      darkmode: darkmode ?? this.darkmode,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (key.present) {
      map['key'] = Variable<int>(key.value);
    }
    if (darkmode.present) {
      map['darkmode'] = Variable<bool>(darkmode.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppSettingsEntityCompanion(')
          ..write('key: $key, ')
          ..write('darkmode: $darkmode')
          ..write(')'))
        .toString();
  }
}

class $AppSettingsEntityTable extends AppSettingsEntity
    with TableInfo<$AppSettingsEntityTable, AppSettingsModel> {
  final GeneratedDatabase _db;
  final String? _alias;
  $AppSettingsEntityTable(this._db, [this._alias]);
  final VerificationMeta _keyMeta = const VerificationMeta('key');
  late final GeneratedColumn<int?> key = GeneratedColumn<int?>(
      'key', aliasedName, false,
      typeName: 'INTEGER',
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL CHECK (key = 1)');
  final VerificationMeta _darkmodeMeta = const VerificationMeta('darkmode');
  late final GeneratedColumn<bool?> darkmode = GeneratedColumn<bool?>(
      'darkmode', aliasedName, false,
      typeName: 'INTEGER',
      requiredDuringInsert: true,
      defaultConstraints: 'CHECK (darkmode IN (0, 1))');
  @override
  List<GeneratedColumn> get $columns => [key, darkmode];
  @override
  String get aliasedName => _alias ?? 'appSettings';
  @override
  String get actualTableName => 'appSettings';
  @override
  VerificationContext validateIntegrity(Insertable<AppSettingsModel> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('key')) {
      context.handle(
          _keyMeta, key.isAcceptableOrUnknown(data['key']!, _keyMeta));
    }
    if (data.containsKey('darkmode')) {
      context.handle(_darkmodeMeta,
          darkmode.isAcceptableOrUnknown(data['darkmode']!, _darkmodeMeta));
    } else if (isInserting) {
      context.missing(_darkmodeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {key};
  @override
  AppSettingsModel map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AppSettingsModel(
      const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}darkmode'])!,
    );
  }

  @override
  $AppSettingsEntityTable createAlias(String alias) {
    return $AppSettingsEntityTable(_db, alias);
  }
}

class ImageEntityCompanion extends UpdateCompanion<ImageModel> {
  final Value<int> id;
  final Value<String> path;
  final Value<String> raw;
  final Value<DateTime> timestamp;
  const ImageEntityCompanion({
    this.id = const Value.absent(),
    this.path = const Value.absent(),
    this.raw = const Value.absent(),
    this.timestamp = const Value.absent(),
  });
  ImageEntityCompanion.insert({
    this.id = const Value.absent(),
    required String path,
    required String raw,
    required DateTime timestamp,
  })  : path = Value(path),
        raw = Value(raw),
        timestamp = Value(timestamp);
  static Insertable<ImageModel> custom({
    Expression<int>? id,
    Expression<String>? path,
    Expression<String>? raw,
    Expression<DateTime>? timestamp,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (path != null) 'path': path,
      if (raw != null) 'raw': raw,
      if (timestamp != null) 'timestamp': timestamp,
    });
  }

  ImageEntityCompanion copyWith(
      {Value<int>? id,
      Value<String>? path,
      Value<String>? raw,
      Value<DateTime>? timestamp}) {
    return ImageEntityCompanion(
      id: id ?? this.id,
      path: path ?? this.path,
      raw: raw ?? this.raw,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (path.present) {
      map['path'] = Variable<String>(path.value);
    }
    if (raw.present) {
      map['raw'] = Variable<String>(raw.value);
    }
    if (timestamp.present) {
      map['timestamp'] = Variable<DateTime>(timestamp.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ImageEntityCompanion(')
          ..write('id: $id, ')
          ..write('path: $path, ')
          ..write('raw: $raw, ')
          ..write('timestamp: $timestamp')
          ..write(')'))
        .toString();
  }
}

class $ImageEntityTable extends ImageEntity
    with TableInfo<$ImageEntityTable, ImageModel> {
  final GeneratedDatabase _db;
  final String? _alias;
  $ImageEntityTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      typeName: 'INTEGER',
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _pathMeta = const VerificationMeta('path');
  late final GeneratedColumn<String?> path = GeneratedColumn<String?>(
      'path', aliasedName, false,
      typeName: 'TEXT', requiredDuringInsert: true);
  final VerificationMeta _rawMeta = const VerificationMeta('raw');
  late final GeneratedColumn<String?> raw = GeneratedColumn<String?>(
      'raw', aliasedName, false,
      typeName: 'TEXT', requiredDuringInsert: true);
  final VerificationMeta _timestampMeta = const VerificationMeta('timestamp');
  late final GeneratedColumn<DateTime?> timestamp = GeneratedColumn<DateTime?>(
      'timestamp', aliasedName, false,
      typeName: 'INTEGER', requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, path, raw, timestamp];
  @override
  String get aliasedName => _alias ?? 'images';
  @override
  String get actualTableName => 'images';
  @override
  VerificationContext validateIntegrity(Insertable<ImageModel> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('path')) {
      context.handle(
          _pathMeta, path.isAcceptableOrUnknown(data['path']!, _pathMeta));
    } else if (isInserting) {
      context.missing(_pathMeta);
    }
    if (data.containsKey('raw')) {
      context.handle(
          _rawMeta, raw.isAcceptableOrUnknown(data['raw']!, _rawMeta));
    } else if (isInserting) {
      context.missing(_rawMeta);
    }
    if (data.containsKey('timestamp')) {
      context.handle(_timestampMeta,
          timestamp.isAcceptableOrUnknown(data['timestamp']!, _timestampMeta));
    } else if (isInserting) {
      context.missing(_timestampMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ImageModel map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ImageModel(
      const IntType().mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}path'])!,
      const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}raw'])!,
      const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}timestamp'])!,
    );
  }

  @override
  $ImageEntityTable createAlias(String alias) {
    return $ImageEntityTable(_db, alias);
  }
}

abstract class _$WaultarDb extends GeneratedDatabase {
  _$WaultarDb(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $AppSettingsEntityTable appSettingsEntity =
      $AppSettingsEntityTable(this);
  late final $ImageEntityTable imageEntity = $ImageEntityTable(this);
  late final AppSettingsDao appSettingsDao = AppSettingsDao(this as WaultarDb);
  late final ImageDao imageDao = ImageDao(this as WaultarDb);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [appSettingsEntity, imageEntity];
}
