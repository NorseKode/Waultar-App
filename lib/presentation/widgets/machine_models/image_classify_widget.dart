import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waultar/configs/globals/image_model_enum.dart';
import 'package:waultar/core/abstracts/abstract_services/i_ml_service.dart';
import 'package:waultar/data/repositories/media_repo.dart';
import 'package:waultar/presentation/providers/theme_provider.dart';
import 'package:waultar/presentation/widgets/general/default_widgets/default_widget.dart';
import 'package:waultar/presentation/widgets/general/default_widgets/default_button.dart';
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
  var _isFastImageModel = false;

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
      threadCount: 3,
      imageModel: _isFastImageModel
          ? ImageModelEnum.efficientNetB4
          : ImageModelEnum.mobileNetV3Large,
    );
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

  String _timeEstimate(int count) {
    var timeEstimate = (count * 0.3).ceil();

    return "${'${(Duration(seconds: timeEstimate))}'.substring(2, 7)} ${timeEstimate < 60 ? "sec" : "min"}";
  }

  Widget _imageModelChooser() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "Should use fast tagger, it's less precise",
          style: TextStyle(
              color: Color.fromARGB(255, 149, 150, 159),
              fontFamily: "Poppins",
              fontSize: 12,
              fontWeight: FontWeight.w500),
        ),
        SizedBox(
            height: 20,
            width: 20,
            child: Transform.scale(
                scale: 0.8,
                child: Checkbox(
                    activeColor: themeProvider.themeMode().themeColor,
                    value: _isFastImageModel,
                    onChanged: (value) {
                      setState(() {
                        if (value != null) {
                          _isFastImageModel = value;
                        } else {
                          _isFastImageModel = !_isFastImageModel;
                        }
                      });
                    })))
      ],
    );
    // return Column(
    //   children: [
    //     const Align(
    //       alignment: Alignment.centerLeft,
    //       child: Text("Should use fast tagger, it's less precise"),
    //     ),
    //     Align(
    //       alignment: Alignment.centerLeft,
    //       child: Checkbox(
    //         value: _isFastImageModel,
    //         onChanged: (value) {
    //           setState(() {
    //             if (value != null) {
    //               _isFastImageModel = value;
    //             } else {
    //               _isFastImageModel = !_isFastImageModel;
    //             }
    //           });
    //         },
    //       ),
    //     ),
    //   ],
    // );
  }

  Widget _mainBody() {
    return DefaultWidget(
      title: "Image Classification",
      description: "Analyse the content of your images.",
      child: _isLoading
          ? _loadingScreen()
          : _imagesToTagCount == 0
              ? Row(
                  children: const [
                    Text("No Images To Tag"),
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "How many images to tag?",
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 40,
                      child: TextFormField(
                          style: const TextStyle(fontSize: 12),
                          cursorWidth: 1,
                          keyboardType: TextInputType.number,
                          controller: _amountToTagTextController,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(left: 15),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: (const Color(0xFF323346)),
                            hintText: "Enter a number ...",
                            hintStyle: const TextStyle(letterSpacing: 0.3),
                          )),
                    ),
                    const SizedBox(height: 20),
                    _imageModelChooser(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Untagged Images Count: ",
                            style: TextStyle(
                                color: Color.fromARGB(255, 149, 150, 159),
                                fontFamily: "Poppins",
                                fontSize: 12,
                                fontWeight: FontWeight.w500)),
                        Text("$_imagesToTagCount",
                            style: const TextStyle(fontSize: 12)),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Estimated Time To Tag All: ",
                          style: TextStyle(
                              color: Color.fromARGB(255, 149, 150, 159),
                              fontFamily: "Poppins",
                              fontSize: 12,
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          _timeEstimate(_imagesToTagCount),
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: DefaultButton(
                            text: "Tag Images",
                            onPressed: () {
                              _tagImages();
                            },
                          ),
                        ),
                      ],
                    )
                  ],
                ),
    );
  }
}
