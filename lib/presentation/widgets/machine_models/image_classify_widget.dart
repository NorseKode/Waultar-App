import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waultar/core/abstracts/abstract_services/i_ml_service.dart';
import 'package:waultar/data/repositories/media_repo.dart';
import 'package:waultar/presentation/providers/theme_provider.dart';
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
    themeProvider = Provider.of<ThemeProvider>(context);

    return _mainBody();
  }

  late ThemeProvider themeProvider;
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
      constraints: const BoxConstraints(maxWidth: 300),
      title: "Image Classification",
      child: _isLoading
          ? _loadingScreen()
          : _imagesToTagCount == 0
              ? const Text("No Images To Tag")
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Analyse the content of your images.",
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      decoration: const InputDecoration(
                        hintText: "Enter a number",
                        label: Text("How many images to tag?"),
                      ),
                      controller: _amountToTagTextController,
                      keyboardType: TextInputType.number,
                    ),
                    Text("Untagged Images Count: $_imagesToTagCount"),
                    Text("Estimated Time To Tag All: ${(_imagesToTagCount * 0.4) / 60} minuets"),
                    const SizedBox(height: 10),
                    Divider(
                      height: 2,
                      thickness: 2,
                      color: themeProvider.themeMode().tonedColor,
                    ),
                    const SizedBox(height: 10),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          DefaultButton(
                            text: "       Tag Images       ",
                            onPressed: () {
                              _tagImages();
                            },
                          ),
                        ],
                      ),
                    )
                  ],
                ),
    );
  }
}
