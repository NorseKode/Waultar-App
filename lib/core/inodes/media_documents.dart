import 'package:objectbox/objectbox.dart';
import 'package:waultar/core/inodes/service_document.dart';
import 'package:waultar/core/inodes/tree_nodes.dart';

@Entity()
class ImageDocument {
  int id;
  String uri;
  String data;
  late String searchString;
  late List<String> mediaTags;

  final service = ToOne<ServiceDocument>();
  final relatedDatapoint = ToOne<DataPoint>();

  ImageDocument({
    this.id = 0,
    required this.uri,
    required this.data,
  });
}

@Entity()
class VideoDocument {
  int id;
  String uri;
  String data;
  late String searchString;
  String? thumbnail;

  final service = ToOne<ServiceDocument>();
  final relatedDatapoint = ToOne<DataPoint>();

  VideoDocument({
    this.id = 0,
    required this.uri,
    required this.data,
    this.thumbnail,
  });
}

@Entity()
class FileDocument {
  int id;
  String uri;
  String data;
  late String searchString;
  String? thumbnail;

  final service = ToOne<ServiceDocument>();
  final relatedDatapoint = ToOne<DataPoint>();

  FileDocument({
    this.id = 0,
    required this.uri,
    required this.data,
    this.thumbnail,
  });
}

@Entity()
class LinkDocument {
  int id;
  String uri;
  String data;
  late String searchString;

  final service = ToOne<ServiceDocument>();
  // chrome serach history can link to the same url many times,
  // perhaps we should make a tomany relation with this, such that 
  // we can make aggregates on external links 
  final relatedDatapoint = ToOne<DataPoint>();

  LinkDocument({
    this.id = 0,
    required this.uri,
    required this.data,
  });
}
