import 'package:waultar/configs/globals/app_logger.dart';
import 'package:waultar/configs/globals/globals.dart';
import 'package:waultar/configs/globals/helper/performance_helper.dart';
import 'package:waultar/core/abstracts/abstract_repositories/i_image_repository.dart';
import 'package:waultar/core/abstracts/abstract_services/i_ml_service.dart';
import 'package:waultar/core/ai/image_classifier.dart';
import 'package:waultar/core/models/index.dart';
import 'package:waultar/startup.dart';

class MLService extends IMLService {
  final _appLogger = locator.get<AppLogger>(instanceName: 'logger');
  final _imageRepo = locator.get<IImageRepository>(instanceName: 'imageRepo');
  final _classifier = locator.get<ImageClassifier>(instanceName: 'imageClassifier');

  @override
  int classifyImage(ImageModel model) {
    model.tagMedia(_classifier);
    return _imageRepo.updateSingle(model);
  }

  @override
  int classifyImagesFromDB() {
    var startTime = DateTime.now();

    int updated = 0;
    int offset = 0;
    int limit = 100;
    var images = _imageRepo.getPagination(offset, limit);

    if (images != null || images.isNotEmpty) {
      for (var image in images) {
        image.tagMedia(_classifier);
        updated++;
      }

      // updated images
      _imageRepo.updateMany(images);
      offset += 100;
    }

    if (ISPERFORMANCETRACKING) {
      PerformanceHelper.logRunTime(
          startTime, DateTime.now(), _appLogger, "Classifying of all images from the database");
    }

    return updated;
  }

  @override
  Future<void> classifyAllImagesSeparateThreadFromDB() {
    // TODO: implement classifyAllImagesSeparateThreadFromDB
    var images = _imageRepo.getAllImages();
    if (images != null) {}
    throw UnimplementedError();
  }

  @override
  Future<void> connotateAllTextSeparateThreadFromDB() {
    // TODO: implement connotateAllTextSeparateThreadFromDB
    throw UnimplementedError();
  }

  @override
  int connotateText() {
    // TODO: implement connotateText
    throw UnimplementedError();
  }

  @override
  int connotateTextsFromDB() {
    // TODO: implement connotateTextsFromDB
    throw UnimplementedError();
  }
}
