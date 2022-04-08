
import 'package:objectbox/objectbox.dart';
import 'package:waultar/data/entities/misc/profile_document.dart';
import 'package:waultar/data/entities/nodes/datapoint_node.dart';

@Entity()
class ImageDocument {
  int id;
  String uri;
  String data;
  String searchString;
  late String mediaTags;
  late List<String> mediaTagScores;

  final relatedDatapoint = ToOne<DataPoint>();
  final profile = ToOne<ProfileDocument>();

  ImageDocument({
    this.id = 0,
    required this.uri,
    required this.data,
    this.searchString = "",
    String? mediatags,
    List<String>? mediatagscore,
  }) {
    if (mediatags != null) {
      mediaTags = mediatags;
    } else {
      mediaTags = "";
    }

    if (mediatagscore != null) {
      mediaTagScores = mediaTagScores;
    } else {
      mediaTagScores = <String>[];
    }
  }
}