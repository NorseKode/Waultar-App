// ignore_for_file: file_names

import 'package:path/path.dart' as path_dart;
import 'package:waultar/assets/assets_helper.dart';
import 'package:waultar/core/ai/sentiment_classifier.dart';

class SentimentClassifierTextClassifierTFLite extends SentimentClassifier {
  SentimentClassifierTextClassifierTFLite()
      : super(
            modelPath: path_dart.normalize(
              path_dart.join(
                AssetsHelper.getPathToAILib(),
                "text_classification.tflite",
              ),
            ),
            vocabPath: path_dart.join(
              AssetsHelper.getPathToAILib(),
              "text_classification_vocab.txt",
            ));
}
