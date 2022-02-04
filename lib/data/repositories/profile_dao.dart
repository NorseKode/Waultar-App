
import 'package:drift/drift.dart';
import 'package:waultar/core/abstracts/abstract_repositories/i_profile_repository.dart';
import 'package:waultar/core/models/profile_model.dart';
import 'package:waultar/data/configs/drift_config.dart';
import 'package:waultar/data/entities/profile_entity.dart';
import 'package:waultar/data/repositories/companion_mapper.dart';

part 'profile_dao.g.dart';

@DriftAccessor(tables: [ProfileEntity])
class ProfileDao extends DatabaseAccessor<WaultarDb> with _$ProfileDaoMixin implements IProfileRepository {
  ProfileDao(WaultarDb db) : super(db);

  @override
  Future<int> addProfile(ProfileModel profile) {
    var companion = toProfileCompanion(profile);
    return into(profileEntity).insert(companion);
  }

  @override
  Future<ProfileModel> getProfileById(int id) {
    return (select(profileEntity)..where((p) => p.id.equals(id))).getSingle();
  }

  @override
  Future<List<ProfileModel>> getAllProfiles() => select(profileEntity).get();
}