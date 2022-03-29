import 'package:objectbox/objectbox.dart';
import 'package:waultar/data/entities/misc/profile_document.dart';
import 'package:waultar/data/entities/nodes/datapoint_node.dart';

@Entity()
class LinkDocument {
  int id;
  String uri;
  String data;
  String? searchString;

  // chrome serach history can link to the same url many times,
  // perhaps we should make a tomany relation with this, such that 
  // we can make aggregates on external links 
  final relatedDatapoint = ToOne<DataPoint>();
  final profile = ToOne<ProfileDocument>();

  LinkDocument({
    this.id = 0,
    required this.uri,
    required this.data,
    this.searchString = "",
  });
}