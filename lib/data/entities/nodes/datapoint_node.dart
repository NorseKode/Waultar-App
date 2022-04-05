import 'dart:convert';

import 'package:objectbox/objectbox.dart';
import 'package:pretty_json/pretty_json.dart';
import 'package:waultar/configs/globals/category_enums.dart';
import 'package:waultar/configs/globals/media_extensions.dart';
import 'package:waultar/data/repositories/datapoint_repo.dart';
import 'package:waultar/data/entities/media/file_document.dart';
import 'package:waultar/data/entities/media/image_document.dart';
import 'package:waultar/data/entities/media/video_document.dart';
import 'package:waultar/data/entities/misc/profile_document.dart';
import 'package:waultar/core/parsers/tree_parser.dart';
import 'package:path/path.dart' as dart_path;

import '../media/link_document.dart';
import 'category_node.dart';
import 'name_node.dart';

@Entity()
class DataPoint {
  int id;

  final dataPointName = ToOne<DataPointName>();

  // ui most important info field about the datapoint
  late String stringName;

  double? sentimentScore;

  String? sentimentText;

  final category = ToOne<DataCategory>();
  final profile = ToOne<ProfileDocument>();

  final images = ToMany<ImageDocument>();
  final videos = ToMany<VideoDocument>();
  final files = ToMany<FileDocument>();
  final links = ToMany<LinkDocument>();

  @Index()
  late String searchTerms;

  // the actual data stored in JSON format
  late String values;

  @Transient()
  late Map<String, dynamic> valuesMap;

  @Property(type: PropertyType.dateNano)
  late DateTime createdAt;

  DataPoint({
    this.id = 0,
    this.sentimentScore = 0.0,
    this.searchTerms = '',
  }) {
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

    final StringBuffer sb = StringBuffer();
    sb.write('${parentName.name} ');

    _createRelations(basePathToMedia, sb);

    searchTerms = sb.toString();
    createdAt = DateTime.now();
    sentimentText = _getSentimentText(dataCategory, json, targetProfile, parentName);
  }

  String? _getSentimentText(
      DataCategory dataCategory, dynamic json, ProfileDocument profile, DataPointName parent) {
    switch (profile.service.target!.serviceName) {
      case "Facebook":
        switch (dataCategory.category) {
          case CategoryEnum.messaging:
            if (parent.name == "messages" &&
                json is Map<String, dynamic> &&
                json.containsKey("content")) {
              return json["content"];
            }
            break;

          case CategoryEnum.posts:
            if (json is Map<String, dynamic> &&
                json.containsKey("data") &&
                (json["data"]).isNotEmpty() && (json["data"]).first.containsKey("post")) {
              return (json["data"]).first["post"];
            }
            break;

          case CategoryEnum.comments:
            if (json is Map<String, dynamic> && json.containsKey("comment")) {
              return json["comment"];
            }
            break;
        }
        break;

      case "Instagram":
        switch (dataCategory.category) {
          case CategoryEnum.messaging:
            if (parent.name == "messages" && json is Map<String, dynamic>) {
              if (json.containsKey("content")) {
                return json["content"];
              }
            }
            break;

          case CategoryEnum.posts:
            if (json is Map<String, dynamic> &&
                json.containsKey("media") &&
                json["media"].first.containsKey("title")) {
              return (json["media"].first)["title"];
            }
            break;

          case CategoryEnum.comments:
            if (json is Map<String, dynamic> &&
                json.containsKey("string_list_data") &&
                json["string_list_data"].first.containsKey("value")) {
              return ((json["string_list_data"]).first)["value"];
            }
            break;
        }
        break;
    }
    return null;
  }

  void _createRelations(String basePathToMedia, StringBuffer sb) {
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
              sb.write('$value ');
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
      sb.write("DataPoint relation target name: ${dataPointName.target!.name}\n");
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

  String get path {
    var sb = StringBuffer();
    sb.write('${category.target!.category.categoryName}/');
    var appendList = <String>[];
    var parent = dataPointName.target;
    while (parent != null) {
      appendList.add('${parent.name}/');
      parent = parent.parent.target;
    }
    for (var element in appendList.reversed) {
      sb.write(element);
    }
    return sb.toString();
  }

  UIDTO get getUIDTO => UIDTO(dataPoint: this);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'dataPointName': dataPointName.targetId,
      'stringName': stringName,
      'sentimentScore': sentimentScore,
      'sentimentText': sentimentText ?? "",
      'category': category.targetId,
      'profile': profile.targetId,
      'images': images.map((element) => element.id).toList(),
      'videos': videos.map((element) => element.id).toList(),
      'files': files.map((element) => element.id).toList(),
      'links': links.map((element) => element.id).toList(),
      'searchTerms': searchTerms,
      'values': values,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'dbCreatedAt': dbCreatedAt,
      'asMap': asMap,
      'path': path,
      'getUIDTO': getUIDTO.toMap(),
    };
  }
}
