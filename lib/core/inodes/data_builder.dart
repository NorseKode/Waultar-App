import 'dart:convert';

import 'package:waultar/configs/globals/media_extensions.dart';
import 'package:waultar/core/inodes/media_documents.dart';
import 'package:waultar/core/inodes/service_document.dart';
import 'package:waultar/core/inodes/tree_nodes.dart';
import 'package:path/path.dart' as dart_path;

class DataBuilder {
  late DataPoint dataPoint;
  final String basePathToMedia;

  // TODO - add service as field as well
  // - should be used for relations and the datapoint itself

  DataBuilder(this.basePathToMedia) {
    dataPoint = DataPoint();
  }

  void setName(DataPointName name) {
    dataPoint.dataPointName.target = name;
    dataPoint.stringName = name.name;
  }

  void setCategory(DataCategory category) {
    dataPoint.category.target = category;
  }

  void setService(ServiceDocument service) {
    dataPoint.service.target = service;
  }

  void setData(String json) {
    dataPoint.values = json;
  }

  DataPoint build() {
    /* 
    search for images in values   -> and make relations
    search for videoes in values  -> and make relations
    search for files in values    -> and make relations

    search the values for textStrings that should be searchable
      - and should be acceptable for NLP
    
    should we scout for timestamps here as well or later in the pipeline ?
    */
    _scout();

    return dataPoint;
  }

  void _scout() {
    // the raw data as a map
    // the asMap getter will make sure it's always a map
    Map<String, dynamic> json = dataPoint.asMap;

    // use the sb and append serachable strings in value
    var sb = StringBuffer();
    var imagesFound = <ImageDocument>[];
    var videosFound = <VideoDocument>[];
    var filesFound = <FileDocument>[];
    var linksFound = <LinkDocument>[];
    var timeStampsFound = <DateTime>[];
    // let's just use a nested funtion to recursively find our targets in the jsonMap
    recurse(dynamic json) {
      if (json is Map<String, dynamic>) {
        for (var entry in json.entries) {
          var value = entry.value;
          if (value is String) {
            if (Extensions.isImage(value)) {
              var image = ImageDocument(
                uri: dart_path.normalize('$basePathToMedia/$value'),
                data: jsonEncode(json),
              );
              image.relatedDatapoint.target = dataPoint;
              image.service.target = dataPoint.service.target;
              imagesFound.add(image);
            }

            if (Extensions.isFile(value)) {}
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
    dataPoint.searchString = sb.toString();
    dataPoint.images.addAll(imagesFound);
    dataPoint.videos.addAll(videosFound);
    dataPoint.files.addAll(filesFound);
    dataPoint.links.addAll(linksFound);
  }
}
