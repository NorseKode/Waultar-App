import 'dart:io';

import 'package:collection/collection.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:waultar/configs/globals/app_logger.dart';
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
  final _appLogger = locator.get<BaseLogger>(instanceName: 'logger');

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

  _loadModel() {
    // Creating the interpreter using Interpreter.fromAsset
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

      // tokenizeInputText returns List<List<double>>
      // of shape [1, 256].
      //List<List<int>> input = tokenizeInputText(rawText);
      var input = tokenizeInputText(first256 ?? rawText);

      if (input != null) {
        // output of shape [1,2].
        var output = List<int>.filled(2, 0).reshape([1, 2]);
        //var output = List<int>.filled(384, 0).reshape([1, 384]);

        // The run method will run inference and
        // store the resulting values in output.
        //print(_interpreter.getOutputTensors());
        _interpreter.run(input, output);
        //_interpreter.runForMultipleInputs(input, {0: output, 1: output});

        finalScore[0] += output[0][0];
        finalScore[1] += output[0][1];
        scoreCount++;
      } 
    } while (!isLastIt);

    return scoreCount == 0 ? [-1, -1] : [finalScore[0] / scoreCount, finalScore[1] / scoreCount];
  }

  List<List<double>>? tokenizeInputText(String text) {
    var isNonEmpty = false;
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
      if (_dict.containsKey(tok)) {
        isNonEmpty = true;
        vec[index++] = _dict[tok]!.toDouble();
      } else {
        vec[index++] = _dict[unk]!.toDouble();
      }
    }

    // returning List<List<double>> as our interpreter input tensor expects the shape, [1,256]
    return isNonEmpty ? [vec] : null;
  }

  @override
  bool dispose() {
    _interpreter.close();

    return true;
  }
}
