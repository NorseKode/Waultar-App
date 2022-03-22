import 'dart:convert';

import 'package:objectbox/objectbox.dart';
import 'package:pretty_json/pretty_json.dart';
import 'package:waultar/configs/globals/media_extensions.dart';
import 'package:waultar/core/inodes/media_documents.dart';
import 'package:waultar/core/inodes/service_document.dart';
import 'package:waultar/core/inodes/tree_parser.dart';
import 'package:waultar/data/entities/profile/profile_objectbox.dart';
import 'package:path/path.dart' as dart_path;

@Entity()
class DataPoint {
  int id;
  final dataPointName = ToOne<DataPointName>();
  late String stringName;

  final category = ToOne<DataCategory>();
  final profile = ToOne<ProfileDocument>();

  final images = ToMany<ImageDocument>();
  final videos = ToMany<VideoDocument>();
  final files = ToMany<FileDocument>();
  final links = ToMany<LinkDocument>();
  final service = ToOne<ServiceDocument>();

  List<int> timestamps = [];

  List<String> searchStrings = [];

  // the actual data stored in JSON format
  late String values;

  @Transient()
  late Map<String, dynamic> valuesMap;

  DataPoint({
    this.id = 0,
  });

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
    ServiceDocument dataService,
    ProfileDocument targetProfile,
    dynamic json,
    String basePathToMedia,
  ) : id = 0 {
    category.target = dataCategory;
    dataPointName.target = parentName;
    service.target = dataService;
    stringName = parentName.name;
    profile.target = targetProfile;
    values = jsonEncode(json);
    
    _createRelations(basePathToMedia);
    if (searchStrings.isEmpty) {
      searchStrings.add(stringName);
    }
  }

  void _createRelations(String basePathToMedia) {
    // the raw data as a map
    // the asMap getter will make sure it's always a map
    Map<String, dynamic> json = asMap;

    // let's just use a nested funtion to recursively find our targets in the jsonMap
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
              image.service.target = service.target;
              image.profile.target = profile.target;
              images.add(image);
            } else if (Extensions.isVideo(value)) {
              var video = VideoDocument(
                uri: dart_path.normalize('$basePathToMedia/$value'),
                data: jsonEncode(flatten(json)),
              );

              video.relatedDatapoint.target = this;
              video.service.target = service.target;
              video.profile.target = profile.target;
              videos.add(video);
            } else if (Extensions.isFile(value)) {
              var file = FileDocument(
                uri: dart_path.normalize('$basePathToMedia/$value'),
                data: jsonEncode(flatten(json)),
              );

              file.relatedDatapoint.target = this;
              file.service.target = service.target;
              file.profile.target = profile.target;
              files.add(file);
            } else if (Extensions.isLink(value)) {
              var link = LinkDocument(
                uri: dart_path.normalize('$basePathToMedia/$value'),
                data: jsonEncode(flatten(json)),
              );

              link.relatedDatapoint.target = this;
              link.service.target = service.target;
              link.profile.target = profile.target;
              links.add(link);
            } else {
              searchStrings.add(value);
            }
          } else if (value is int && value != 0) {
            timestamps.add(value);
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
}

@Entity()
class DataPointName {
  int id;
  int count;

  @Index()
  String name;

  final dataCategory = ToOne<DataCategory>();
  final service = ToOne<ServiceDocument>();

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
  @Unique()
  String name;

  @Backlink('dataCategory')
  final dataPointNames = ToMany<DataPointName>();

  DataCategory({
    this.id = 0,
    this.count = 0,
    required this.name,
    required this.matchingFoldersFacebook,
    required this.matchingFoldersInstagram,
  });
}
