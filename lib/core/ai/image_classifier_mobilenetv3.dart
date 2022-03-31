import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:path/path.dart' as path_dart;
import 'package:tflite_flutter_helper/tflite_flutter_helper.dart';
import 'package:waultar/assets/assets_helper.dart';
import 'package:waultar/core/ai/image_classifier.dart';
import 'package:waultar/startup.dart';

class ImageClassifierMobileNetV3 extends ImageClassifier {
  ImageClassifierMobileNetV3({String? aiFolder})
      : super(
          modelPath: path_dart.join(aiFolder ??
            locator.get<String>(instanceName: 'ai_folder'),
            "imagenet_mobilenet_v3_large_100_224_classification_5_metadata_1.tflite",
          ),
          labelsPath: path_dart.join(aiFolder ??
            locator.get<String>(instanceName: 'ai_folder'),
            "labels.txt",
          ),
          labelsLength: 1001,
          preProcessNormalizeOp: NormalizeOp(0, 255),
          postProcessNormalizeOp: NormalizeOp(0, 10),
          interpreterOptions: InterpreterOptions(),
        );
}
