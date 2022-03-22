import 'package:objectbox/objectbox.dart';
import 'package:waultar/core/inodes/service_document.dart';
import 'package:waultar/core/inodes/tree_nodes.dart';
import 'package:waultar/data/entities/profile/profile_objectbox.dart';

@Entity()
class ImageDocument {
  int id;
  String uri;
  String data;
  String searchString;
  List<String>? mediaTags;

  final service = ToOne<ServiceDocument>();
  final relatedDatapoint = ToOne<DataPoint>();
  final profile = ToOne<ProfileDocument>();

  ImageDocument({
    this.id = 0,
    required this.uri,
    required this.data,
    this.searchString = "",
  });
}

@Entity()
class VideoDocument {
  int id;
  String uri;
  String data;
  String searchString;
  String? thumbnail;

  final service = ToOne<ServiceDocument>();
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

@Entity()
class FileDocument {
  int id;
  String uri;
  String data;
  String searchString;
  String? thumbnail;

  final service = ToOne<ServiceDocument>();
  final relatedDatapoint = ToOne<DataPoint>();
  final profile = ToOne<ProfileDocument>();

  FileDocument({
    this.id = 0,
    required this.uri,
    required this.data,
    this.thumbnail,
    this.searchString = "",
  });
}

@Entity()
class LinkDocument {
  int id;
  String uri;
  String data;
  String? searchString;

  final service = ToOne<ServiceDocument>();
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
