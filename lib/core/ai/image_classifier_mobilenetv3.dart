import 'dart:io';

import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:tflite_flutter_helper/src/common/ops/normailze_op.dart';
import 'package:path/path.dart' as path_dart;
import 'package:waultar/assets/assets_helper.dart';
import 'package:waultar/core/ai/image_classifier.dart';

class ImageClassifierMobileNetV3 extends ImageClassifier {
  ImageClassifierMobileNetV3()
      : super(
          modelPath: path_dart.join(AssetsHelper.getPathToAILib(), "imagenet_mobilenet_v3_large_100_224_classification_5_metadata_1.tflite"),
          labelsPath: path_dart.join(
              AssetsHelper.getPathToAILib(), "labels.txt"), // TODO: probably not the correct labels
          labelsLength: 1001,
          preProcessNormalizeOp: NormalizeOp(0, 1),
          postProcessNormalizeOp: NormalizeOp(0, 255),
          interpreterOptions: InterpreterOptions(),
        );
}
