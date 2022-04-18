import 'package:path/path.dart' as path_dart;
import 'package:tflite_flutter_helper/tflite_flutter_helper.dart';
import 'package:waultar/core/ai/image_classifier.dart';
import 'package:waultar/startup.dart';

class ImageClassifierMobileNetV3Small extends ImageClassifier {
  ImageClassifierMobileNetV3Small()
      : super(
          modelPath: path_dart.join(locator.get<String>(instanceName: 'ai_folder'),
            "lite-model_imagenet_mobilenet_v3_small_075_224_classification_5_metadata_1.tflite",
          ),
          labelsPath: path_dart.join(locator.get<String>(instanceName: 'ai_folder'),
            "labels.txt",
          ),
          labelsLength: 1001,
          preProcessNormalizeOp: NormalizeOp(0, 255),
          postProcessNormalizeOp: NormalizeOp(0, 10),
          // interpreterOptions: InterpreterOptions(),
        );
}
