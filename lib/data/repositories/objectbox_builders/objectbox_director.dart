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
        
      default:
        throw UnimplementedError("Maker for ${model.runtimeType} has not been implemented"); 
    }

  }  
}
