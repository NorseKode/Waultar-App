
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:path/path.dart' as path_dart;
import 'package:tflite_flutter_helper/tflite_flutter_helper.dart';
import 'package:waultar/assets/assets_helper.dart';
import 'package:waultar/core/ai/image_classifier.dart';

class ImageClassifierEfficientNet extends ImageClassifier {
  ImageClassifierEfficientNet()
      : super(
          modelPath: path_dart.join(AssetsHelper.getPathToAILib(), "efficientnet_lite4_fp32_2.tflite"),
          labelsPath: path_dart.join(
              AssetsHelper.getPathToAILib(), "labels_without_background.txt"), // TODO: probably not the correct labels
          labelsLength: 1000,
          preProcessNormalizeOp: NormalizeOp(127, 128),
          postProcessNormalizeOp: NormalizeOp(0, 1),
          interpreterOptions: InterpreterOptions(),
        );
}
