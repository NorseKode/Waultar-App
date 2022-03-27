abstract class IMLService {
  int classifyImage();
  int classifyImagesFromDB();
  Future<void> classifyAllImagesSeparateThreadFromDB();
  int connotateText();
  int connotateTextsFromDB();
  Future<void> connotateAllTextSeparateThreadFromDB();
}
