import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:waultar/presentation/providers/theme_provider.dart';


class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late AppLocalizations localizer;
  late ThemeProvider themeProvider;
  List<File> uploadedFiles = [];

  @override
  Widget build(BuildContext context) {
    localizer = AppLocalizations.of(context)!;
    themeProvider = Provider.of<ThemeProvider>(context);

    // List<Widget> serviceWidgets = List.generate(
    //     services.length, (e) => ServiceWidget(service: services[e]));
    List<Widget> serviceWidgets = [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          localizer.dashboard,
          style: themeProvider.themeData().textTheme.headline3,
        ),
        const SizedBox(height: 20),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SingleChildScrollView(
                    //service widgets

                    scrollDirection: Axis.horizontal,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: List.generate(
                          serviceWidgets.length,
                          (index) => Padding(
                                padding: const EdgeInsets.only(right: 20),
                                child: serviceWidgets[index],
                              )),
                    )),
                const SizedBox(height: 20),
                Text(
                  localizer.yourSocialDataOverview,
                  style: themeProvider.themeData().textTheme.headline4,
                ), //dashboard widgets

                const SizedBox(height: 20),
              ],
            ),
          ),
        )
      ],
    );
  }
}
