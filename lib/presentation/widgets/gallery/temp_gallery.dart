import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:tuple/tuple.dart';
import 'package:waultar/core/inodes/media_documents.dart';
import 'package:waultar/core/inodes/media_repo.dart';
import 'package:waultar/presentation/providers/theme_provider.dart';
import 'package:waultar/presentation/widgets/general/default_widgets/default_widget.dart';

import 'package:waultar/startup.dart';

class TempGallery extends StatefulWidget {
  const TempGallery({Key? key}) : super(key: key);

  @override
  _TempGalleryState createState() => _TempGalleryState();
}

class _TempGalleryState extends State<TempGallery> {
  late AppLocalizations localizer;
  late ThemeProvider themeProvider;
  List<ImageDocument> medias = [];
  final _mediaRepo = locator.get<MediaRepository>(instanceName: 'mediaRepo');
  final _mediaListScrollController = ScrollController();

  Widget _selectionBoxes() {
    return const Expanded(
      flex: 1,
      child: Text("Buttons"),
    );
  }

  _mediaList() {
    return Expanded(
      flex: 20,
      child: ListView.builder(
        controller: _mediaListScrollController,
        itemCount: medias.length,
        itemBuilder: (_, index) => Padding(
          padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
          child: DefaultWidget(
            title: "Image",
            child: Column(
              children: [
                Image.file(
                  File(Uri.decodeFull(medias[index].uri)),
                  height: 500,
                ),
                Text(medias[index].mediaTags != null
                    ? medias[index].mediaTags!.map((e) {
                      var temp = e.split(",");
                      return Tuple2(temp[0], temp[1]);
                      })
                    .fold<String>(
                        "",
                        (previousValue, element) =>
                            previousValue = previousValue + "${element.item1}, score: ${element.item2}\n")
                    : "No tags found")
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    medias = _mediaRepo.getAllImages();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _selectionBoxes(),
        _mediaList(),
      ],
    );
  }
}
