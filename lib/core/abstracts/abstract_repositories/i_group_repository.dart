import 'package:waultar/core/models/index.dart';
import 'package:waultar/data/entities/content/group_objectbox.dart';

abstract class IGroupRepository {
  int addGroup(GroupModel group);
  void addMany(List<GroupModel> groups);
  int updateGroup(GroupModel group);
  GroupModel? getSingleGroup(int id);
  List<GroupModel>? getAllGroups();
  List<GroupModel>? getAllGroupsOwnedByUser();
  List<GroupObjectBox> getAllGroupsAsEntity();
  int removeAllGroups();
}
