import 'package:waultar/core/models/index.dart';

abstract class IGroupRepository {
  int addGroup(GroupModel group);
  void addMany(List<GroupModel> groups);
  GroupModel? getSingleGroup(int id);
  List<GroupModel>? getAllGroups();
  List<GroupModel>? getAllGroupsOwnedByUser();
  int removeAllGroups();
}
