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

  List<double> classify(String rawText) {
    var finalScore = [0.0, 0.0];
    var scoreCount = 0;
    var isLastIt = rawText.length < 256;

    do {
      String? first256;

      if (!isLastIt) {
        first256 = rawText.substring(0, 256);
        rawText = rawText.substring(256);
      }

      isLastIt = rawText.length < 256;

      var input = tokenizeInputText(first256 ?? rawText);

      if (input != null) {
        var output = List<int>.filled(2, 0).reshape([1, 2]);

        _interpreter.run(input, output);

        finalScore[0] += output[0][0];
        finalScore[1] += output[0][1];
        scoreCount++;
      } 
    } while (!isLastIt);

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

    return isNonEmpty ? [vec] : null;
  }

  @override
  bool dispose() {
    _interpreter.close();

    return true;
  }
}
