import 'package:waultar/core/models/media/image_model.dart';

abstract class IMLService {
  int classifyImage(ImageModel model);
  int classifyImagesFromDB();
  Future<void> classifyAllImagesSeparateThreadFromDB();
  int connotateText();
  int connotateTextsFromDB();
  Future<void> connotateAllTextSeparateThreadFromDB();
}
