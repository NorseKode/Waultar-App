import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:waultar/providers/theme_provider.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late ThemeProvider themeProvider;

  Widget AddIcon() {
    const assetName = 'lib/assets/icons/fi-rr-plus.svg';
    final Widget svg = SvgPicture.asset(assetName,
        semanticsLabel: 'Add new ', height: 15, color: Colors.white);
    return svg;
  }

  @override
  Widget build(BuildContext context) {
    themeProvider = Provider.of<ThemeProvider>(context);

    return Padding(
      padding: const EdgeInsets.fromLTRB(35, 22.5, 35, 0),
      child: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              color: themeProvider.themeData().primaryColor,
              width: MediaQuery.of(context).size.width - 82,
              height: 2000,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Dashboard",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                      Container(
                          child: ElevatedButton(
                              style: ButtonStyle(
                                  textStyle:
                                      MaterialStateProperty.all<TextStyle>(
                                          TextStyle(color: Colors.white)),
                                  backgroundColor: MaterialStateProperty.all<
                                          Color>(
                                      themeProvider.themeMode().themeColor)),
                              onPressed: () {},
                              child: Row(children: [
                                AddIcon(),
                                const SizedBox(
                                  width: 10,
                                ),
                                const Text(
                                  "Add new",
                                  style: TextStyle(color: Colors.white),
                                )
                              ])))
                    ],
                  )
                ],
              )),
        ],
      )),
    );
  }
}
