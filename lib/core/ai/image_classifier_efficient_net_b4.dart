import 'package:path/path.dart' as path_dart;
import 'package:tflite_flutter_helper/tflite_flutter_helper.dart';
import 'package:waultar/core/ai/image_classifier.dart';
import 'package:waultar/startup.dart';

class ImageClassifierEfficientNetB4 extends ImageClassifier {
  ImageClassifierEfficientNetB4()
      : super(
          modelPath: path_dart.join(locator.get<String>(instanceName: 'ai_folder'),
            "efficientnet_lite4_fp32_2.tflite",
          ),
          labelsPath: path_dart.join(locator.get<String>(instanceName: 'ai_folder'),
            "labels_eff.txt",
          ),
          labelsLength: 1000,
          preProcessNormalizeOp: NormalizeOp(127, 128),
          postProcessNormalizeOp: NormalizeOp(0, 1),
          // interpreterOptions: InterpreterOptions(),
        );
}
