import 'package:waultar/core/models/index.dart';
import 'package:waultar/data/configs/objectbox.dart';
import 'package:waultar/data/repositories/objectbox_builders/i_objectbox_director.dart';

import 'builders/index.dart';

class ObjectBoxDirector implements IObjectBoxDirector {
  late final ObjectBox _context;

  ObjectBoxDirector(this._context);

  @override
  T make<T>(dynamic model) {
    if (model == null) throw Exception("Model cannot be null");

    switch (model.runtimeType) {
      case PostModel:
        return makePostEntity(model as PostModel, _context) as T;

      case EventModel:
        return makeEventEntity(model as EventModel, _context) as T;

      case PollModel:
        return makePollEntity(model as PollModel, _context) as T;

      case ImageModel:
        return makeImageEntity(model as ImageModel, _context) as T;

      case VideoModel:
        return makeVideoEntity(model as VideoModel, _context) as T;

      case LinkModel:
        return makeLinkEntity(model as LinkModel, _context) as T;

      case FileModel:
        return makeFileEntity(model as FileModel, _context) as T;

      case PersonModel:
        return makePersonEntity(model as PersonModel, _context) as T;

      case TagModel:
        return makeTagEntity(model as TagModel, _context) as T;

      case PlaceModel:
        return makePlaceEntity(model as PlaceModel, _context) as T;

      case CoordinateModel:
        return makeCoordinateEntity(model as CoordinateModel, _context) as T;

      default:
        throw UnimplementedError(
            "Maker for ${model.runtimeType} has not been implemented");
    }
  }
}
