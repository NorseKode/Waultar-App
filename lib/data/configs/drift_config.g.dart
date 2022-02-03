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

class ProfileEntityCompanion extends UpdateCompanion<ProfileModel> {
  final Value<int> id;
  final Value<String> username;
  final Value<String> name;
  final Value<String> email;
  final Value<String> gender;
  final Value<String> bio;
  final Value<String> phoneNumber;
  final Value<DateTime> dateOfBirth;
  final Value<String> profileUri;
  final Value<String> raw;
  const ProfileEntityCompanion({
    this.id = const Value.absent(),
    this.username = const Value.absent(),
    this.name = const Value.absent(),
    this.email = const Value.absent(),
    this.gender = const Value.absent(),
    this.bio = const Value.absent(),
    this.phoneNumber = const Value.absent(),
    this.dateOfBirth = const Value.absent(),
    this.profileUri = const Value.absent(),
    this.raw = const Value.absent(),
  });
  ProfileEntityCompanion.insert({
    this.id = const Value.absent(),
    this.username = const Value.absent(),
    this.name = const Value.absent(),
    this.email = const Value.absent(),
    this.gender = const Value.absent(),
    this.bio = const Value.absent(),
    this.phoneNumber = const Value.absent(),
    required DateTime dateOfBirth,
    this.profileUri = const Value.absent(),
    required String raw,
  })  : dateOfBirth = Value(dateOfBirth),
        raw = Value(raw);
  static Insertable<ProfileModel> custom({
    Expression<int>? id,
    Expression<String>? username,
    Expression<String>? name,
    Expression<String>? email,
    Expression<String>? gender,
    Expression<String>? bio,
    Expression<String>? phoneNumber,
    Expression<DateTime>? dateOfBirth,
    Expression<String>? profileUri,
    Expression<String>? raw,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (username != null) 'username': username,
      if (name != null) 'name': name,
      if (email != null) 'email': email,
      if (gender != null) 'gender': gender,
      if (bio != null) 'bio': bio,
      if (phoneNumber != null) 'phone_number': phoneNumber,
      if (dateOfBirth != null) 'date_of_birth': dateOfBirth,
      if (profileUri != null) 'profile_uri': profileUri,
      if (raw != null) 'raw': raw,
    });
  }

  ProfileEntityCompanion copyWith(
      {Value<int>? id,
      Value<String>? username,
      Value<String>? name,
      Value<String>? email,
      Value<String>? gender,
      Value<String>? bio,
      Value<String>? phoneNumber,
      Value<DateTime>? dateOfBirth,
      Value<String>? profileUri,
      Value<String>? raw}) {
    return ProfileEntityCompanion(
      id: id ?? this.id,
      username: username ?? this.username,
      name: name ?? this.name,
      email: email ?? this.email,
      gender: gender ?? this.gender,
      bio: bio ?? this.bio,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      profileUri: profileUri ?? this.profileUri,
      raw: raw ?? this.raw,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (username.present) {
      map['username'] = Variable<String>(username.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (gender.present) {
      map['gender'] = Variable<String>(gender.value);
    }
    if (bio.present) {
      map['bio'] = Variable<String>(bio.value);
    }
    if (phoneNumber.present) {
      map['phone_number'] = Variable<String>(phoneNumber.value);
    }
    if (dateOfBirth.present) {
      map['date_of_birth'] = Variable<DateTime>(dateOfBirth.value);
    }
    if (profileUri.present) {
      map['profile_uri'] = Variable<String>(profileUri.value);
    }
    if (raw.present) {
      map['raw'] = Variable<String>(raw.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProfileEntityCompanion(')
          ..write('id: $id, ')
          ..write('username: $username, ')
          ..write('name: $name, ')
          ..write('email: $email, ')
          ..write('gender: $gender, ')
          ..write('bio: $bio, ')
          ..write('phoneNumber: $phoneNumber, ')
          ..write('dateOfBirth: $dateOfBirth, ')
          ..write('profileUri: $profileUri, ')
          ..write('raw: $raw')
          ..write(')'))
        .toString();
  }
}

class $ProfileEntityTable extends ProfileEntity
    with TableInfo<$ProfileEntityTable, ProfileModel> {
  final GeneratedDatabase _db;
  final String? _alias;
  $ProfileEntityTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      typeName: 'INTEGER',
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _usernameMeta = const VerificationMeta('username');
  late final GeneratedColumn<String?> username = GeneratedColumn<String?>(
      'username', aliasedName, false,
      typeName: 'TEXT',
      requiredDuringInsert: false,
      defaultValue: const Constant('unknown'));
  final VerificationMeta _nameMeta = const VerificationMeta('name');
  late final GeneratedColumn<String?> name = GeneratedColumn<String?>(
      'name', aliasedName, false,
      typeName: 'TEXT',
      requiredDuringInsert: false,
      defaultValue: const Constant('unknown'));
  final VerificationMeta _emailMeta = const VerificationMeta('email');
  late final GeneratedColumn<String?> email = GeneratedColumn<String?>(
      'email', aliasedName, false,
      typeName: 'TEXT',
      requiredDuringInsert: false,
      defaultValue: const Constant('unknown'));
  final VerificationMeta _genderMeta = const VerificationMeta('gender');
  late final GeneratedColumn<String?> gender = GeneratedColumn<String?>(
      'gender', aliasedName, false,
      typeName: 'TEXT',
      requiredDuringInsert: false,
      defaultValue: const Constant('unknown'));
  final VerificationMeta _bioMeta = const VerificationMeta('bio');
  late final GeneratedColumn<String?> bio = GeneratedColumn<String?>(
      'bio', aliasedName, false,
      typeName: 'TEXT',
      requiredDuringInsert: false,
      defaultValue: const Constant('unknown'));
  final VerificationMeta _phoneNumberMeta =
      const VerificationMeta('phoneNumber');
  late final GeneratedColumn<String?> phoneNumber = GeneratedColumn<String?>(
      'phone_number', aliasedName, false,
      typeName: 'TEXT',
      requiredDuringInsert: false,
      defaultValue: const Constant('unknown'));
  final VerificationMeta _dateOfBirthMeta =
      const VerificationMeta('dateOfBirth');
  late final GeneratedColumn<DateTime?> dateOfBirth =
      GeneratedColumn<DateTime?>('date_of_birth', aliasedName, false,
          typeName: 'INTEGER', requiredDuringInsert: true);
  final VerificationMeta _profileUriMeta = const VerificationMeta('profileUri');
  late final GeneratedColumn<String?> profileUri = GeneratedColumn<String?>(
      'profile_uri', aliasedName, false,
      typeName: 'TEXT',
      requiredDuringInsert: false,
      defaultValue: const Constant('unknown'));
  final VerificationMeta _rawMeta = const VerificationMeta('raw');
  late final GeneratedColumn<String?> raw = GeneratedColumn<String?>(
      'raw', aliasedName, false,
      typeName: 'TEXT', requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        username,
        name,
        email,
        gender,
        bio,
        phoneNumber,
        dateOfBirth,
        profileUri,
        raw
      ];
  @override
  String get aliasedName => _alias ?? 'profiles';
  @override
  String get actualTableName => 'profiles';
  @override
  VerificationContext validateIntegrity(Insertable<ProfileModel> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('username')) {
      context.handle(_usernameMeta,
          username.isAcceptableOrUnknown(data['username']!, _usernameMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    }
    if (data.containsKey('email')) {
      context.handle(
          _emailMeta, email.isAcceptableOrUnknown(data['email']!, _emailMeta));
    }
    if (data.containsKey('gender')) {
      context.handle(_genderMeta,
          gender.isAcceptableOrUnknown(data['gender']!, _genderMeta));
    }
    if (data.containsKey('bio')) {
      context.handle(
          _bioMeta, bio.isAcceptableOrUnknown(data['bio']!, _bioMeta));
    }
    if (data.containsKey('phone_number')) {
      context.handle(
          _phoneNumberMeta,
          phoneNumber.isAcceptableOrUnknown(
              data['phone_number']!, _phoneNumberMeta));
    }
    if (data.containsKey('date_of_birth')) {
      context.handle(
          _dateOfBirthMeta,
          dateOfBirth.isAcceptableOrUnknown(
              data['date_of_birth']!, _dateOfBirthMeta));
    } else if (isInserting) {
      context.missing(_dateOfBirthMeta);
    }
    if (data.containsKey('profile_uri')) {
      context.handle(
          _profileUriMeta,
          profileUri.isAcceptableOrUnknown(
              data['profile_uri']!, _profileUriMeta));
    }
    if (data.containsKey('raw')) {
      context.handle(
          _rawMeta, raw.isAcceptableOrUnknown(data['raw']!, _rawMeta));
    } else if (isInserting) {
      context.missing(_rawMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ProfileModel map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProfileModel(
      const IntType().mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}username'])!,
      const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}name'])!,
      const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}email'])!,
      const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}gender'])!,
      const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}bio'])!,
      const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}phone_number'])!,
      const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}date_of_birth'])!,
      const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}profile_uri'])!,
      const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}raw'])!,
    );
  }

  @override
  $ProfileEntityTable createAlias(String alias) {
    return $ProfileEntityTable(_db, alias);
  }
}

abstract class _$WaultarDb extends GeneratedDatabase {
  _$WaultarDb(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $AppSettingsEntityTable appSettingsEntity =
      $AppSettingsEntityTable(this);
  late final $ImageEntityTable imageEntity = $ImageEntityTable(this);
  late final $ProfileEntityTable profileEntity = $ProfileEntityTable(this);
  late final AppSettingsDao appSettingsDao = AppSettingsDao(this as WaultarDb);
  late final ImageDao imageDao = ImageDao(this as WaultarDb);
  late final ProfileDao profileDao = ProfileDao(this as WaultarDb);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [appSettingsEntity, imageEntity, profileEntity];
}
