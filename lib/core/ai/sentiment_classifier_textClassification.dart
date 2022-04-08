// ignore: file_names
import 'package:path/path.dart' as path_dart;
import 'package:waultar/core/ai/sentiment_classifier.dart';
import 'package:waultar/startup.dart';

class SentimentClassifierTextClassifierTFLite extends SentimentClassifier {
  SentimentClassifierTextClassifierTFLite()
      : super(
            modelPath: path_dart.join(
                locator.get<String>(instanceName: 'ai_folder'),
                "text_classification.tflite"), //text_classifitcation.tflite
            vocabPath: path_dart.join(
                locator.get<String>(instanceName: 'ai_folder'),
                "text_classification_vocab.txt"));
}
