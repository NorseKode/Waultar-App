import 'package:waultar/core/abstracts/abstract_repositories/i_group_repository.dart';
import 'package:waultar/core/models/content/group_model.dart';
import 'package:waultar/data/configs/objectbox.dart';
import 'package:waultar/data/configs/objectbox.g.dart';
import 'package:waultar/data/entities/content/group_objectbox.dart';
import 'package:waultar/data/repositories/model_builders/i_model_director.dart';
import 'package:waultar/data/repositories/objectbox_builders/i_objectbox_director.dart';

class GroupRepository implements IGroupRepository {
  late final ObjectBox _context;
  late final Box<GroupObjectBox> _groupBox;
  late final IObjectBoxDirector _entityDirector;
  late final IModelDirector _modelDirector;

  GroupRepository(this._context, this._entityDirector, this._modelDirector) {
    _groupBox = _context.store.box<GroupObjectBox>();
  }

  @override
  int addGroup(GroupModel group) {
    var entity = _entityDirector.make<GroupObjectBox>(group);
    int id = _groupBox.put(entity);
    return id;
  }

  @override
  void addMany(List<GroupModel> groups) {
    var entities =
        groups.map((g) => _entityDirector.make<GroupObjectBox>(g)).toList();
    _groupBox.putMany(entities);
  }

  @override
  int updateGroup(GroupModel group) {
    var entity = _groupBox
        .query(GroupObjectBox_.name.equals(group.name))
        .build()
        .findFirst();

    if (entity != null) {
      entity.isUsers = group.isUsers;
      entity.badge = group.badge;

      return _groupBox.put(entity);
    } else {
      return -1;
    }
  }

  @override
  GroupModel? getSingleGroup(int id) {
    var entity = _groupBox.get(id);
    if (entity != null) {
      var model = _modelDirector.make<GroupModel>(entity);
      return model;
    } else {
      return null;
    }
  }

  @override
  List<GroupModel>? getAllGroups() {
    var groupEntities = _groupBox.getAll();
    if (groupEntities.isNotEmpty) {
      return groupEntities
          .map((g) => _modelDirector.make<GroupModel>(g))
          .toList();
    } else {
      return null;
    }
  }

  @override
  List<GroupModel>? getAllGroupsOwnedByUser() {
    var groupEntities =
        _groupBox.query(GroupObjectBox_.isUsers.equals(true)).build().find();
    if (groupEntities.isNotEmpty) {
      return groupEntities
          .map((g) => _modelDirector.make<GroupModel>(g))
          .toList();
    } else {
      return null;
    }
  }

  @override
  int removeAllGroups() => _groupBox.removeAll();

  @override
  List<GroupObjectBox> getAllGroupsAsEntity() {
    return _groupBox.getAll();
  }
}
