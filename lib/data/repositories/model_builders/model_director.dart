import 'package:waultar/core/models/index.dart';
import 'package:waultar/data/entities/content/event_objectbox.dart';
import 'package:waultar/data/entities/content/poll_objectbox.dart';
import 'package:waultar/data/entities/content/post_objectbox.dart';
import 'package:waultar/data/entities/media/file_objectbox.dart';
import 'package:waultar/data/entities/media/image_objectbox.dart';
import 'package:waultar/data/entities/media/link_objectbox.dart';
import 'package:waultar/data/entities/media/video_objectbox.dart';
import 'package:waultar/data/entities/misc/change_objectbox.dart';
import 'package:waultar/data/entities/misc/coordinate_objectbox.dart';
import 'package:waultar/data/entities/misc/email_objectbox.dart';
import 'package:waultar/data/entities/misc/person_objectbox.dart';
import 'package:waultar/data/entities/misc/place_objectbox.dart';
import 'package:waultar/data/entities/misc/service_objectbox.dart';
import 'package:waultar/data/entities/misc/tag_objectbox.dart';
import 'package:waultar/data/entities/profile/profile_objectbox.dart';

import 'builders/changemodel_builder.dart';
import 'builders/coordinatemodel_builder.dart';
import 'builders/emailmodel_builder.dart';
import 'builders/eventmodel_builder.dart';
import 'builders/mediamodel_builder.dart';
import 'builders/personmodel_builder.dart';
import 'builders/placemodel_builder.dart';
import 'builders/pollmodel_builder.dart';
import 'builders/postmodel_builders.dart';
import 'builders/profilemodel_builder.dart';
import 'builders/servicemodel_builder.dart';
import 'builders/tagmodel_builder.dart';
import 'i_model_director.dart';

class ModelDirector implements IModelDirector {
  @override
  T make<T>(dynamic entity) {
    if (entity == null) throw Exception("Entity cannot be null");

    switch (entity.runtimeType) {
      case ChangeModel:
        return makeChangeModel(entity as ChangeObjectBox) as T;

      case CoordinateModel:
        return makeCoordinateModel(entity as CoordinateObjectBox) as T;

      case EmailModel:
        return makeEmailModel(entity as EmailObjectBox) as T;

      case EventModel:
        return makeEventModel(entity as EventObjectBox) as T;

      case ImageModel:
        return makeImageModel(entity as ImageObjectBox) as T;

      case VideoModel:
        return makeVideoModel(entity as VideoObjectBox) as T;

      case FileModel:
        return makeFileModel(entity as FileObjectBox) as T;

      case LinkModel:
        return makeLinkModel(entity as LinkObjectBox) as T;

      case PersonModel:
        return makePersonModel(entity as PersonObjectBox) as T;

      case PlaceModel:
        return makePlaceModel(entity as PlaceObjectBox) as T;

      case PollModel:
        return makePollModel(entity as PollObjectBox) as T;

      case PostModel:
        return makePostModel(entity as PostObjectBox) as T;

      case ProfileModel:
        return makeProfileModel(entity as ProfileObjectBox) as T;

      case ServiceModel:
        return makeServiceModel(entity as ServiceObjectBox) as T;

      case TagModel:
        return makeTagModel(entity as TagObjectBox) as T;

      default:
        throw UnimplementedError(
            "Maker for ${entity.runtimeType} has not been implemented");
    }
  }
}
