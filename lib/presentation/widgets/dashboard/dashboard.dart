import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:waultar/core/abstracts/abstract_repositories/i_service_repository.dart';
import 'package:waultar/core/models/index.dart';
import 'package:waultar/core/parsers/parse_helper.dart';
import 'package:waultar/presentation/providers/theme_provider.dart';
import 'package:waultar/presentation/widgets/dashboard/default_widget.dart';
import 'package:waultar/presentation/widgets/dashboard/widgets.dart/service_widget.dart';
import 'package:waultar/presentation/widgets/dashboard/widgets.dart/post_widget.dart';
import 'package:waultar/startup.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late AppLocalizations localizer;
  late ThemeProvider themeProvider;
  List<File> uploadedFiles = [];
  final IServiceRepository _serviceRepo =
      locator.get<IServiceRepository>(instanceName: 'serviceRepo');

  @override
  Widget build(BuildContext context) {
    final services = _serviceRepo.getAll();
    localizer = AppLocalizations.of(context)!;
    themeProvider = Provider.of<ThemeProvider>(context);

    List<Widget> serviceWidgets = List.generate(
        services.length, (e) => ServiceWidget(service: services[e]));

    List<PollModel> polls = List.generate(
        10,
        (index) => PollModel(
            profile: ParseHelper.profile,
            raw: "",
            options: "Shit works + $index"));

    List<Widget> dashboardWidgets = List.generate(
        polls.length,
        (index) => DefaultWidget(
            title: "Poll $index", child: Text(polls[index].toString())));

    List<Widget> dashboardWidgets2 = List.generate(
        polls.length,
        (index) => DefaultWidget(
            title: "Poll $index",
            child: Container(
                width: 300,
                height: 300,
                color: Colors.red,
                child: Text(polls[index].toString()))));

    List<Widget> postWidgets = List.generate(
        polls.length,
        (index) => PostWidget(
                post: PostModel(
                    tags: [
                  TagModel(0, "Dinner Time!"),
                  TagModel(0, "Lukin Off Arse"),
                ],
                    medias: [
                  ImageModel(
                      profile: ParseHelper.profile,
                      raw: "",
                      uri: Uri(path: "lib/assets/graphics/Logo.png")),
                  ImageModel(
                      profile: ParseHelper.profile,
                      raw: "",
                      uri: Uri(path: "lib/assets/graphics/data_graphic.png"))
                ],
                    mentions: [
                  PersonModel(
                      profile: ParseHelper.profile, name: "LukASS", raw: ""),
                  PersonModel(
                      profile: ParseHelper.profile, name: "LukasOff", raw: "")
                ],
                    isArchived: true,
                    title:
                        "Malou Landsgaard posted this on Lukas Offenbergs timeline",
                    description:
                        "Hi guys! I just wanna say that I had a great time today! See you next time",
                    profile: ParseHelper.profile,
                    raw: '',
                    timestamp: DateTime.now())));

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
                Text(localizer.yourSocialDataOverview),
                const SizedBox(height: 20),
                SizedBox(
                    width: MediaQuery.of(context).size.width - 290,
                    child: Wrap(
                        spacing: 20,
                        runSpacing: 20,
                        children: dashboardWidgets)),
                const SizedBox(height: 20),
                SizedBox(
                    width: MediaQuery.of(context).size.width - 290,
                    child: Wrap(
                        spacing: 20,
                        runSpacing: 20,
                        children: dashboardWidgets2)),
                const SizedBox(height: 20),
                SizedBox(
                    width: MediaQuery.of(context).size.width - 290,
                    child: Wrap(
                        spacing: 20, runSpacing: 20, children: postWidgets))
              ])),
        )
      ],
    );
  }
}
