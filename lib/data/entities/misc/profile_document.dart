import 'package:objectbox/objectbox.dart';
import 'package:waultar/core/helpers/json_helper.dart';
import 'package:waultar/data/entities/media/image_document.dart';
import 'package:waultar/data/entities/misc/service_document.dart';
import 'package:waultar/data/entities/nodes/category_node.dart';
import 'package:waultar/data/entities/nodes/datapoint_node.dart';

@Entity()
class ProfileDocument {
  int id;

  @Unique()
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

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'service': service.targetId,
      'dataPoints': JsonHelper.convertToManyToJson(dataPoints),
      'profilePicture': profilePicture.targetId,
      'categories': JsonHelper.convertToManyToJson(categories),
    };
  }
}
