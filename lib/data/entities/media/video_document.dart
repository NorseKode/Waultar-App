import 'package:objectbox/objectbox.dart';
import 'package:waultar/data/entities/misc/profile_document.dart';
import 'package:waultar/data/entities/nodes/datapoint_node.dart';

@Entity()
class VideoDocument {
  int id;
  String uri;
  String data;
  String searchString;
  String? thumbnail;

  final relatedDatapoint = ToOne<DataPoint>();
  final profile = ToOne<ProfileDocument>();

  VideoDocument({
    this.id = 0,
    required this.uri,
    required this.data,
    this.thumbnail,
    this.searchString = "",
  });
}