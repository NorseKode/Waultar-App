import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:tuple/tuple.dart';
import 'package:waultar/configs/globals/file_type_enum.dart';
import 'package:waultar/core/inodes/media_documents.dart';
import 'package:waultar/core/inodes/media_repo.dart';
import 'package:waultar/presentation/providers/theme_provider.dart';
import 'package:waultar/presentation/widgets/general/default_widgets/default_widget.dart';
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
  var _videos = <VideoDocument>[];
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

    scrollInit();
  }

  @override
  void dispose() {
    super.dispose();
    _imageListScrollController.removeListener(_onScrollEnd);
  }

  void _scrollReset() {
    _offset = 0;
    _limit = _step;
    _imageListScrollController.jumpTo(0);
  }

  void _searchImagesInit(String searchText) {
    _imageListScrollController.jumpTo(0);
    _isSearch = true;
    _offset = 0;
    _limit = _step;

    _images = _mediaRepo.searchImagesPagination(searchText, _offset, _limit);
  }

  void scrollInit() {
    switch (_selectedMediaType) {
      case FileType.image:
        _images = _mediaRepo.getImagesPagination(_offset, _limit);
        break;
      case FileType.video:
        
        break;
      default:
    }
  }

  void _onScrollEnd() {
    if (_imageListScrollController.position.maxScrollExtent ==
        _imageListScrollController.position.pixels) {
      setState(() {
        _offset += _limit;

        if (_isSearch) {
          _images += _mediaRepo.searchImagesPagination(_textSearchController.text, _offset, _limit);
        } else {
          _images += _mediaRepo.getImagesPagination(_offset, _limit);
        }
      });
    }
  }

  _searchField() {
    return Wrap(
      spacing: 10.0,
      children: [
        TextField(
          controller: _textSearchController,
          onChanged: (change) {
            setState(() {
              _searchImagesInit(change);
            });
          },
        ),
      ],
    );
  }

  Widget _contentSelectionRadio() {
    return Container(
      child: Wrap(
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
          ListTile(
            title: Text("Images"),
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
          ListTile(
            title: Text("Videoes"),
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
          ListTile(
            title: Text("Files"),
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
    return Expanded(
      child: ListView.builder(
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
                      ? _images[index]
                          .mediaTags
                          .split(",")
                          .fold("", (previousValue, element) => previousValue += element + "\n")
                      : "No tags found",
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: 600),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _topBar(),
          _imageList(),
        ],
      ),
    );
  }
}

// Wdiget getScrollView(int itemLength, Function createItemWidget) {
//   var _scrollController = ScrollController();



//  return ListView.builder(
//         controller: _scrollController,
//         itemCount: itemLength,
//         itemBuilder: (_, index) => createItemWidget(index)
        
//         // Padding(
//         //   padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
//         //   child: DefaultWidget(
//         //     title: "Image",
//         //     child: Column(
//         //       children: [
//         //         Image.file(
//         //           File(Uri.decodeFull(_images[index].uri)),
//         //           fit: BoxFit.fill,
//         //         ),
//         //         Text(
//         //           _images[index].mediaTags != ""
//         //               ? _images[index]
//         //                   .mediaTags
//         //                   .split(",")
//         //                   .fold("", (previousValue, element) => previousValue += element + "\n")
//         //               : "No tags found",
//         //         )
//         //       ],
//         //     ),
//         //   ),
//         // ),
//       );
// }