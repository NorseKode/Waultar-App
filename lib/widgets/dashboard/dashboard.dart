import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:waultar/providers/theme_provider.dart';
import 'package:waultar/widgets/upload/upload_files.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late ThemeProvider themeProvider;

  Widget addIcon(double size, Color color) {
    const assetName = 'lib/assets/icons/fi-rr-plus.svg';
    final Widget svg = SvgPicture.asset(assetName,
        semanticsLabel: 'plus', height: size, color: color);
    return svg;
  }

  _upload(BuildContext context, bool isFile) async {
    var file = isFile
        ? await FileUploader.uploadMultiple()
        : await FileUploader.uploadDirectory();
  }

  Widget addButton() {
    return PopupMenuButton(
      tooltip: '',
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(5.0),
        ),
      ),
      elevation: 4,
      offset: const Offset(0.0, 40.0),
      color: themeProvider.themeMode().highlightedPrimary,
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        PopupMenuItem<String>(
            onTap: () async => await _upload(context, true),
            padding: EdgeInsets.zero,
            value: 'New data',
            child: ListTile(
              dense: true,
              title: Row(children: [
                addIcon(15, Colors.grey),
                const SizedBox(
                  width: 20,
                ),
                Text(
                  "New data",
                  style: themeProvider.themeMode().bodyText3,
                )
              ]),
            )),
        PopupMenuItem<String>(
            padding: EdgeInsets.zero,
            value: 'New widget',
            child: ListTile(
              dense: true,
              title: Row(children: [
                addIcon(15, Colors.grey),
                const SizedBox(
                  width: 20,
                ),
                Text(
                  "New widget",
                  style: themeProvider.themeMode().bodyText3,
                )
              ]),
            ))
      ],
      child: Container(
          padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
          decoration: BoxDecoration(
              color: themeProvider.themeMode().themeColor,
              borderRadius: const BorderRadius.all(Radius.circular(5))),
          child: Row(children: [
            addIcon(10, Colors.white),
            const SizedBox(
              width: 10,
            ),
            Text(
              "Add",
              style: themeProvider.themeData().textTheme.bodyText2,
            )
          ])),
    );
  }

  @override
  Widget build(BuildContext context) {
    themeProvider = Provider.of<ThemeProvider>(context);

    return Padding(
      padding: const EdgeInsets.fromLTRB(35, 22.5, 35, 0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Dashboard",
                style: themeProvider.themeData().textTheme.headline3,
              ),
              addButton()
            ],
          ),
          const SizedBox(height: 22.5),
          Expanded(
            child: SingleChildScrollView(
                child: Column(
              children: [
                Container(
                    width: double.infinity,
                    height: 1000,
                    decoration: BoxDecoration(
                        color: themeProvider.themeMode().widgetBackground,
                        borderRadius: BorderRadius.circular(5))),
              ],
            )),
          )
        ],
      ),
    );
  }
}
