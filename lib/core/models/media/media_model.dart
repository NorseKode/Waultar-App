import 'package:tuple/tuple.dart';
import 'package:waultar/core/ai/image_classifier.dart';
import 'package:waultar/core/models/base_model.dart';
import 'package:waultar/core/models/profile/profile_model.dart';

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
  }) : super(id, profile, raw);

  void tagMedia(ImageClassifier classifier, {int? amountOfTags}) {
    if (uri.path.isNotEmpty) {
      mediaTags = classifier.predict(Uri.decodeFull(uri.path), amountOfTags ?? 5);
    }
  }

  @override
  String toString() {
    return "id: $id, uri: ${uri.path}, timestamp: $timestamp, metadata: $metadata, media tags: ${mediaTags.toString()}";
  }
}
