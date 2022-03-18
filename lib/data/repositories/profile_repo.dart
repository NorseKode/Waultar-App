import 'package:objectbox/objectbox.dart';
import 'package:waultar/core/abstracts/abstract_repositories/i_profile_repository.dart';
import 'package:waultar/core/models/profile/profile_model.dart';
import 'package:waultar/data/configs/objectbox.dart';
import 'package:waultar/data/entities/profile/profile_objectbox.dart';
import 'package:waultar/data/repositories/model_builders/i_model_director.dart';
import 'package:waultar/data/repositories/objectbox_builders/i_objectbox_director.dart';

class ProfileRepository implements IProfileRepository {
  
  late final ObjectBox _context;
  late final Box<ProfileObjectBox> _profileBox;
  late final IObjectBoxDirector _entityDirector;
  late final IModelDirector _modelDirector; 

  ProfileRepository(this._context, this._entityDirector, this._modelDirector) {
    _profileBox = _context.store.box<ProfileObjectBox>();
  }

  @override
  int addProfile(ProfileModel profile) {
    var entity = _entityDirector.make<ProfileObjectBox>(profile);
    int id = _profileBox.put(entity);
    return id;
  }

  @override
  List<ProfileModel> getAllProfiles() {
    var profiles = _profileBox.getAll();
    
    if (profiles.isEmpty) {
      return [];
    }

    var models = <ProfileModel>[];
    for (var profile in profiles) {
      var model = _modelDirector.make<ProfileModel>(profile);
      models.add(model);
    }

    return models;
  }

  @override
  ProfileModel getProfileById(int id) {
    var profile = _profileBox.get(id)!;
    return _modelDirector.make<ProfileModel>(profile);
  }

  @override
  int removeAllProfiles() {
    return _profileBox.removeAll();
  }

  @override
  int updateSingle(ProfileModel profile) {
    var entity = _profileBox.get(profile.id);

    if (entity == null) {
      throw ObjectBoxException("Tried to update a profile that doesn't exists: ${profile.toString()}");
    } else {
      var updatedEntity = _entityDirector.make<ProfileObjectBox>(profile);
      updatedEntity.id = entity.id;

      return _profileBox.put(updatedEntity);
    }
  }
}