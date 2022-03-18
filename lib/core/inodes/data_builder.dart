
import 'dart:convert';

import 'package:waultar/core/inodes/tree_nodes.dart';
import 'package:waultar/data/entities/media/file_objectbox.dart';
import 'package:waultar/data/entities/media/image_objectbox.dart';
import 'package:waultar/data/entities/media/video_objectbox.dart';
import 'package:waultar/data/entities/misc/service_objectbox.dart';

class DataBuilder {
  late DataPoint dataPoint;

  DataBuilder() {
    dataPoint = DataPoint();
  }

  void setName(DataPointName name) {
    dataPoint.dataPointName.target = name;
    dataPoint.stringName = name.name;
  }

  void setCategory(DataCategory category) {
    dataPoint.category.target = category;
  }

  void setService(ServiceObjectBox service) {
    dataPoint.service.target = service;
  }

  void setData(String json) {
    dataPoint.values = jsonEncode(json);
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

    return dataPoint;
  }

  void _scout() {
    // the raw data as a map
    // the asMap getter will make sure it's always a map
    Map<String, dynamic> json = dataPoint.asMap;

    // use the sb and append serachable strings in value
    var sb = StringBuffer();
    var imagesFound = <ImageObjectBox>[];
    var videosFound = <VideoObjectBox>[];
    var filesFound = <FileObjectBox>[];
    // let's just use a nested funtion to recursively find our targets in the jsonMap
    recurse(dynamic json) {

    }

    recurse(json);
    dataPoint.searchString = sb.toString();
    dataPoint.images.addAll(imagesFound);
    dataPoint.videos.addAll(videosFound);
    dataPoint.files.addAll(filesFound);

  }
}