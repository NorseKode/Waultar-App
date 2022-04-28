import 'package:objectbox/objectbox.dart';
import 'package:waultar/configs/globals/category_enums.dart';
import 'package:waultar/data/entities/misc/profile_document.dart';

import 'name_node.dart';

@Entity()
class DataCategory {
  int id;

  @Unique(onConflict: ConflictStrategy.fail)
  late String
      profileCategoryCombination; // To ensure at max one enum associated with each profile

  @Index()
  CategoryEnum category;
  int count;

  @Backlink('dataCategory')
  final dataPointNames = ToMany<DataPointName>();
  final profile = ToOne<ProfileDocument>();

  DataCategory({
    this.id = 0,
    this.count = 0,
    this.category = CategoryEnum.unknown,
    this.profileCategoryCombination = '',
  });

  DataCategory.create(CategoryEnum categoryEnum, ProfileDocument profile)
      : id = 0,
        count = 0,
        category = categoryEnum {
    this.profile.target = profile;
    profileCategoryCombination = profile.name + category.categoryName;
  }

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
      // 'matchingFoldersFacebook': matchingFoldersFacebook,
      // 'matchingFoldersInstagram': matchingFoldersInstagram,
      'category': category.categoryName,
      'profile': profile.targetId,
      'dataPointNames': dataPointNames.map((element) => element.id).toList(),
      'dbCategory': dbCategory,
    };
  }
}
