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
      title: "Image Classification",
      description: "Analyse the content of your images.",
      child: _isLoading
          ? _loadingScreen()
          : _imagesToTagCount == 0
              ? const Text("No Images To Tag")
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "How many images to tag?",
                      style:
                          TextStyle(fontWeight: FontWeight.w400, fontSize: 11),
                    ),
                    SizedBox(height: 10),
                    Container(
                      height: 40,
                      child: TextFormField(
                          style: TextStyle(fontSize: 12),
                          cursorWidth: 1,
                          keyboardType: TextInputType.number,
                          controller: _amountToTagTextController,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(left: 15),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: (const Color(0xFF323346)),
                            hintText: "Enter a number ...",
                            hintStyle: TextStyle(letterSpacing: 0.3),
                          )),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Untagged Images Count: ",
                            style: const TextStyle(
                                color: Color.fromARGB(255, 149, 150, 159),
                                fontFamily: "Poppins",
                                fontSize: 11,
                                fontWeight: FontWeight.w500)),
                        Text("$_imagesToTagCount",
                            style: TextStyle(fontSize: 11)),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Estimated Time To Tag All: ",
                          style: const TextStyle(
                              color: Color.fromARGB(255, 149, 150, 159),
                              fontFamily: "Poppins",
                              fontSize: 11,
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          "${(_imagesToTagCount * 0.4) / 60} min",
                          style: TextStyle(fontSize: 11),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        DefaultButton(
                          text: "Tag Images",
                          onPressed: () {
                            _tagImages();
                          },
                        ),
                      ],
                    )
                  ],
                ),
    );
  }
}
