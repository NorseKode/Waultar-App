import 'dart:io';
import 'dart:math';

import 'package:image/image.dart';
import 'package:path/path.dart' as path_dart;
import 'package:collection/collection.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:tflite_flutter_helper/tflite_flutter_helper.dart';
import 'package:flutter/services.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:waultar/core/ai/i_ml_model.dart';

class ImageClassifier extends IMLModel {
  late Interpreter _interpreter;
  InterpreterOptions? interpreterOptions;
  String? modelPath;
  String? labelsPath;
  late List<String> _labels;
  int? labelsLength;
  NormalizeOp? preProcessNormalizeOp = NormalizeOp(127.5, 127.5);
  NormalizeOp? postProcessNormalizeOp = NormalizeOp(0, 1);
  late List<int> _inputShape;
  late List<int> _outputShape;
  late TensorImage _inputImage;
  late TensorBuffer _outputBuffer;
  late TfLiteType _inputType;
  late TfLiteType _outputType;
  late var _probabilityProcessor;

  @override
  dispose() {
    _interpreter.close();
  }

  ImageClassifier({this.interpreterOptions, this.modelPath, this.labelsPath, this.labelsLength, this.preProcessNormalizeOp, this.postProcessNormalizeOp}) {
    interpreterOptions ??= InterpreterOptions();

    var _pathToLib = path_dart
        .normalize(
          path_dart.join(
            path_dart.dirname(Platform.script.path),
            "lib",
            "assets",
            "ai_models",
          ),
        )
        .substring(1);

    modelPath = path_dart.join(_pathToLib, "mobilenet_v1_1.0_224.tflite");
    labelsPath = path_dart.join(_pathToLib, "labels.txt");
    labelsLength = 1001;

    _loadModel();
    _loadLabels();
  }

  void _loadModel() {
    _interpreter = Interpreter.fromFile(File(modelPath!), options: interpreterOptions!);

    _inputShape = _interpreter.getInputTensor(0).shape;
    _outputShape = _interpreter.getOutputTensor(0).shape;
    _inputType = _interpreter.getInputTensor(0).type;
    _outputType = _interpreter.getOutputTensor(0).type;

    _outputBuffer = TensorBuffer.createFixedSize(_outputShape, _outputType);
    _probabilityProcessor = TensorProcessorBuilder().add(postProcessNormalizeOp!).build();
  }

  void _loadLabels() {
    _labels = FileUtil.loadLabelsFromFile(File(labelsPath!));

    if (_labels.length != labelsLength) {
      throw "Labels load error, different from expected amount";
    }
  }

  TensorImage _preProcess() {
    int cropSize = min(_inputImage.height, _inputImage.width);

    return ImageProcessorBuilder()
        .add(ResizeWithCropOrPadOp(cropSize, cropSize))
        .add(ResizeOp(_inputShape[1], _inputShape[2], ResizeMethod.NEAREST_NEIGHBOUR))
        .add(preProcessNormalizeOp!)
        .build()
        .process(_inputImage);
  }

  List<Category> predict(Image image, int amountOfTopCategories) {
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
    final pred = _getProbability(labeledProb);

    var categories = <Category>[];

    for (var i = 0; i < amountOfTopCategories; i++) {
      categories.add(Category(pred.toList()[i].key, pred.toList()[i].value));
    }

    return categories;
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


// class ClassifierQuant extends ImageClassifierTemp {
//   ClassifierQuant({int numThreads: 1}) : super(numThreads: numThreads);

//   @override
//   String get modelName => 'mobilenet_v1_1.0_224_quant.tflite';

//   @override
//   NormalizeOp get preProcessNormalizeOp => NormalizeOp(0, 1);

//   @override
//   NormalizeOp get postProcessNormalizeOp => NormalizeOp(0, 255);
// }

// class ClassifierFloat extends ImageClassifierTemp {
//   ClassifierFloat({int? numThreads}) : super(numThreads: numThreads);

//   @override
//   String get modelName => 'mobilenet_v1_1.0_224.tflite';

//   @override
//   NormalizeOp get preProcessNormalizeOp => NormalizeOp(127.5, 127.5);

//   @override
//   NormalizeOp get postProcessNormalizeOp => NormalizeOp(0, 1);
// }
