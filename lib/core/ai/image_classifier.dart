import 'dart:io';
import 'dart:math';

import 'package:image/image.dart' as img;
import 'package:path/path.dart' as path_dart;
import 'package:collection/collection.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:tflite_flutter_helper/tflite_flutter_helper.dart';
import 'package:flutter/services.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:tuple/tuple.dart';
import 'package:waultar/core/ai/i_ml_model.dart';

class ImageClassifier extends IMLModel {
  late Interpreter _interpreter;
  InterpreterOptions? interpreterOptions;
  String modelPath;
  String labelsPath;
  late List<String> _labels;
  int labelsLength;
  NormalizeOp preProcessNormalizeOp;
  NormalizeOp postProcessNormalizeOp;
  late List<int> _inputShape;
  late List<int> _outputShape;
  late TensorImage _inputImage;
  late TensorBuffer _outputBuffer;
  late TfLiteType _inputType;
  late TfLiteType _outputType;
  late var _probabilityProcessor;

  @override
  dispose() {
    interpreterOptions = null;
    _interpreter.close();

    return true;
  }

  @override
  init() {
    interpreterOptions = InterpreterOptions();
    _loadModel();
    _loadLabels();

    return true;
  }

  ImageClassifier({
    required this.modelPath,
    required this.labelsPath,
    required this.labelsLength,
    required this.preProcessNormalizeOp,
    required this.postProcessNormalizeOp,
    required this.interpreterOptions,
  }) {
    init();
  }

  void _loadModel() {
    _interpreter = Interpreter.fromFile(File(modelPath), options: interpreterOptions!);

    _inputShape = _interpreter.getInputTensor(0).shape;
    _outputShape = _interpreter.getOutputTensor(0).shape;
    _inputType = _interpreter.getInputTensor(0).type;
    _outputType = _interpreter.getOutputTensor(0).type;

    _outputBuffer = TensorBuffer.createFixedSize(_outputShape, _outputType);
    _probabilityProcessor = TensorProcessorBuilder().add(postProcessNormalizeOp).build();
  }

  void _loadLabels() {
    _labels = FileUtil.loadLabelsFromFile(File(labelsPath));

    if (_labels.length != labelsLength) {
      throw "Labels load error, different from expected amount";
    }
  }

  TensorImage _preProcess() {
    int cropSize = min(_inputImage.height, _inputImage.width);

    return ImageProcessorBuilder()
        .add(ResizeWithCropOrPadOp(cropSize, cropSize))
        .add(ResizeOp(_inputShape[1], _inputShape[2], ResizeMethod.NEAREST_NEIGHBOUR))
        .add(preProcessNormalizeOp)
        .build()
        .process(_inputImage);
  }

  List<Tuple2<String, double>> predict(String imagePath, int amountOfTopCategories) {
    // TODO-Lukas_ exceptions
    var image = img.decodeImage(File(imagePath).readAsBytesSync())!;

    final pres = DateTime.now().millisecondsSinceEpoch;
    _inputImage = TensorImage(_inputType);
    _inputImage.loadImage(image);
    _inputImage = _preProcess();
    final pre = DateTime.now().millisecondsSinceEpoch - pres;

    final runs = DateTime.now().millisecondsSinceEpoch;
    _interpreter.run(_inputImage.buffer, _outputBuffer.getBuffer());
    final run = DateTime.now().millisecondsSinceEpoch - runs;

    Map<String, double> labeledProb =
        TensorLabel.fromList(_labels, _probabilityProcessor.process(_outputBuffer))
            .getMapWithFloatValue();
    final pred = _getProbability(labeledProb).toList();

    var results = <Tuple2<String, double>>[];

    for (var i = 0; i < amountOfTopCategories; i++) {
      results.add(Tuple2(pred[i].key, pred[i].value));
    }

    return results;
  }

  PriorityQueue<MapEntry<String, double>> _getProbability(Map<String, double> labeledProb) {
    var pq = PriorityQueue<MapEntry<String, double>>(_compare);
    pq.addAll(labeledProb.entries);

    return pq;
  }

  int _compare(MapEntry<String, double> e1, MapEntry<String, double> e2) {
    if (e1.value > e2.value) {
      return -1;
    } else if (e1.value == e2.value) {
      return 0;
    } else {
      return 1;
    }
  }
}
