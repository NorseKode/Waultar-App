import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:waultar/providers/theme_provider.dart';
import 'package:waultar/widgets/general/menu_item.dart';

class TopPanel extends StatefulWidget {
  const TopPanel({Key? key}) : super(key: key);

  @override
  _TopPanelState createState() => _TopPanelState();
}

class _TopPanelState extends State<TopPanel> {
  late ThemeProvider themeProvider;

  Widget welcome() {
    return Container(
      height: 45,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Text('Hi ', style: themeProvider.themeData().textTheme.headline1),
              Text('John Doe',
                  style: themeProvider.themeData().textTheme.headline2),
              Text(', welcome back!',
                  style: themeProvider.themeData().textTheme.headline2),
            ],
          ),
          Text(
            "@johndillermand",
            style: themeProvider.themeData().textTheme.bodyText1,
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    themeProvider = Provider.of<ThemeProvider>(context);

    return Container(
        height: 90,
        width: MediaQuery.of(context).size.width - 202,
        color: themeProvider.themeData().primaryColor,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(35, 13.0, 20, 13.0),
          child: Row(
            children: [
              welcome(),
            ],
          ),
        ));
  }
}
