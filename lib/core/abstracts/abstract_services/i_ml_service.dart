abstract class IMLService {
  int classifyImage();
  int classifyImagesFromDB();
  Future<void> classifyAllImagesSeparateThreadFromDB();
  // double connotateText(String text);
  // int connotateTextsFromCategory(List<DataCategory> categories);
  // Future<void> connotateAllTextSeparateThreadFromDB();
}
