import 'package:objectbox/objectbox.dart';
import 'package:waultar/core/inodes/media_documents.dart';
import 'package:waultar/core/inodes/service_document.dart';
import 'package:waultar/core/inodes/tree_nodes.dart';

@Entity()
class ProfileDocument {
  int id;

  String name;

  final service = ToOne<ServiceDocument>();
  final dataPoints = ToMany<DataPoint>();
  final profilePicture = ToOne<ImageDocument>();
  @Backlink('profile')
  final categories = ToMany<DataCategory>();

  ProfileDocument({
    this.id = 0,
    required this.name,
  });
}
