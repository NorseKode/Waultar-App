import 'package:waultar/core/models/index.dart';

import 'i_model_director.dart';

class ModelDirector implements IModelDirector {
  @override
  T make<T>(dynamic entity) {
    if (entity == null) throw Exception("Entity cannot be null");

    switch (entity.runtimeType) {
      case PostModel:

      default:
        throw UnimplementedError(
            "Maker for ${entity.runtimeType} has not been implemented");
    }
  }
}
