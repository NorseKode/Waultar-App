import 'package:waultar/data/entities/content/event_objectbox.dart';
import 'package:waultar/data/entities/content/post_event_objectbox.dart';
import 'package:waultar/data/entities/content/post_life_event_objectbox.dart';
import 'package:waultar/data/entities/content/post_objectbox.dart';
import 'package:waultar/data/entities/content/post_poll_objectbox.dart';
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
import 'package:waultar/data/repositories/model_builders/builders/postlifeevent_builder.dart';

import 'builders/changemodel_builder.dart';
import 'builders/coordinatemodel_builder.dart';
import 'builders/emailmodel_builder.dart';
import 'builders/eventmodel_builder.dart';
import 'builders/mediamodel_builder.dart';
import 'builders/personmodel_builder.dart';
import 'builders/placemodel_builder.dart';
import 'builders/postevent_builder.dart';
import 'builders/postmodel_builders.dart';
import 'builders/postpoll_builder.dart';
import 'builders/profilemodel_builder.dart';
import 'builders/servicemodel_builder.dart';
import 'builders/tagmodel_builder.dart';
import 'i_model_director.dart';

class ModelDirector implements IModelDirector {
  @override
  T make<T>(dynamic entity) {
    if (entity == null) throw Exception("Entity cannot be null");

    switch (entity.runtimeType) {
      // everything content related
      case EventObjectBox:
        return makeEventModel(entity as EventObjectBox) as T;

      // everything media related
      case ImageObjectBox:
        return makeImageModel(entity as ImageObjectBox) as T;

      case VideoObjectBox:
        return makeVideoModel(entity as VideoObjectBox) as T;

      case FileObjectBox:
        return makeFileModel(entity as FileObjectBox) as T;

      case LinkObjectBox:
        return makeLinkModel(entity as LinkObjectBox) as T;

      // everything misc related
      case ChangeObjectBox:
        return makeChangeModel(entity as ChangeObjectBox) as T;

      case CoordinateObjectBox:
        return makeCoordinateModel(entity as CoordinateObjectBox) as T;

      case EmailObjectBox:
        return makeEmailModel(entity as EmailObjectBox) as T;

      case PersonObjectBox:
        return makePersonModel(entity as PersonObjectBox) as T;

      case PlaceObjectBox:
        return makePlaceModel(entity as PlaceObjectBox) as T;

      case ServiceObjectBox:
        return makeServiceModel(entity as ServiceObjectBox) as T;

      case TagObjectBox:
        return makeTagModel(entity as TagObjectBox) as T;
        
      // everything post related
      case PostObjectBox:
        return makePostModel(entity as PostObjectBox) as T;

      case PostEventObjectBox:
        return makePostEventModel(entity as PostEventObjectBox) as T;

      // case PostGroupObjectBox:
      //   return makePostGroupModel() as T;

      case PostLifeEventObjectBox:
        return makePostLifeEventModel(entity as PostLifeEventObjectBox) as T;

      case PostPollObjectBox:
        return makePostPollModel(entity) as T;

      // everything profile related
      case ProfileObjectBox:
        return makeProfileModel(entity as ProfileObjectBox) as T;


      default:
        throw UnimplementedError(
            "Maker for ${entity.runtimeType} has not been implemented");
    }
  }
}
