import 'package:objectbox/objectbox.dart';
import 'package:waultar/core/helpers/json_helper.dart';
import 'package:waultar/data/entities/misc/profile_document.dart';
import 'category_node.dart';
import 'datapoint_node.dart';

@Entity()
class DataPointName {
  int id;
  int count;

  String name;

  final dataCategory = ToOne<DataCategory>();
  final profile = ToOne<ProfileDocument>();

  @Backlink('dataPointName')
  final dataPoints = ToMany<DataPoint>();

  @Backlink('parent')
  final children = ToMany<DataPointName>();
  final parent = ToOne<DataPointName>();

  DataPointName({
    this.id = 0,
    this.count = 0,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'count': count,
      'name': name,
      'dataCategory': dataCategory.targetId,
      'profile': profile.targetId,
      'dataPoints': JsonHelper.convertToManyToJson(dataPoints),
      'children': JsonHelper.convertToManyToJson(children),
      'parent': parent.targetId,
    };
  }
}
