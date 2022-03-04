import 'package:waultar/core/models/index.dart';

abstract class IImageRepository {
  int addImage(ImageModel image);
  ImageModel? getImageById(int id);
  List<ImageModel>? getAllImages();
  List<ImageModel>? getAllImagesByService(ServiceModel service);
  List<ImageModel>? getAllImagesByProfile(ProfileModel profile);
  int removeAll();
  List<ImageModel> search(String search);
}
