import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:waultar/core/abstracts/abstract_repositories/i_service_repository.dart';
import 'package:waultar/core/abstracts/abstract_services/i_dashboard_service.dart';
import 'package:waultar/data/entities/misc/profile_document.dart';
import 'package:waultar/domain/services/dashboard_service.dart';
import 'package:waultar/presentation/providers/theme_provider.dart';

import 'package:waultar/presentation/widgets/IM/sentiment_widget.dart';
import 'package:waultar/presentation/widgets/general/default_widgets/default_widget.dart';
import 'package:waultar/presentation/widgets/general/default_widgets/default_widget_box.dart';
import 'package:waultar/presentation/widgets/general/default_widgets/service_widget.dart';

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
              _highlightBar(),
              const SizedBox(height: 20),
              Text(
                "Highlights",
                style: themeProvider.themeData().textTheme.headline4,
              ),
              const SizedBox(height: 10),
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
        )
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
        const SizedBox(height: 10),
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
        const SizedBox(height: 10),
        ImageClassifyWidget(),
        const SizedBox(height: 20),
        SentimentWidget(),
      ],
    );
  }

  Widget _highlightBar() {
    return DefaultWidgetBox(
        child: Container(
      height: 50,
    ));
  }

  Widget _topMessageWidget() {
    return DefaultWidget(
        title: "Top Message Count",
        child: Expanded(
          child: Container(
            color: Colors.red,
            height: 400,
          ),
        ));
  }

  Widget _diagram1() {
    return Expanded(
      child: DefaultWidget(
          title: "Data overview",
          child: Expanded(
            child: Container(
              color: Colors.red,
            ),
          )),
    );
  }

  Widget _diagram2() {
    return Expanded(
      child: DefaultWidget(
          title: "Data overview",
          child: Expanded(
            child: Container(
              color: Colors.red,
            ),
          )),
    );
  }
}
