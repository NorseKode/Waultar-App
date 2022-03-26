// ignore_for_file: unused_field

import 'package:waultar/configs/globals/app_logger.dart';
import 'package:waultar/core/abstracts/abstract_services/i_ml_service.dart';
import 'package:waultar/core/ai/image_classifier.dart';
import 'package:waultar/core/inodes/media_repo.dart';
import 'package:waultar/core/models/index.dart';
import 'package:waultar/startup.dart';

class MLService extends IMLService {
  final _appLogger = locator.get<AppLogger>(instanceName: 'logger');
  final _mediaRepo = locator.get<MediaRepository>(instanceName: 'mediaRepo');
  final _classifier = locator.get<ImageClassifier>(instanceName: 'imageClassifier');

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
    throw UnimplementedError();
  // var startTime = DateTime.now();

  //   int updated = 0;
  //   int offset = 0;
  //   int limit = 100;
  //   var images = _mediaRepo.getImagesPagination(offset, limit);
    
  //   while (images != null || images.isNotEmpty) {
  //     for (var image in images) {
  //       image.mediaTags = _classifier.predict(image.uri, 5).map((e) => e.item1).toList();
  //       updated++;
  //     }

  //     _mediaRepo.updateImages(images);
  //     offset += 100;
  //     images = _media
  //   }

  //   if (ISPERFORMANCETRACKING) {
  //     PerformanceHelper.logRunTime(
  //         startTime, DateTime.now(), _appLogger, "Classifying of all images from the database");
  //   }

  //   return updated;
  
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
