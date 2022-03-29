import 'package:objectbox/objectbox.dart';
import 'package:waultar/data/entities/media/image_document.dart';
import 'package:waultar/data/entities/misc/service_document.dart';
import 'package:waultar/data/entities/nodes/category_node.dart';
import 'package:waultar/data/entities/nodes/datapoint_node.dart';

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
