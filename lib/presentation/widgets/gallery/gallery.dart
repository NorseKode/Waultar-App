import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:waultar/configs/globals/file_type_enum.dart';
import 'package:waultar/data/entities/media/image_document.dart';
import 'package:waultar/data/repositories/media_repo.dart';
import 'package:waultar/presentation/providers/theme_provider.dart';
import 'package:waultar/presentation/widgets/general/default_widgets/default_widget.dart';
import 'package:waultar/presentation/widgets/general/infinite_scroll.dart';

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
  static const _step = 2;
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

  _searchField() {
    return TextField(
      controller: _textSearchController,
      onChanged: (change) {
        setState(() {
          _searchImagesInit(change);
        });
      },
    );
  }

  Widget _contentSelectionRadio() {
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
    return Column(
      children: [
        if (_selectedMediaType == FileType.image) _searchField(),
        _contentSelectionRadio(),
      ],
    );
  }

  _imageList() {
    switch (_selectedMediaType) {
      case FileType.image:
        return Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            controller: _imageListScrollController,
            itemCount: _images.length,
            itemBuilder: (_, index) => Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
              child: DefaultWidget(
                title: "Image",
                child: Column(
                  children: [
                    Image.file(
                      File(Uri.decodeFull(_images[index].uri)),
                      fit: BoxFit.fill,
                    ),
                    Text(
                      _images[index].mediaTags != ""
                          ? _images[index].mediaTags.split(",").fold(
                              "",
                              (previousValue, element) =>
                                  previousValue += element + "\n")
                          : "No tags found",
                    )
                  ],
                ),
              ),
            ),
          ),
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
    return Column(
      children: [
        _topBar(),
        _imageList(),
      ],
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
