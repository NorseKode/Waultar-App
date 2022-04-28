import 'package:flutter/material.dart';
import 'package:waultar/configs/navigation/screen.dart';
import 'package:waultar/presentation/screens/shared/waultar_desktop_main.dart';
import 'package:waultar/presentation/widgets/gallery/gallery.dart';
import 'package:waultar/presentation/widgets/general/menu_panel.dart';
import 'package:waultar/presentation/widgets/general/top_panel.dart';

class GalleryView extends StatefulWidget {
  const GalleryView({Key? key}) : super(key: key);

  @override
  _GalleryViewState createState() => _GalleryViewState();
}

class _GalleryViewState extends State<GalleryView> {
  final _activeScreen = ViewScreen.gallery;
  _callback() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return getWaultarDesktopMainBody(
      context,
      MenuPanel(
        active: _activeScreen,
        callback: () {
          _callback();
        },
      ),
      const TopPanel(),
      const Gallery(),
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
    );
  }
}
