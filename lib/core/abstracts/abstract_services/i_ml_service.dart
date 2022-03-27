import 'package:tuple/tuple.dart';
import 'package:waultar/core/inodes/profile_document.dart';
import 'package:waultar/core/inodes/tree_nodes.dart';
import 'package:waultar/core/models/media/image_model.dart';

abstract class IMLService {
  int classifyImage(ImageModel model);
  int classifyImagesFromDB();
  Future<void> classifyAllImagesSeparateThreadFromDB();
  double connotateText(String text);
  int connotateTextsFromCategory(List<DataCategory> categories);
  Future<void> connotateAllTextSeparateThreadFromDB();
}
