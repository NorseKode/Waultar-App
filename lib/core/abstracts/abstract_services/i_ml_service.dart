import 'package:waultar/configs/globals/image_model_enum.dart';

abstract class IMLService {
  int classifyImage();
  int classifyImagesFromDB();
  Future<void> classifyImagesSeparateThread({
    required Function(String message, bool isDone) callback,
    required int totalAmountOfImagesToTag,
    int threadCount = 1,
    int? limitAmount,
    required ImageModelEnum imageModel,
  });
  // double connotateText(String text);
  // int connotateTextsFromCategory(List<DataCategory> categories);
  // Future<void> connotateAllTextSeparateThreadFromDB();
}
