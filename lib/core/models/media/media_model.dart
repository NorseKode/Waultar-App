import 'dart:convert';

import 'package:tuple/tuple.dart';
import 'package:path/path.dart' as path_dart;
import 'package:waultar/core/ai/image_classifier.dart';
import 'package:waultar/core/models/base_model.dart';
import 'package:waultar/core/models/profile/profile_model.dart';
import 'package:waultar/startup.dart';

abstract class MediaModel extends BaseModel {
  late Uri uri;
  String? metadata;
  DateTime? timestamp;
  List<Tuple2<String, double>>? mediaTags;

  MediaModel(
    int id,
    ProfileModel profile,
    String raw,
    this.uri,
    this.metadata,
    this.timestamp, {
    this.mediaTags,
  }) : super(id, profile, raw) {
    if (profile.basePathToFiles != null) {
    uri = Uri(
      path: path_dart.normalize(
        path_dart.join(
          profile.basePathToFiles!,
          uri.path,
        ),
      ),
    );
    } else {
      throw "Profile's base path to files is null";
    }
  }

  void tagMedia({int? amountOfTags}) {    
    mediaTags = locator
        .get<ImageClassifier>(instanceName: 'imageClassifier')
        .predict(Uri.decodeFull(uri.path), amountOfTags ?? 5);
  }

  @override
  String toString() {
    return "id: $id, uri: ${uri.path}, timestamp: $timestamp, metadata: $metadata, media tags: ${mediaTags.toString()}";
  }
}
