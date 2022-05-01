import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';
import 'package:waultar/configs/globals/image_model_enum.dart';
import 'package:waultar/core/abstracts/abstract_services/i_ml_service.dart';
import 'package:waultar/data/repositories/media_repo.dart';
import 'package:waultar/presentation/providers/theme_provider.dart';
import 'package:waultar/presentation/widgets/general/default_widgets/default_widget.dart';
import 'package:waultar/presentation/widgets/general/util_widgets/default_button.dart';
import 'package:waultar/presentation/widgets/upload/upload_files.dart';
import 'package:waultar/startup.dart';

class ImageClassifySingleWidget extends StatefulWidget {
  const ImageClassifySingleWidget({Key? key}) : super(key: key);

  @override
  State<ImageClassifySingleWidget> createState() => _ImageClassifySingleWidgetState();
}

class _ImageClassifySingleWidgetState extends State<ImageClassifySingleWidget> {
  @override
  Widget build(BuildContext context) {
    // _imagesToTagCount = _mediaRepo.getAmountOfUnTaggedImages();
    themeProvider = Provider.of<ThemeProvider>(context);

    return _mainBody();
  }

  late ThemeProvider themeProvider;
  File? _uploadedFile;
  String _fileName = "";
  List<Tuple2<String, double>>? _classifyResults;
  final _mlService = locator.get<IMLService>(instanceName: 'mlService');
  var _progressMessage = "Processing";
  var _isLoading = false;
  var _isFastImageModel = false;

  _onImageTaggingProgress(String message, bool isDone) {
    setState(() {
      _progressMessage = message;
      _isLoading = !isDone;
      if (isDone) {
        _progressMessage = "Processing";
      }
    });
  }

  _tagImage() {
    setState(() {
      _isLoading = true;
    });

    if (_uploadedFile != null) {
      _classifyResults = _mlService.classifySingleImage(
        imageFile: _uploadedFile!,
        imageModel:
            _isFastImageModel ? ImageModelEnum.mobileNetV3Large : ImageModelEnum.efficientNetB4,
      );
    }

    setState(() {
      _isLoading = false;
    });
  }

  Widget _loadingScreen() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(_progressMessage),
        const SizedBox(height: 20),
        const Center(child: CircularProgressIndicator())
      ],
    );
  }

  Widget _imageModelChooser() {
    return Column(
      children: [
        const Align(
          alignment: Alignment.centerLeft,
          child: Text("Should use fast tagger, it's less precise"),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Checkbox(
            value: _isFastImageModel,
            onChanged: (value) {
              setState(() {
                if (value != null) {
                  _isFastImageModel = value;
                } else {
                  _isFastImageModel = !_isFastImageModel;
                }
              });
            },
          ),
        ),
      ],
    );
  }

  Widget _uploadAndTag() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 10,
        ),
        const Text(
          "Upload Image To Tag",
          style: TextStyle(fontWeight: FontWeight.w400, fontSize: 11),
        ),
        DefaultButton(
          text: "Upload Image",
          onPressed: () async {
            _uploadedFile = await FileUploader.uploadSingle();
            setState(() {
              if (_uploadedFile != null) {
                _fileName = _uploadedFile!.path;
              }
            });
          },
        ),
        Text(_fileName),
        const SizedBox(height: 10),
        _imageModelChooser(),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: DefaultButton(
                text: "Tag Images",
                onPressed: _uploadedFile != null
                    ? () => _tagImage()
                    : null,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Text("Results"),
        _classifyResults != null
            ? Text(
                _classifyResults!.fold<String>(
                    "",
                    (previousValue, element) =>
                        previousValue += "${element.item1}: ${element.item2}%\n"),
              )
            : Container(),
      ],
    );
  }

  Widget _mainBody() {
    return DefaultWidget(
      title: "Image Classification",
      description: "Run the Image Classifier on a single image",
      child: _isLoading ? _loadingScreen() : _uploadAndTag(),
    );
  }
}
