import 'package:waultar/core/models/index.dart';

abstract class IImageRepository {
  int addImage(ImageModel image);
  ImageModel? getImageById(int id);
  List<ImageModel>? getAllImages();
  List<ImageModel>? getAllImagesByService(ServiceModel service);
  List<ImageModel>? getAllImagesByProfile(ProfileModel profile);
  List<ImageModel> search(String search, int offset, int limit);
  List<ImageModel> getPagination(int offset, int limit);
  int removeAll();
  int updateSingle(ImageModel model);
  void updateMany(List<ImageModel> images);
}
