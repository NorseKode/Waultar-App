import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:waultar/configs/globals/file_type_enum.dart';
import 'package:waultar/data/entities/media/image_document.dart';
import 'package:waultar/data/repositories/media_repo.dart';
import 'package:waultar/presentation/providers/theme_provider.dart';
import 'package:waultar/presentation/widgets/general/default_widgets/default_widget.dart';
import 'package:waultar/presentation/widgets/general/default_widgets/default_widget_box.dart';
import 'package:waultar/presentation/widgets/general/infinite_scroll.dart';
import 'package:waultar/presentation/widgets/general/util_widgets/default_button.dart';

import 'package:waultar/startup.dart';

class Gallery extends StatefulWidget {
  const Gallery({Key? key}) : super(key: key);

  @override
  _GalleryState createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  late AppLocalizations localizer;
  late ThemeProvider themeProvider;
  var _isSearch = false;
  var _images = <ImageDocument>[];
  final _mediaRepo = locator.get<MediaRepository>(instanceName: 'mediaRepo');
  final _imageListScrollController = ScrollController();
  final _textSearchController = TextEditingController();
  static const _step = 8;
  var _offset = 0;
  var _limit = _step;
  FileType? _selectedMediaType = FileType.image;

  @override
  void initState() {
    super.initState();
    _imageListScrollController.addListener(_onScrollEnd);

    _images = _mediaRepo.getImagesPagination(_offset, _limit);
  }

  @override
  void dispose() {
    super.dispose();
    _imageListScrollController.removeListener(_onScrollEnd);
  }

  void _scrollReset() {
    _offset = 0;
    _limit = _step;
  }

  void _searchImagesInit(String searchText) {
    _imageListScrollController.jumpTo(0);
    _isSearch = true;
    _offset = 0;
    _limit = _step;

    _images = _mediaRepo.searchImagesPagination(searchText, _offset, _limit);
  }

  void scrollInit() {
    _images = _mediaRepo.getImagesPagination(_offset, _limit);
  }

  void _onScrollEnd() {
    if (_imageListScrollController.position.maxScrollExtent ==
        _imageListScrollController.position.pixels) {
      setState(() {
        _offset += _limit;

        if (_isSearch) {
          _images += _mediaRepo.searchImagesPagination(
              _textSearchController.text, _offset, _limit);
        } else {
          _images += _mediaRepo.getImagesPagination(_offset, _limit);
        }
      });
    }
  }

  // _searchField() {
  //   return TextField(
  //     controller: _textSearchController,
  //     onChanged: (change) {
  //       setState(() {
  //         _searchImagesInit(change);
  //       });
  //     },
  //   );
  // }

  Widget _contentSelectionRadio() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        children: [
          DefaultButton(
            constraints: BoxConstraints(maxHeight: 35),
            text: "Images",
            textColor: _selectedMediaType == FileType.image
                ? null
                : themeProvider.themeMode().tonedTextColor,
            icon: Iconsax.image,
            color: _selectedMediaType == FileType.image
                ? Colors.transparent
                : Colors.transparent,
            onPressed: () {
              setState(() {
                _selectedMediaType = FileType.image;
                _scrollReset();
              });
            },
          ),
          SizedBox(width: 10),
          DefaultButton(
            constraints: BoxConstraints(maxHeight: 35),
            text: "Video",
            textColor: _selectedMediaType == FileType.video
                ? null
                : themeProvider.themeMode().tonedTextColor,
            icon: Iconsax.video,
            color: _selectedMediaType == FileType.video
                ? Colors.transparent
                : Colors.transparent,
            onPressed: () {
              setState(() {
                _selectedMediaType = FileType.video;
                _scrollReset();
              });
            },
          ),
          SizedBox(width: 10),
          DefaultButton(
            constraints: BoxConstraints(maxHeight: 35),
            text: "Files",
            textColor: _selectedMediaType == FileType.file
                ? null
                : themeProvider.themeMode().tonedTextColor,
            icon: Iconsax.folder,
            color: _selectedMediaType == FileType.file
                ? Colors.transparent
                : Colors.transparent,
            onPressed: () {
              setState(() {
                _selectedMediaType = FileType.file;
                _scrollReset();
              });
            },
          ),
        ],
      ),
    );
    return Container(
      child: Wrap(
        spacing: 0,
        runSpacing: 0,
        runAlignment: WrapAlignment.spaceEvenly,
        direction: Axis.horizontal,
        children: [
          // ListTile(
          //   title: const Text("All"),
          //   leading: Radio<FileType>(
          //     value: FileType.all,
          //     groupValue: _selectedMediaType,
          //     onChanged: (value) {
          //       setState(() {
          //         _selectedMediaType = value;
          //       });
          //     },
          //   ),
          // ),
          SizedBox(
            width: 150,
            child: ListTile(
              title: const Text("Images"),
              leading: Radio<FileType>(
                value: FileType.image,
                groupValue: _selectedMediaType,
                onChanged: (value) {
                  setState(() {
                    _selectedMediaType = value;
                    _scrollReset();
                  });
                },
              ),
            ),
          ),
          SizedBox(
            width: 150,
            child: ListTile(
              title: const Text("Videos"),
              leading: Radio<FileType>(
                value: FileType.video,
                groupValue: _selectedMediaType,
                onChanged: (value) {
                  setState(() {
                    _selectedMediaType = value;
                    _scrollReset();
                  });
                },
              ),
            ),
          ),
          SizedBox(
            width: 150,
            child: ListTile(
              title: const Text("Files"),
              leading: Radio<FileType>(
                value: FileType.file,
                groupValue: _selectedMediaType,
                onChanged: (value) {
                  setState(() {
                    _selectedMediaType = value;
                    _scrollReset();
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _topBar() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Gallery",
          style: themeProvider.themeData().textTheme.headline3,
        ),
        SizedBox(width: 20),
        _contentSelectionRadio(),
        Expanded(child: Container()),
        if (_selectedMediaType == FileType.image) Expanded(child: _searchbar()),
      ],
    );
  }

  _imageList() {
    switch (_selectedMediaType) {
      case FileType.image:
        return Expanded(
          child: GridView.extent(
              maxCrossAxisExtent: 300,
              childAspectRatio: 0.85,
              shrinkWrap: true,
              controller: _imageListScrollController,
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
              children: List.generate(
                  _images.length,
                  (index) => Container(
                        decoration: BoxDecoration(
                            color: themeProvider.themeData().primaryColor),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 200,
                              width: 260,
                              child: Image.file(
                                File(Uri.decodeFull(_images[index].uri)),
                                width: 260,
                                height: 260,
                                alignment: Alignment.topLeft,
                                fit: BoxFit.contain,
                              ),
                            ),
                            SizedBox(height: 10),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Text(_images[index].mediaTags != ""
                                  ? _images[index]
                                      .mediaTags
                                      .split(",")
                                      .fold<String>(
                                          "",
                                          (previousValue, element) =>
                                              previousValue +=
                                                  (element.trim().isNotEmpty
                                                      ? element + "\n"
                                                      : ""))
                                      .trim()
                                  : "No tags found"),
                            ),
                          ],
                        ),
                      ))),
        );

      case FileType.video:
        return InfiniteScroll(
          step: 5,
          paginationFunction: _mediaRepo.getVideosPagination,
          builderWidgetGenerator: (List elements, int index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: DefaultWidget(
                title: "Video",
                child: Text(
                  elements[index].uri,
                ),
              ),
            );
          },
        );

      case FileType.file:
        return InfiniteScroll(
          step: 5,
          paginationFunction: _mediaRepo.getFilesPagination,
          builderWidgetGenerator: (List elements, int index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: DefaultWidget(
                title: "Files",
                child: Text(
                  elements[index].uri,
                ),
              ),
            );
          },
        );

      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    themeProvider = Provider.of<ThemeProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _topBar(),
        const SizedBox(height: 20),
        _imageList(),
      ],
    );
  }

  Widget _searchbar() {
    return Container(
      height: 40,
      child: TextFormField(
          style: TextStyle(fontSize: 12),
          cursorWidth: 1,
          keyboardType: TextInputType.number,
          controller: _textSearchController,
          onChanged: (change) {
            setState(() {
              _searchImagesInit(change);
            });
          },
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(left: 15),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: (const Color(0xFF272837)),
            hintText: "search gallery ...",
            hintStyle: TextStyle(letterSpacing: 0.3),
          )),
    );
  }

  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.center,
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     children: [
  //       _topBar(),
  //       _imageList(),
  //     ],
  //   );
  // }
}
