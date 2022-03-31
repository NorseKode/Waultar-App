import 'package:flutter/material.dart';
import 'package:waultar/core/abstracts/abstract_services/i_ml_service.dart';
import 'package:waultar/data/repositories/media_repo.dart';
import 'package:waultar/presentation/widgets/general/default_widgets/default_widget.dart';
import 'package:waultar/presentation/widgets/general/util_widgets/default_button.dart';
import 'package:waultar/startup.dart';

class ImageClassifyWidget extends StatefulWidget {
  const ImageClassifyWidget({Key? key}) : super(key: key);

  @override
  State<ImageClassifyWidget> createState() => _ImageClassifyWidgetState();
}

class _ImageClassifyWidgetState extends State<ImageClassifyWidget> {
  @override
  Widget build(BuildContext context) {
    _imagesToTagCount = _mediaRepo.getAmountOfUnTaggedImages();

    return _mainBody();
  }

  final _amountToTagTextController = TextEditingController();
  final _mlService = locator.get<IMLService>(instanceName: 'mlService');
  final _mediaRepo = locator.get<MediaRepository>(instanceName: 'mediaRepo');
  var _progressMessage = "Initializing";
  var _imagesToTagCount = 0;
  var _isLoading = false;

  _onImageTaggingProgress(String message, bool isDone) {
    setState(() {
      _progressMessage = message;
      _isLoading = !isDone;
      if (isDone) {
        _progressMessage = "Initializing";
      }
    });
  }

  _tagImages() {
    setState(() {
      _isLoading = true;
    });

    _mlService.classifyImagesSeparateThread(
      callback: _onImageTaggingProgress,
      totalAmountOfImagesToTag: _imagesToTagCount,
      limitAmount: _amountToTagTextController.text.isNotEmpty
          ? int.parse(_amountToTagTextController.text)
          : null,
    );
  }

  Widget _loadingScreen() {
    return Column(
      children: [
        Text(_progressMessage),
        const CircularProgressIndicator(),
      ],
    );
  }

  Widget _mainBody() {
    return DefaultWidget(
      title: "Image Classification",
      child: _isLoading
          ? _loadingScreen()
          : Column(
              children: [
                Text("Untagged Images Count: $_imagesToTagCount"),
                TextField(
                  keyboardType: TextInputType.number,
                  controller: _amountToTagTextController,
                ),
                Text("Estimated Time To Tag All: ${(_imagesToTagCount * 0.2) / 60} minuets"),
                DefaultButton(
                  text: "Tag Images",
                  onPressed: () {
                    _tagImages();
                  },
                ),
              ],
            ),
    );
  }
}
