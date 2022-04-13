import 'dart:io';

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:waultar/core/abstracts/abstract_repositories/i_service_repository.dart';
import 'package:waultar/core/abstracts/abstract_services/i_dashboard_service.dart';
import 'package:waultar/data/entities/misc/profile_document.dart';
import 'package:waultar/domain/services/dashboard_service.dart';
import 'package:waultar/presentation/providers/theme_provider.dart';

import 'package:waultar/presentation/widgets/machine_models/sentiment_widget.dart';
import 'package:waultar/presentation/widgets/general/default_widgets/default_widget.dart';
import 'package:waultar/presentation/widgets/general/default_widgets/default_widget_box.dart';
import 'package:waultar/presentation/widgets/dashboard/service_widget.dart';

import 'package:waultar/presentation/widgets/machine_models/image_classify_widget.dart';

import 'package:waultar/startup.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final _dashboardService = locator.get<IDashboardService>(
    instanceName: 'dashboardService',
  );
  late AppLocalizations localizer;
  late ThemeProvider themeProvider;
  late List<ProfileDocument> profiles;

  @override
  Widget build(BuildContext context) {
    localizer = AppLocalizations.of(context)!;
    themeProvider = Provider.of<ThemeProvider>(context);
    profiles = _dashboardService.getAllProfiles();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          localizer.dashboard,
          style: themeProvider.themeData().textTheme.headline3,
        ),
        const SizedBox(height: 20),
        Expanded(
          child: profiles.isNotEmpty
              ? SingleChildScrollView(child: _dashboardWidgets())
              : Text(
                  "Upload data to use dashboard",
                  style: themeProvider.themeData().textTheme.headline4,
                ),
        )
      ],
    );
  }

  Widget _dashboardWidgets() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _services(),
              const SizedBox(height: 20),
              Text(
                "Highlights",
                style: themeProvider.themeData().textTheme.headline4,
              ),
              const SizedBox(height: 15),
              _highlightBar(),
              const SizedBox(height: 20),
              IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(child: _topMessageWidget()),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        children: [
                          _diagram1(),
                          const SizedBox(height: 20),
                          _diagram2()
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: _analysis(),
        ),
      ],
    );
  }

  Widget _services() {
    List<Widget> serviceWidgets = List.generate(
        profiles.length, (e) => ServiceWidget(service: profiles[e]));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          "Services",
          style: themeProvider.themeData().textTheme.headline4,
        ),
        const SizedBox(height: 15),
        Wrap(
          runSpacing: 20,
          spacing: 20,
          children: List.generate(
            serviceWidgets.length,
            (index) => serviceWidgets[index],
          ),
        ),
      ],
    );
  }

  Widget _analysis() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Data Analysis",
          style: themeProvider.themeData().textTheme.headline4,
        ),
        const SizedBox(height: 15),
        ImageClassifyWidget(),
        const SizedBox(height: 20),
        SentimentWidget(),
      ],
    );
  }

  Widget _highlightBar() {
    return Container(
      constraints: BoxConstraints(maxHeight: 70),
      child: Row(
        children: [
          _highlightWidget(
              Iconsax.activity5,
              themeProvider.themeMode().themeColor,
              "Most Active Year",
              "${"2020"}",
              Container())
        ],
      ),
    );
  }

  Widget _highlightWidget(
      IconData icon, Color color, String title, String result, Widget child) {
    return DefaultWidgetBox(
      padding: EdgeInsets.all(15),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
                color: color, //const Color(0xFF323346),
                borderRadius: BorderRadius.circular(5)),
            child: Icon(
              icon,
              color: color,
            ),
          ),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                    color: Color(0xFFABAAB8),
                    fontSize: 10,
                    fontWeight: FontWeight.w400),
              ),
              Text(
                result,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              )
            ],
          ),
          SizedBox(width: 10),
          child
        ],
      ),
    );
  }

  Widget _topMessageWidget() {
    return DefaultWidget(
        title: "Top Message Count",
        child: Expanded(
          child: Container(
            child: Column(
              children: List.generate(
                  10,
                  (index) => Container(
                        height: 40,
                        child: Row(
                          children: [Text("Person $index")],
                        ),
                      )),
            ),
          ),
        ));
  }

  Widget _diagram1() {
    return Expanded(
      child: DefaultWidget(
          title: "Data overview",
          child: Expanded(
            child: Container(),
          )),
    );
  }

  Widget _diagram2() {
    return Expanded(
      child: DefaultWidget(
          title: "Data overview",
          child: Expanded(
            child: Container(),
          )),
    );
  }
}
