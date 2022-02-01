
import 'package:waultar/core/models/index.dart';

abstract class IImageRepository {
  Future<int> addImage(ImageModel image);
  Future<ImageModel> getImageById(int id);
  Future<List<ImageModel>> getAllImages();
  Future<List<ImageModel>> getAllImagesSortedByDate();
}