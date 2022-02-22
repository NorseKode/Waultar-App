import 'package:waultar/core/models/index.dart';

abstract class ILinkRepository {
  int addLink(LinkModel link);
  LinkModel? getLinkById(int id);
  List<LinkModel>? getAllLinks();
  List<LinkModel>? getAllLinksByService(ServiceModel service);
  List<LinkModel>? getAllLinksByProfile(ProfileModel profile);
  int removeAll();
}