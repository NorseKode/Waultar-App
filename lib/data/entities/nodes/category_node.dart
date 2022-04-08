import 'package:objectbox/objectbox.dart';
import 'package:waultar/configs/globals/category_enums.dart';
import 'package:waultar/data/entities/misc/profile_document.dart';

import 'name_node.dart';

@Entity()
class DataCategory {
  int id;

  int count;

  List<String> matchingFoldersFacebook;
  List<String> matchingFoldersInstagram;

  @Index()
  CategoryEnum category;

  final profile = ToOne<ProfileDocument>();

  @Backlink('dataCategory')
  final dataPointNames = ToMany<DataPointName>();

  DataCategory({
    this.id = 0,
    this.count = 0,
    this.category = CategoryEnum.unknown,
    required this.matchingFoldersFacebook,
    required this.matchingFoldersInstagram,
  });

  int get dbCategory {
    return category.index;
  }

  set dbCategory(int index) {
    category = index >= 0 && index < CategoryEnum.values.length
        ? CategoryEnum.values[index]
        : CategoryEnum.unknown;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'count': count,
      'matchingFoldersFacebook': matchingFoldersFacebook,
      'matchingFoldersInstagram': matchingFoldersInstagram,
      'category': category.categoryName,
      'profile': profile.targetId,
      'dataPointNames': dataPointNames.map((element) => element.id).toList(),
      'dbCategory': dbCategory,
    };
  }
}
