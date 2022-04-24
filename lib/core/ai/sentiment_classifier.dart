import 'dart:io';

import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:waultar/configs/globals/app_logger.dart';
import 'package:waultar/core/ai/i_ml_model.dart';
import 'package:waultar/startup.dart';

class SentimentClassifier extends IMLModel {
  late String modelPath;
  late String vocabPath;
  final int _sentenceLen = 256;

  final String start = '<START>';
  final String pad = '<PAD>';
  final String unk = '<UNKNOWN>';

  late Map<String, int> _dict;
  final _appLogger = locator.get<BaseLogger>(instanceName: 'logger');

  late Interpreter _interpreter;

  @override
  init() {
    _loadModel();
    _loadDictionary();

    return true;
  }

  SentimentClassifier({required this.modelPath, required this.vocabPath}) {
    init();
  }

  _loadModel() {
    var path = locator.get<String>(instanceName: 'ai_folder');
    _interpreter = Interpreter.fromFile(File(modelPath), path);
  }

  _loadDictionary() {
    final vocab = File(vocabPath).readAsStringSync();
    var dict = <String, int>{};
    final vocabList = vocab.split('\n');
    for (var i = 0; i < vocabList.length; i++) {
      var entry = vocabList[i].trim().split(' ');
      dict[entry[0]] = int.parse(entry[1]);
    }
    _dict = dict;
  }

  /// Takes [rawText] and returns a list of doubles of length 2, with the first
  /// being the % negative and the second being the % positive
  ///
  /// If [rawText] doesn't contain any recognized text it will return a list
  /// with both elements being -1
  ///
  /// Taking the two doubles, if the [rawText] was recognized, and adding them
  /// together, they will sum up to 1
  List<double> classify(String rawText) {
    var finalScore = [0.0, 0.0];
    var scoreCount = 0;
    var isLastIt = rawText.length < 256;

    aux(String inputText) {
      var input = tokenizeInputText(inputText);

      if (input != null) {
        var output = List<int>.filled(2, 0).reshape([1, 2]);

        _interpreter.run(input, output);

        return output;
      } else {
        return null;
      }
    }

    while (rawText.length > 256) {
      var first256 = rawText.substring(0, 256);
      rawText = rawText.substring(256);

      var results = aux(first256);

      if (results != null) {
        finalScore[0] += results[0][0];
        finalScore[1] += results[0][1];
        scoreCount++;
      }
    }

    var results = aux(rawText);

    if (results != null) {
      finalScore[0] += results[0][0];
      finalScore[1] += results[0][1];
      scoreCount++;
    }

    return scoreCount == 0 ? [-1, -1] : [finalScore[0] / scoreCount, finalScore[1] / scoreCount];
  }

  List<List<double>>? tokenizeInputText(String text) {
    var isNonEmpty = false;
    final toks = text.split(' ');

    var vec = List<double>.filled(_sentenceLen, _dict[pad]!.toDouble());

    var index = 0;
    if (_dict.containsKey(start)) {
      vec[index++] = _dict[start]!.toDouble();
    }

    for (var tok in toks) {
      if (index > _sentenceLen) {
        break;
      }
      if (_dict.containsKey(tok)) {
        isNonEmpty = true;
        vec[index++] = _dict[tok]!.toDouble();
      } else {
        vec[index++] = _dict[unk]!.toDouble();
      }
    }

    // return isNonEmpty ? [vec] : [vec];
    return isNonEmpty ? [vec] : null;
  }

  @override
  bool dispose() {
    _interpreter.close();

    return true;
  }
}
