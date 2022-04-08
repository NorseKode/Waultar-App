import 'dart:io';
import 'dart:math';

import 'package:image/image.dart' as img;
import 'package:collection/collection.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:tflite_flutter_helper/tflite_flutter_helper.dart';
import 'package:tuple/tuple.dart';
import 'package:waultar/configs/exceptions/ai_exception.dart';
import 'package:waultar/configs/globals/app_logger.dart';
import 'package:waultar/core/ai/i_ml_model.dart';
import 'package:waultar/startup.dart';

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
  late SequentialProcessor _probabilityProcessor;
  late List<List<int>> _outputShapes;
  late List<TfLiteType> _outputTypes;
  final _appLogger = locator.get<BaseLogger>(instanceName: 'logger');

  @override
  dispose() {
    interpreterOptions = null;
    _interpreter.close();

    return true;
  }

  @override
  init() {
    _appLogger.logger.info("Init of image classifier called");

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

  void _loadModel() async {
    var path = locator.get<String>(instanceName: 'ai_folder');
    _interpreter =
        Interpreter.fromFile(File(modelPath), path, options: interpreterOptions);

    var outputTensors = _interpreter.getOutputTensors();
    _outputShapes = [];
    _outputTypes = [];
    for (var tensor in outputTensors) {
      _outputShapes.add(tensor.shape);
      _outputTypes.add(tensor.type);
    }

    _inputShape = _interpreter.getInputTensor(0).shape;
    _outputShape = _interpreter.getOutputTensor(0).shape;
    _inputType = _interpreter.getInputTensor(0).type;
    _outputType = _interpreter.getOutputTensor(0).type;

    _outputBuffer = TensorBuffer.createFixedSize(_outputShape, _outputType);
    _probabilityProcessor =
        TensorProcessorBuilder().add(postProcessNormalizeOp).build();
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
        .add(ResizeOp(
            _inputShape[1], _inputShape[2], ResizeMethod.NEAREST_NEIGHBOUR))
        .add(preProcessNormalizeOp)
        .build()
        .process(_inputImage);
  }

  List<Tuple2<String, double>> predict(
      String imagePath, int amountOfTopCategories) {
    _appLogger.logger.info(
        "Predicting image with path: $imagePath, and returning $amountOfTopCategories categories");

    // if (ISPERFORMANCETRACKING) {
    //   _performance = locator.get<PerformanceHelper>(instanceName: 'performance');
    //   _performance!.resetChild();
    //   _performance!.startChild();
    // }

    var image = img.decodeImage(File(imagePath).readAsBytesSync());
    if (image == null) {
      throw AIException(
          "Couldn't locate image from path: $imagePath", this, image);
    }

    _inputImage = TensorImage(_inputType);
    _inputImage.loadImage(image);
    _inputImage = _preProcess();

    _interpreter.run(_inputImage.buffer, _outputBuffer.getBuffer());

    Map<String, double> labeledProb = TensorLabel.fromList(
            _labels, _probabilityProcessor.process(_outputBuffer))
        .getMapWithFloatValue();
    final pred = _getProbability(labeledProb).toList();

    var results = <Tuple2<String, double>>[];

    for (var i = 0; i < amountOfTopCategories; i++) {
      if (pred[i].value > 0.75) {
        results.add(Tuple2(pred[i].key, pred[i].value));
      }
    }

    // if (ISPERFORMANCETRACKING) {
    //   _performance!.addChildReading(metadata: {"path": imagePath});
    // }

    return results;
  }

  PriorityQueue<MapEntry<String, double>> _getProbability(
      Map<String, double> labeledProb) {
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
