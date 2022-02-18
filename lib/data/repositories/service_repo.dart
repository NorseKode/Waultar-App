import 'package:waultar/core/abstracts/abstract_repositories/i_post_repository.dart';
import 'package:waultar/core/abstracts/abstract_repositories/i_service_repository.dart';
import 'package:waultar/core/models/index.dart';
import 'package:waultar/data/configs/objectbox.dart';
import 'package:waultar/data/configs/objectbox.g.dart';
import 'package:waultar/data/entities/content/post_objectbox.dart';
import 'package:waultar/data/entities/misc/service_objectbox.dart';
import 'package:waultar/data/repositories/model_builders/i_model_director.dart';
import 'package:waultar/data/repositories/objectbox_builders/i_objectbox_director.dart';

class ServiceRepo implements IServiceRepository {
  late final ObjectBox _context;
  late final Box<ServiceObjectBox> _serviceBox;
  late final IObjectBoxDirector _entityDirector;
  late final IModelDirector _modelDirector;

  ServiceRepo(this._context, this._entityDirector, this._modelDirector) {
    _serviceBox = _context.store.box<ServiceObjectBox>();
  }

  @override
  ServiceModel? get(String name) {
    var entity = _serviceBox.query(ServiceObjectBox_.name.equals(name)).build().findUnique();
    if (entity != null) {
      return _modelDirector.make<ServiceModel>(entity);
    } else {
      return null;
    }
  }

  @override
  List<ServiceModel> getAll() {
    return _serviceBox.getAll().map((e) => _modelDirector.make<ServiceModel>(e)).toList();
  }
}
