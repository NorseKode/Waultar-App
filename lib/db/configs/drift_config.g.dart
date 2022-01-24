// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drift_config.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class UserSettings extends DataClass implements Insertable<UserSettings> {
  final int key;
  final bool darkmode;
  UserSettings({required this.key, required this.darkmode});
  factory UserSettings.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return UserSettings(
      key: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}key'])!,
      darkmode: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}darkmode'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['key'] = Variable<int>(key);
    map['darkmode'] = Variable<bool>(darkmode);
    return map;
  }

  UserAppSettingsCompanion toCompanion(bool nullToAbsent) {
    return UserAppSettingsCompanion(
      key: Value(key),
      darkmode: Value(darkmode),
    );
  }

  factory UserSettings.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserSettings(
      key: serializer.fromJson<int>(json['key']),
      darkmode: serializer.fromJson<bool>(json['darkmode']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'key': serializer.toJson<int>(key),
      'darkmode': serializer.toJson<bool>(darkmode),
    };
  }

  UserSettings copyWith({int? key, bool? darkmode}) => UserSettings(
        key: key ?? this.key,
        darkmode: darkmode ?? this.darkmode,
      );
  @override
  String toString() {
    return (StringBuffer('UserSettings(')
          ..write('key: $key, ')
          ..write('darkmode: $darkmode')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(key, darkmode);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserSettings &&
          other.key == this.key &&
          other.darkmode == this.darkmode);
}

class UserAppSettingsCompanion extends UpdateCompanion<UserSettings> {
  final Value<int> key;
  final Value<bool> darkmode;
  const UserAppSettingsCompanion({
    this.key = const Value.absent(),
    this.darkmode = const Value.absent(),
  });
  UserAppSettingsCompanion.insert({
    this.key = const Value.absent(),
    required bool darkmode,
  }) : darkmode = Value(darkmode);
  static Insertable<UserSettings> custom({
    Expression<int>? key,
    Expression<bool>? darkmode,
  }) {
    return RawValuesInsertable({
      if (key != null) 'key': key,
      if (darkmode != null) 'darkmode': darkmode,
    });
  }

  UserAppSettingsCompanion copyWith({Value<int>? key, Value<bool>? darkmode}) {
    return UserAppSettingsCompanion(
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
    return (StringBuffer('UserAppSettingsCompanion(')
          ..write('key: $key, ')
          ..write('darkmode: $darkmode')
          ..write(')'))
        .toString();
  }
}

class $UserAppSettingsTable extends UserAppSettings
    with TableInfo<$UserAppSettingsTable, UserSettings> {
  final GeneratedDatabase _db;
  final String? _alias;
  $UserAppSettingsTable(this._db, [this._alias]);
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
  String get aliasedName => _alias ?? 'user_app_settings';
  @override
  String get actualTableName => 'user_app_settings';
  @override
  VerificationContext validateIntegrity(Insertable<UserSettings> instance,
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
  UserSettings map(Map<String, dynamic> data, {String? tablePrefix}) {
    return UserSettings.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $UserAppSettingsTable createAlias(String alias) {
    return $UserAppSettingsTable(_db, alias);
  }
}

abstract class _$WaultarDb extends GeneratedDatabase {
  _$WaultarDb(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $UserAppSettingsTable userAppSettings =
      $UserAppSettingsTable(this);
  late final UserSettingsDao userSettingsDao =
      UserSettingsDao(this as WaultarDb);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [userAppSettings];
}
