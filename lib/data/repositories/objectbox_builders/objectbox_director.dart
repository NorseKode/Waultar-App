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
        return makePost(model as PostModel, _context) as T;

      case EventModel:
        return makeEvent(model as EventModel, _context) as T;

      case PollModel:
        return makePoll(model as PollModel, _context) as T;

      case ImageModel:
        return makeImage(model as ImageModel, _context) as T;

      case VideoModel:
        return makeVideo(model as VideoModel, _context) as T;

      case LinkModel:
        return makeLink(model as LinkModel, _context) as T;

      case FileModel:
        return makeFile(model as FileModel, _context) as T;

      case PersonModel:
        return makePerson(model as PersonModel, _context) as T;

      case TagModel:
        return makeTag(model as TagModel, _context) as T;

      case PlaceModel:
        return makePlace(model as PlaceModel, _context) as T;

      case CoordinateModel:
        return makeCoordinate(model as CoordinateModel, _context) as T;

      default:
        throw UnimplementedError(
            "Maker for ${model.runtimeType} has not been implemented");
    }
  }
}
