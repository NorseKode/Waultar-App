import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:waultar/configs/globals/file_type_enum.dart';
import 'package:waultar/core/abstracts/abstract_services/i_search_service.dart';
import 'package:waultar/data/entities/media/image_document.dart';
import 'package:waultar/data/entities/misc/profile_document.dart';
import 'package:waultar/data/repositories/media_repo.dart';
import 'package:waultar/data/repositories/profile_repo.dart';
import 'package:waultar/presentation/providers/theme_provider.dart';
import 'package:waultar/presentation/widgets/general/default_widgets/default_dropdown.dart';
import 'package:waultar/presentation/widgets/general/default_widgets/default_widget.dart';
import 'package:waultar/presentation/widgets/general/infinite_scroll.dart';
import 'package:waultar/presentation/widgets/general/default_widgets/default_button.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

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
  var profiles = locator
      .get<ProfileRepository>(instanceName: 'profileRepo')
      .getAll()
      .map((e) => DefaultMenuItem(name: e.name, value: e))
      .toList();
  DefaultMenuItem? currentProfile;
  final _mediaRepo = locator.get<MediaRepository>(instanceName: 'mediaRepo');
  final _searchService =
      locator.get<ISearchService>(instanceName: 'searchService');
  final _imageListScrollController = ScrollController();
  final _textSearchController = TextEditingController();
  // final _logger = locator.get<BaseLogger>(instanceName: 'logger');
  // final _timer = Stopwatch();
  static const _step = 8;
  var _offset = 0;
  var _limit = _step;
  FileType? _selectedMediaType = FileType.image;
  var columnCount = 0;

  @override
  void initState() {
    super.initState();
    if (profiles.isNotEmpty) {
      currentProfile = profiles.first;
    }
    if (profiles.length > 1) {
      profiles.add(
          DefaultMenuItem(name: "All", value: ProfileDocument(name: "All")));
    }
    _imageListScrollController.addListener(_onScrollEnd);

    _images = _searchService.searchImages(
      _getSelectedProfiles(),
      "",
      _offset,
      _limit,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _imageListScrollController.removeListener(_onScrollEnd);
  }

  List<int> _getSelectedProfiles() {
    return currentProfile!.value.id == 0
        ? profiles.map<int>((e) => e.value.id).toList()
        : [currentProfile!.value.id];
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

    _images = _searchService.searchImages(
        _getSelectedProfiles(), searchText, _offset, _limit);
  }

  void scrollInit() {
    _images = _searchService.searchImages(
      _getSelectedProfiles(),
      "",
      _offset,
      _limit,
    );
  }

  void _onScrollEnd() {
    if (_imageListScrollController.position.maxScrollExtent ==
        _imageListScrollController.position.pixels) {
      setState(() {
        _offset += _limit;

        if (_isSearch) {
          _images += _searchService.searchImages(_getSelectedProfiles(),
              _textSearchController.text, _offset, _limit);
        } else {
          _images += _searchService.searchImages(
            _getSelectedProfiles(),
            "",
            _offset,
            _limit,
          );
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
            constraints: const BoxConstraints(maxHeight: 20),
            //text: "Images",
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
          const SizedBox(width: 10),
          DefaultButton(
            constraints: const BoxConstraints(maxHeight: 20),
            //text: "Video",
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
          const SizedBox(width: 10),
          DefaultButton(
            constraints: const BoxConstraints(maxHeight: 20),
            //text: "Files",
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

  void _changeSelectedProfile(DefaultMenuItem? profile) {
    if (profile != null) {
      setState(() {
        currentProfile = profile;
        _textSearchController.clear();
        _searchImagesInit(_textSearchController.text);
      });
    }
  }

  Widget _topBar() {
    return Row(
      children: [
        Text(
          "Gallery",
          style: themeProvider.themeData().textTheme.headline3,
        ),
        const SizedBox(width: 20),
        _contentSelectionRadio(),
        const SizedBox(width: 20),
        DefaultDropdown(
            items: profiles,
            value: currentProfile!,
            onChanged: _changeSelectedProfile),
      ],
    );
  }

  _imageList() {
    switch (_selectedMediaType) {
      case FileType.image:
        return Expanded(
            child: MasonryGridView.count(
          controller: _imageListScrollController,
          crossAxisCount: columnCount,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          itemCount: _images.length,
          itemBuilder: (context, index) {
            return Container(
              decoration:
                  BoxDecoration(color: themeProvider.themeData().primaryColor),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    child: Image.file(
                      File(Uri.decodeFull(_images[index].uri)),
                      alignment: Alignment.topLeft,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(_images[index].mediaTags != ""
                        ? _images[index].mediaTags == "NULL"
                            ? "No tags found"
                            : _images[index]
                                .mediaTags
                                .split(",")
                                .fold<String>(
                                    "",
                                    (previousValue, element) => previousValue +=
                                        (element.trim().isNotEmpty
                                            ? element + "\n"
                                            : ""))
                                .trim()
                        : "Not tagged"),
                  ),
                ],
              ),
            );
          },
        ));

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
    var viewSpace =
        ((MediaQuery.of(context).size.width - 250 - 40) / 200).floor();
    columnCount = viewSpace < 1 ? 1 : viewSpace;
    themeProvider = Provider.of<ThemeProvider>(context);
    if (currentProfile != null) {
      var result = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _topBar(),
          const SizedBox(height: 10),
          if (_selectedMediaType == FileType.image) _searchbar(),
          const SizedBox(height: 15),
          _imageList(),
        ],
      );
      // _timer.stop();
      // _logger.logger.shout(
      //     "Re-render of gallery with serach tag: ${_textSearchController.text} took ${_timer.elapsed.inMicroseconds} microseconds");
      return result;
    } else {
      return const Text("No data");
    }
  }

  Widget _searchbar() {
    return SizedBox(
      height: 40,
      child: TextFormField(
          style: const TextStyle(fontSize: 12),
          cursorWidth: 1,
          keyboardType: TextInputType.number,
          controller: _textSearchController,
          onChanged: (change) {
            // _timer.reset();
            // _timer.start();
            setState(() {
              _searchImagesInit(change);
            });
          },
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(left: 15),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: (const Color(0xFF272837)),
            hintText: "search your images like dog, cat ...",
            hintStyle: const TextStyle(letterSpacing: 0.3),
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
