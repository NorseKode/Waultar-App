import 'dart:io';
import 'dart:math';

import 'package:image/image.dart' as img;
import 'package:collection/collection.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:tflite_flutter_helper/tflite_flutter_helper.dart';
import 'package:tuple/tuple.dart';
import 'package:waultar/configs/exceptions/ai_exception.dart';
import 'package:waultar/configs/globals/app_logger.dart';
import 'package:waultar/configs/globals/globals.dart';
import 'package:waultar/core/ai/i_ml_model.dart';
import 'package:waultar/core/helpers/performance_helper.dart';
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
  final _performance = locator.get<PerformanceHelper>(instanceName: 'performance');

  @override
  dispose() {
    interpreterOptions = null;
    _interpreter.close();
    
    if (ISPERFORMANCETRACKING) {
      _performance.addData(_performance.parentKey,
          duration: _performance.stopReading(_performance.parentKey));
      _performance.summary("Image Classifier Abstract Class");
    }

    return true;
  }

  @override
  init() {
    _appLogger.logger.info("Init of image classifier called");
    
    if (ISPERFORMANCETRACKING) {
      _performance.init(newParentKey: "Image Classifier");
      _performance.startReading(_performance.parentKey);
    }

    // interpreterOptions = InterpreterOptions();
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
    this.interpreterOptions,
  }) {
    init();
  }

  void _loadModel() async {
    var path = locator.get<String>(instanceName: 'ai_folder');
    _interpreter = Interpreter.fromFile(File(modelPath), path, options: interpreterOptions);

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
    _appLogger.logger.info(
        "Predicting image with path: $imagePath, and returning $amountOfTopCategories categories");

    var parentKey = "Predict All";
    PerformanceHelper? performance2;
    if (ISPERFORMANCETRACKING) {
      performance2 = PerformanceHelper(pathToPerformanceFile: '');
      performance2.init(newParentKey: parentKey);
      performance2.startReading(parentKey);
    }

    if (ISPERFORMANCETRACKING) {
      performance2!.startReading("Image from disk");
    }
    var image = img.decodeImage(File(imagePath).readAsBytesSync());
    if (image == null) {
      performance2!.dispose();
      throw AIException("Couldn't locate image from path: $imagePath", this, image);
    }
    if (ISPERFORMANCETRACKING) {
      performance2!.addReading(performance2.parentKey, "Image from disk", performance2.stopReading("Image from disk"));
    }

    if (ISPERFORMANCETRACKING) {
      performance2!.startReading("Pre process");
    }
    _inputImage = TensorImage(_inputType);
    _inputImage.loadImage(image);
    _inputImage = _preProcess();
    if (ISPERFORMANCETRACKING) {
      performance2!.addReading(parentKey, "Pre process", performance2.stopReading("Pre process"));
    }

    if (ISPERFORMANCETRACKING) {
      performance2!.startReading("Run prediction");
    }
    _interpreter.run(_inputImage.buffer, _outputBuffer.getBuffer());
    if (ISPERFORMANCETRACKING) {
      performance2!.addReading(parentKey, "Run prediction", performance2.stopReading("Run prediction"));
    }

    if (ISPERFORMANCETRACKING) {
      performance2!.startReading("Get results");
    }
    Map<String, double> labeledProb =
        TensorLabel.fromList(_labels, _probabilityProcessor.process(_outputBuffer))
            .getMapWithFloatValue();
    final pred = _getProbability(labeledProb).toList();

    var results = <Tuple2<String, double>>[];

    for (var i = 0; i < amountOfTopCategories; i++) {
      // if (pred[i].value > 0.75) {
        results.add(Tuple2(pred[i].key, pred[i].value));
      // }
    }
    if (ISPERFORMANCETRACKING) {
      performance2!.addReading(parentKey, "Get results", performance2.stopReading("Get results"));
    }

    if (ISPERFORMANCETRACKING) {
      performance2!.addData(parentKey, duration: performance2.stopReading(parentKey));
      _performance.addDataPoint(_performance.parentKey, performance2.parentDataPoint);
    }

    _appLogger.logger.info("Found following tags: ${results.toString()} to image: $imagePath");

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
