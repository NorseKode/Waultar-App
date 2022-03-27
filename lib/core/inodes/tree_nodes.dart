import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:objectbox/objectbox.dart';
import 'package:pretty_json/pretty_json.dart';
import 'package:waultar/configs/globals/media_extensions.dart';
import 'package:waultar/core/inodes/datapoint_repo.dart';
import 'package:waultar/core/inodes/media_documents.dart';
import 'package:waultar/core/inodes/profile_document.dart';
import 'package:waultar/core/inodes/tree_parser.dart';
import 'package:path/path.dart' as dart_path;

@Entity()
class DataPoint {
  int id;

  final dataPointName = ToOne<DataPointName>();

  // ui most important info field about the datapoint
  late String stringName;
  late double sentimentScore;

  final category = ToOne<DataCategory>();
  final profile = ToOne<ProfileDocument>();

  final images = ToMany<ImageDocument>();
  final videos = ToMany<VideoDocument>();
  final files = ToMany<FileDocument>();
  final links = ToMany<LinkDocument>();

  List<String> searchStrings = [];

  // the actual data stored in JSON format
  late String values;

  @Transient()
  late Map<String, dynamic> valuesMap;

  @Property(type: PropertyType.dateNano)
  late DateTime createdAt;

  DataPoint({this.id = 0, this.sentimentScore = 0.0}) {
    createdAt = DateTime.now();
  }

  int get dbCreatedAt => createdAt.microsecondsSinceEpoch;
  set dbCreatedAt(int value) {
    createdAt = DateTime.fromMicrosecondsSinceEpoch(value, isUtc: false);
  }

  Map<String, dynamic> get asMap {
    var decoded = jsonDecode(values);
    if (decoded is List<dynamic>) {
      return {'values': decoded};
    } else {
      return decoded;
    }
  }

  /// Returns a datapoint with associated category, service, name and profile
  /// Will handle relations to images, videos, files and links
  DataPoint.parse(
    DataCategory dataCategory,
    DataPointName parentName,
    ProfileDocument targetProfile,
    dynamic json,
    String basePathToMedia,
  ) : id = 0 {
    category.target = dataCategory;
    dataPointName.target = parentName;
    stringName = parentName.name;
    profile.target = targetProfile;
    values = jsonEncode(json);

    _createRelations(basePathToMedia);
    if (searchStrings.isEmpty) {
      searchStrings.add(stringName);
    }
    createdAt = DateTime.now();
    sentimentScore = 0;
  }

  void _createRelations(String basePathToMedia) {
    // the raw data as a map
    // the asMap getter will make sure it's always a map
    Map<String, dynamic> json = asMap;

    recurse(dynamic json) {
      if (json is Map<String, dynamic>) {
        for (var entry in json.entries) {
          var value = entry.value;
          if (value is String) {
            if (Extensions.isImage(value)) {
              var image = ImageDocument(
                uri: dart_path.normalize('$basePathToMedia/$value'),
                data: jsonEncode(flatten(json)),
              );

              image.relatedDatapoint.target = this;
              image.profile.target = profile.target;
              images.add(image);
            } else if (Extensions.isVideo(value)) {
              var video = VideoDocument(
                uri: dart_path.normalize('$basePathToMedia/$value'),
                data: jsonEncode(flatten(json)),
              );

              video.relatedDatapoint.target = this;
              video.profile.target = profile.target;
              videos.add(video);
            } else if (Extensions.isFile(value)) {
              var file = FileDocument(
                uri: dart_path.normalize('$basePathToMedia/$value'),
                data: jsonEncode(flatten(json)),
              );

              file.relatedDatapoint.target = this;
              file.profile.target = profile.target;
              files.add(file);
            } else if (Extensions.isLink(value)) {
              var link = LinkDocument(
                uri: dart_path.normalize('$basePathToMedia/$value'),
                data: jsonEncode(flatten(json)),
              );

              link.relatedDatapoint.target = this;
              link.profile.target = profile.target;
              links.add(link);
            } else {
              searchStrings.add(value);
            }
          } else {
            recurse(entry.value);
          }
        }
      }
      if (json is List<dynamic>) {
        for (var element in json) {
          recurse(element);
        }
      }
    }

    recurse(json);
  }

  @override
  String toString() {
    var sb = StringBuffer();
    sb.write("\n");
    sb.write("############# DataPoint #############\n");
    sb.write("ID: $id \n");

    if (dataPointName.hasValue) {
      sb.write(
          "DataPoint relation target name: ${dataPointName.target!.name}\n");
    }

    sb.write("Data:\n");

    if (values.isNotEmpty) {
      String pretty = prettyJson(jsonDecode(values));
      sb.write(pretty);
    }
    sb.write("\n");

    sb.write("#####################################\n");
    return sb.toString();
  }

  UIDTO get getUIDTO => UIDTO(stringName, category.target!, asMap);
}

@Entity()
class DataPointName {
  int id;
  int count;

  String name;

  final dataCategory = ToOne<DataCategory>();
  final profile = ToOne<ProfileDocument>();

  @Backlink('dataPointName')
  final dataPoints = ToMany<DataPoint>();

  final children = ToMany<DataPointName>();
  final parent = ToOne<DataPointName>();

  DataPointName({
    this.id = 0,
    this.count = 0,
    required this.name,
  });
}

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
}

enum CategoryEnum {
  unknown,
  interactions,
  advertisement,
  thirdPartyExchanges,
  other,
  reactions,
  comments,
  social,
  gaming,
  shopping,
  location,
  messaging,
  preferences,
  profile,
  serach,
  loggedData,
  posts,
  stories,
  files,
}

extension CategoryMapper on CategoryEnum {
  static const colors = {
    CategoryEnum.unknown: Colors.cyan,
    CategoryEnum.interactions: Colors.red,
    CategoryEnum.advertisement: Colors.blue,
    CategoryEnum.thirdPartyExchanges: Colors.orange,
    CategoryEnum.other: Colors.brown,
    CategoryEnum.reactions: Colors.green,
    CategoryEnum.comments: Colors.purple,
    CategoryEnum.social: Colors.purpleAccent,
    CategoryEnum.gaming: Colors.blueGrey,
    CategoryEnum.shopping: Colors.pink,
    CategoryEnum.location: Colors.indigo,
    CategoryEnum.messaging: Colors.blueAccent,
    CategoryEnum.preferences: Colors.cyanAccent,
    CategoryEnum.profile: Colors.lightBlueAccent,
    CategoryEnum.serach: Colors.limeAccent,
    CategoryEnum.loggedData: Colors.yellow,
    CategoryEnum.posts: Colors.amber,
    CategoryEnum.stories: Colors.deepPurple,
    CategoryEnum.files: Colors.black38,
  };

  static const names = {
    CategoryEnum.unknown: 'Unknown',
    CategoryEnum.interactions: 'Interactions',
    CategoryEnum.advertisement: 'Advertisement',
    CategoryEnum.thirdPartyExchanges: 'Third Party Exchanges',
    CategoryEnum.other: 'Other',
    CategoryEnum.reactions: 'Reactions',
    CategoryEnum.comments: 'Comments',
    CategoryEnum.social: 'Social',
    CategoryEnum.gaming: 'Gaming',
    CategoryEnum.shopping: 'Shopping',
    CategoryEnum.location: 'Location',
    CategoryEnum.messaging: 'Messaging',
    CategoryEnum.preferences: 'Preferences',
    CategoryEnum.profile: 'Profile',
    CategoryEnum.serach: 'Serach',
    CategoryEnum.loggedData: 'Logged Data',
    CategoryEnum.posts: 'Posts',
    CategoryEnum.stories: 'Stories',
    CategoryEnum.files: 'Files',
  };

  Color get color => colors[this] ?? Colors.cyan;
  String get name => names[this] ?? 'Unknown';
}

CategoryEnum getFromPath(String path) {
  var name = dart_path.basename(path);
  if (name == 'extracts' || name == 'test') {
    return CategoryEnum.unknown;
  }
  switch (name) {
    case 'activity_messages':
    case 'polls':
    case 'interactions':
    case 'reviews':
    case 'saved_items_and_collections':
    case 'your_interactions_on_facebook':
    case 'story_sticker_interactions':
    case 'ads_and_content':
    case 'saved':
      return CategoryEnum.interactions;

    case 'ads_information':
    case 'other_logged_information':
    case 'your_topics':
    case 'ads_and_businesses':
    case 'monetization':
    case 'ads_interests.json':
      return CategoryEnum.advertisement;

    case 'apps_and_websites_off_of_facebook':
      return CategoryEnum.thirdPartyExchanges;

    case 'bug_bounty':
    case "communities":
    case "facebook_accounts_center":
    case "facebook_assistant":
    case "facebook_portal":
    case "fundraisers":
    case "journalist_registration":
    case "live_audio_rooms":
    case "music_recommendations":
    case "spark_ar":
    case "your_problem_reports":
    case "apps_and_websites":
    case "contacts":
    case "loyalty_accounts":
    case "guides":
      return CategoryEnum.other;

    case 'likes':
    case 'posts_and_comments.json':
      return CategoryEnum.reactions;
    
    case 'comments.json':
    case 'your_comments_in_groups.json':
    case 'comments':
      return CategoryEnum.comments;

    case 'events':
    case 'friends_and_followers':
    case 'groups':
    case 'other_activity':
    case 'pages':
    case 'followers_and_following':
      return CategoryEnum.social;

    case 'facebook_gaming':
      return CategoryEnum.gaming;

    case 'facebook_marketplace':
    case 'facebook_payments':
    case 'recently_viewed_items':
      return CategoryEnum.shopping;

    case 'location':
    case 'your_places':
      return CategoryEnum.location;

    case 'messages':
      return CategoryEnum.messaging;

    case 'news_feed':
    case 'preferences':
    case 'autofill_information':
    case 'comments_settings':
      return CategoryEnum.preferences;

    case 'profile_information':
    case 'account_information':
    case 'login_and_account_creation':
    case 'information_about_you':
      return CategoryEnum.profile;

    case 'search':
    case 'recent_searches':
      return CategoryEnum.serach;

    case 'security_and_login_information':
    case 'past_instagram_insights':
    case 'device_information':
      return CategoryEnum.loggedData;

    case 'posts':
    case 'short_videos':
    case 'content':
      return CategoryEnum.posts;

    case 'stories':
    case 'stories.json':
      return CategoryEnum.stories;

    case 'profile_photos.json':
      return CategoryEnum.files;

    default:
      var newPath = dart_path.dirname(path);
      return getFromPath(newPath);
  }
}

 // might result in stackOverflow if root folder is not Facebook or Instagram
    // try {
    //   var name = path_dart.basename(folderName);

    //   // if still none are found, set category to "Other" (default)

    //   if (name == 'extracts') {
    //     return _categoryBox
    //         .query(DataCategory_.dbCategory.equals(CategoryEnum.other.index))
    //         .build()
    //         .findUnique()!;
    //   }
    //   var service = profile.service.target!;

    //   var category = service.serviceName == "Facebook"
    //       ? _categoryBox
    //           .query(DataCategory_.matchingFoldersFacebook.contains(name))
    //           .build()
    //           .findFirst()
    //       : _categoryBox
    //           .query(DataCategory_.matchingFoldersInstagram.contains(name))
    //           .build()
    //           .findFirst();

    //   // if none is found :
    //   if (category == null) {
    //     return getFromFolderName(
    //         folderName.substring(0, folderName.length - name.length), profile);
    //   } else {
    //     return category;
    //   }
    // } on Exception catch (e) {
    //   // ignore: avoid_print
    //   print(e);
    //   return _categoryBox
    //       .query(DataCategory_.dbCategory.equals(CategoryEnum.other.index))
    //       .build()
    //       .findUnique()!;
    // }
