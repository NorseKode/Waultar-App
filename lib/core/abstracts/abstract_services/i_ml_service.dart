import 'package:tuple/tuple.dart';
import 'package:waultar/core/models/media/image_model.dart';

abstract class IMLService {
  int classifyImage(ImageModel model);
  int classifyImagesFromDB();
  Future<void> classifyAllImagesSeparateThreadFromDB();
  double connotateText(String text);
  List<Tuple2<String, double>> connotateTextsFromList(List<String> list);
  Future<void> connotateAllTextSeparateThreadFromDB();
}
