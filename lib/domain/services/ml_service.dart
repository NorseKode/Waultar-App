import 'package:tuple/tuple.dart';
import 'package:waultar/configs/globals/globals.dart';
import 'package:waultar/configs/globals/helper/performance_helper.dart';
import 'package:waultar/core/abstracts/abstract_services/i_ml_service.dart';
import 'package:waultar/core/ai/image_classifier.dart';
import 'package:waultar/core/ai/sentiment_classifier.dart';
import 'package:waultar/core/inodes/datapoint_repo.dart';
import 'package:waultar/core/inodes/media_repo.dart';
import 'package:waultar/core/inodes/profile_document.dart';
import 'package:waultar/core/inodes/tree_nodes.dart';
import 'package:waultar/core/models/index.dart';
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
  int classifyImage(ImageModel model) {
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

  // final _appLogger = locator.get<AppLogger>(instanceName: 'logger');
  // final _imageRepo = locator.get<IImageRepository>(instanceName: 'imageRepo');
  // final _classifier = locator.get<ImageClassifier>(instanceName: 'imageClassifier');

  // @override
  // int classifyImage(ImageModel model) {
  //   model.tagMedia(_classifier);
  //   return _imageRepo.updateSingle(model);
  // }

  // @override
  // int classifyImagesFromDB() {
  //   var startTime = DateTime.now();

  //   int updated = 0;
  //   int offset = 0;
  //   int limit = 100;
  //   var images = _imageRepo.getPagination(offset, limit);

  //   if (images != null || images.isNotEmpty) {
  //     for (var image in images) {
  //       image.tagMedia(_classifier);
  //       updated++;
  //     }

  //     // updated images
  //     _imageRepo.updateMany(images);
  //     offset += 100;
  //   }

  //   if (ISPERFORMANCETRACKING) {
  //     PerformanceHelper.logRunTime(
  //         startTime, DateTime.now(), _appLogger, "Classifying of all images from the database");
  //   }

  //   return updated;
  // }

  // @override
  // Future<void> classifyAllImagesSeparateThreadFromDB() {
  //   // TODO: implement classifyAllImagesSeparateThreadFromDB
  //   var images = _imageRepo.getAllImages();
  //   if (images != null) {}
  //   throw UnimplementedError();
  // }

  // @override
  // Future<void> connotateAllTextSeparateThreadFromDB() {
  //   // TODO: implement connotateAllTextSeparateThreadFromDB
  //   throw UnimplementedError();
  // }

  // @override
  // int connotateText() {
  //   // TODO: implement connotateText
  //   throw UnimplementedError();
  // }

  // @override
  // int connotateTextsFromDB() {
  //   // TODO: implement connotateTextsFromDB
  //   throw UnimplementedError();
  // }
}
