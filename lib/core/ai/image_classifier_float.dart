
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:path/path.dart' as path_dart;
import 'package:tflite_flutter_helper/tflite_flutter_helper.dart';
import 'package:waultar/assets/assets_helper.dart';
import 'package:waultar/core/ai/image_classifier.dart';

class ImageClassifierQuant extends ImageClassifier {
  ImageClassifierQuant()
      : super(
          modelPath: path_dart.join(AssetsHelper.getPathToAILib(), "mobilenet_v1_1.0_224.tflite"),
          labelsPath: path_dart.join(
              AssetsHelper.getPathToAILib(), "labels.txt"), // TODO: probably not the correct labels
          labelsLength: 1001,
          preProcessNormalizeOp: NormalizeOp(244, 244),
          postProcessNormalizeOp: NormalizeOp(0, 1),
          interpreterOptions: InterpreterOptions(),
        );
}
