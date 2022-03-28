import 'package:tuple/tuple.dart';
import 'package:waultar/configs/globals/globals.dart';
import 'package:waultar/core/helpers/performance_helper.dart';
import 'package:waultar/core/abstracts/abstract_services/i_ml_service.dart';
import 'package:waultar/core/ai/image_classifier.dart';
import 'package:waultar/core/ai/sentiment_classifier.dart';
import 'package:waultar/core/inodes/datapoint_repo.dart';
import 'package:waultar/core/inodes/media_repo.dart';
import 'package:waultar/core/inodes/profile_document.dart';
import 'package:waultar/core/inodes/tree_nodes.dart';
import 'package:waultar/startup.dart';

class MLService extends IMLService {
  // final _appLogger = locator.get<AppLogger>(instanceName: 'logger');
  final _mediaRepo = locator.get<MediaRepository>(instanceName: 'mediaRepo');
  final _dataRepo = locator.get<DataPointRepository>(instanceName: 'dataRepo');
  final _classifier =
      locator.get<ImageClassifier>(instanceName: 'imageClassifier');
  // final _context = locator.get<ObjectBox>(instanceName: 'context');
  final _performance =
      locator.get<PerformanceHelper>(instanceName: 'performance');
  final _textClassifier =
      locator.get<SentimentClassifier>(instanceName: 'sentimentClassifier');

  @override
  Future<void> classifyAllImagesSeparateThreadFromDB() {
    // TODO: implement classifyAllImagesSeparateThreadFromDB
    throw UnimplementedError();
  }

  @override
  int classifyImage() {
    // TODO: implement classifyImage
    throw UnimplementedError();
  }

  @override
  int classifyImagesFromDB() {
    if (ISPERFORMANCETRACKING) {
      _performance.reInit(newParentKey: "imageTagging", newChildKey: "image");
      _performance.start();
    }

    var startTime = DateTime.now();

    int updated = 0;
    int step = 100;
    int offset = 0;
    int limit = step;
    var images = _mediaRepo.getImagesPagination(offset, limit);

    while (images.isNotEmpty) {
      for (var image in images) {
        var mediaTags = _classifier.predict(image.uri, 5);

        if (mediaTags.length == 0) {
          image.mediaTagScores = ["No Tag Found"];
          image.mediaTags = "No Tag Found";
        }

        image.mediaTagScores =
            mediaTags.map((e) => ",(${e.item1},${e.item2})").toList();

        image.mediaTags = mediaTags.fold<String>(
            "", (previous, next) => previous += ",${next.item1}");

        updated++;
      }

      _mediaRepo.updateImages(images);
      offset += step;
      images = _mediaRepo.getImagesPagination(offset, limit);
    }

    if (ISPERFORMANCETRACKING) {
      _performance.stopParentAndWriteToFile(
        "image-tagging",
        metadata: {"Image count": updated},
      );
    }

    return updated;
  }
}
