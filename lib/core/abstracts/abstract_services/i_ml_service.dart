import 'package:tuple/tuple.dart';
import 'package:waultar/core/inodes/profile_document.dart';
import 'package:waultar/core/inodes/tree_nodes.dart';

abstract class IMLService {
  int classifyImage();
  int classifyImagesFromDB();
  Future<void> classifyAllImagesSeparateThreadFromDB();
  // double connotateText(String text);
  // int connotateTextsFromCategory(List<DataCategory> categories);
  // Future<void> connotateAllTextSeparateThreadFromDB();
}
