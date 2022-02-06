// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: camel_case_types

import 'dart:typed_data';

import 'package:objectbox/flatbuffers/flat_buffers.dart' as fb;
import 'package:objectbox/internal.dart'; // generated code can access "internal" functionality
import 'package:objectbox/objectbox.dart';
import 'package:objectbox_flutter_libs/objectbox_flutter_libs.dart';

import '../../core/models/facebook_post_model.dart';
import '../../data/entities/appsettings_entity.dart';

export 'package:objectbox/objectbox.dart'; // so that callers only have to import this file

final _entities = <ModelEntity>[
  ModelEntity(
      id: const IdUid(1, 2148786199038735847),
      name: 'AppSettingsBox',
      lastPropertyId: const IdUid(2, 849533903163781586),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 9155762340551357005),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 849533903163781586),
            name: 'darkmode',
            type: 1,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[]),
  ModelEntity(
      id: const IdUid(2, 1837511870469432447),
      name: 'FacebookPostModel',
      lastPropertyId: const IdUid(4, 2600227792391331024),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 219800542496953078),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 7926224797411893663),
            name: 'description',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 6880580214941458863),
            name: 'title',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(4, 2600227792391331024),
            name: 'timestamp',
            type: 10,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[])
];

/// Open an ObjectBox store with the model declared in this file.
Future<Store> openStore(
        {String? directory,
        int? maxDBSizeInKB,
        int? fileMode,
        int? maxReaders,
        bool queriesCaseSensitiveDefault = true,
        String? macosApplicationGroup}) async =>
    Store(getObjectBoxModel(),
        directory: directory ?? (await defaultStoreDirectory()).path,
        maxDBSizeInKB: maxDBSizeInKB,
        fileMode: fileMode,
        maxReaders: maxReaders,
        queriesCaseSensitiveDefault: queriesCaseSensitiveDefault,
        macosApplicationGroup: macosApplicationGroup);

/// ObjectBox model definition, pass it to [Store] - Store(getObjectBoxModel())
ModelDefinition getObjectBoxModel() {
  final model = ModelInfo(
      entities: _entities,
      lastEntityId: const IdUid(2, 1837511870469432447),
      lastIndexId: const IdUid(0, 0),
      lastRelationId: const IdUid(0, 0),
      lastSequenceId: const IdUid(0, 0),
      retiredEntityUids: const [],
      retiredIndexUids: const [],
      retiredPropertyUids: const [],
      retiredRelationUids: const [],
      modelVersion: 5,
      modelVersionParserMinimum: 5,
      version: 1);

  final bindings = <Type, EntityDefinition>{
    AppSettingsBox: EntityDefinition<AppSettingsBox>(
        model: _entities[0],
        toOneRelations: (AppSettingsBox object) => [],
        toManyRelations: (AppSettingsBox object) => {},
        getId: (AppSettingsBox object) => object.id,
        setId: (AppSettingsBox object, int id) {
          object.id = id;
        },
        objectToFB: (AppSettingsBox object, fb.Builder fbb) {
          fbb.startTable(3);
          fbb.addInt64(0, object.id);
          fbb.addBool(1, object.darkmode);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = AppSettingsBox(
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0),
              const fb.BoolReader().vTableGet(buffer, rootOffset, 6, false));

          return object;
        }),
    FacebookPostModel: EntityDefinition<FacebookPostModel>(
        model: _entities[1],
        toOneRelations: (FacebookPostModel object) => [],
        toManyRelations: (FacebookPostModel object) => {},
        getId: (FacebookPostModel object) => object.id,
        setId: (FacebookPostModel object, int id) {
          object.id = id;
        },
        objectToFB: (FacebookPostModel object, fb.Builder fbb) {
          final descriptionOffset = object.description == null
              ? null
              : fbb.writeString(object.description!);
          final titleOffset =
              object.title == null ? null : fbb.writeString(object.title!);
          fbb.startTable(5);
          fbb.addInt64(0, object.id);
          fbb.addOffset(1, descriptionOffset);
          fbb.addOffset(2, titleOffset);
          fbb.addInt64(3, object.timestamp.millisecondsSinceEpoch);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = FacebookPostModel(
              const fb.StringReader().vTableGetNullable(buffer, rootOffset, 6),
              const fb.StringReader().vTableGetNullable(buffer, rootOffset, 8),
              DateTime.fromMillisecondsSinceEpoch(
                  const fb.Int64Reader().vTableGet(buffer, rootOffset, 10, 0)))
            ..id = const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0);

          return object;
        })
  };

  return ModelDefinition(model, bindings);
}

/// [AppSettingsBox] entity fields to define ObjectBox queries.
class AppSettingsBox_ {
  /// see [AppSettingsBox.id]
  static final id =
      QueryIntegerProperty<AppSettingsBox>(_entities[0].properties[0]);

  /// see [AppSettingsBox.darkmode]
  static final darkmode =
      QueryBooleanProperty<AppSettingsBox>(_entities[0].properties[1]);
}

/// [FacebookPostModel] entity fields to define ObjectBox queries.
class FacebookPostModel_ {
  /// see [FacebookPostModel.id]
  static final id =
      QueryIntegerProperty<FacebookPostModel>(_entities[1].properties[0]);

  /// see [FacebookPostModel.description]
  static final description =
      QueryStringProperty<FacebookPostModel>(_entities[1].properties[1]);

  /// see [FacebookPostModel.title]
  static final title =
      QueryStringProperty<FacebookPostModel>(_entities[1].properties[2]);

  /// see [FacebookPostModel.timestamp]
  static final timestamp =
      QueryIntegerProperty<FacebookPostModel>(_entities[1].properties[3]);
}
