abstract class IMLService {
  int classifyImage();
  int classifyImagesFromDB();
  Future<void> classifyImagesSeparateThread({
    required Function(String message, bool isDone) callback,
    required int totalAmountOfImagesToTag,
    int? limitAmount,
  });
  // double connotateText(String text);
  // int connotateTextsFromCategory(List<DataCategory> categories);
  // Future<void> connotateAllTextSeparateThreadFromDB();
}
