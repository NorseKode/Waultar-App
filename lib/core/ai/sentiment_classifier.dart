import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path/path.dart' as path_dart;

// Import tflite_flutter
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:waultar/assets/assets_helper.dart';
import 'package:waultar/configs/globals/app_logger.dart';
import 'package:waultar/configs/globals/helper/performance_helper.dart';
import 'package:waultar/core/ai/i_ml_model.dart';
import 'package:waultar/startup.dart';

class SentimentClassifier extends IMLModel {
  // name of the model file
  late String modelPath;
  late String vocabPath;
  // Maximum length of sentence
  final int _sentenceLen = 256;

  final String start = '<START>';
  final String pad = '<PAD>';
  final String unk = '<UNKNOWN>';

  late Map<String, int> _dict;
  final _appLogger = locator.get<AppLogger>(instanceName: 'logger');

  // TensorFlow Lite Interpreter object
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

  _loadModel() async {
    // Creating the interpreter using Interpreter.fromAsset
    _interpreter = await Interpreter.fromFile(File(modelPath));
  }

  _loadDictionary() async {
    final vocab = await File(vocabPath).readAsString();
    var dict = <String, int>{};
    final vocabList = vocab.split('\n');
    for (var i = 0; i < vocabList.length; i++) {
      var entry = vocabList[i].trim().split(' ');
      dict[entry[0]] = int.parse(entry[1]);
    }
    _dict = dict;
  }

  List<double> classify(String rawText) {
    var startTime = DateTime.now();
    // tokenizeInputText returns List<List<double>>
    // of shape [1, 256].
    List<List<double>> input = tokenizeInputText(rawText);

    // output of shape [1,2].
    var output = List<double>.filled(2, 0).reshape([1, 2]);

    // The run method will run inference and
    // store the resulting values in output.
    _interpreter.run(input, output);
    PerformanceHelper.logRunTime(
        startTime, DateTime.now(), _appLogger, "Classifying of text: $rawText");
    return [output[0][0], output[0][1]];
  }

  List<List<double>> tokenizeInputText(String text) {
    // Whitespace tokenization
    final toks = text.split(' ');

    // Create a list of length==_sentenceLen filled with the value <pad>
    var vec = List<double>.filled(_sentenceLen, _dict[pad]!.toDouble());

    var index = 0;
    if (_dict.containsKey(start)) {
      vec[index++] = _dict[start]!.toDouble();
    }

    // For each word in sentence find corresponding index in dict
    for (var tok in toks) {
      if (index > _sentenceLen) {
        break;
      }
      vec[index++] = _dict.containsKey(tok)
          ? _dict[tok]!.toDouble()
          : _dict[unk]!.toDouble();
    }

    // returning List<List<double>> as our interpreter input tensor expects the shape, [1,256]
    return [vec];
  }

  @override
  bool dispose() {
    _interpreter.close();

    return true;
  }
}
