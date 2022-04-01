import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waultar/core/abstracts/abstract_services/i_sentiment_service.dart';
import 'package:waultar/data/entities/misc/profile_document.dart';
import 'package:waultar/data/entities/nodes/category_node.dart';
import 'package:waultar/presentation/providers/theme_provider.dart';
import 'package:waultar/presentation/widgets/general/default_widgets/default_widget.dart';
import 'package:waultar/presentation/widgets/general/util_widgets/default_button.dart';
import 'package:waultar/startup.dart';

class SentimentWidget extends StatefulWidget {
  const SentimentWidget({Key? key}) : super(key: key);

  @override
  State<SentimentWidget> createState() => _SentimentWidgetState();
}

class _SentimentWidgetState extends State<SentimentWidget> {
  final sentimentService =
      locator.get<ISentimentService>(instanceName: 'sentimentService');
  late ThemeProvider themeProvider;
  late List<ProfileDocument> profiles;

  List<DataCategory> chosenCategories = [];
  int connotated = 0;
  int timeEstimateSeconds = 0;
  bool analyzing = false;

  @override
  Widget build(BuildContext context) {
    profiles = sentimentService.getAllProfiles();
    themeProvider = Provider.of<ThemeProvider>(context);

    return DefaultWidget(
        constraints: const BoxConstraints(maxWidth: 300),
        title: "Sentiment Analysis",
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Analyze the invoked sentiment in your data.",
            ),
            //const SizedBox(height: 10),
            const Text(
              "Choose what data to run analysis on :",
            ),
            const SizedBox(height: 10),
            SingleChildScrollView(child: Column(children: _profileList())),
            const SizedBox(height: 10),
            const Divider(
                height: 2,
                thickness: 2,
                color: Color.fromARGB(255, 61, 67, 113)),

            const SizedBox(height: 10),
            _analyzeBar(),

            connotated != 0 ? Text("done: $connotated") : Container(),
          ],
        ));
  }

  Widget _analyzeBar() {
    var timeEstimate = _timeEstimateOnCat();
    return Container(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text("Time estimate",
                style: TextStyle(fontSize: 9, fontWeight: FontWeight.w400)),
            Text("$timeEstimate", style: TextStyle(fontSize: 12))
          ],
        ),
        SizedBox(width: 10),
        DefaultButton(
            text: "          Analyze          ",
            onPressed: profiles.isEmpty
                ? null
                : () {
                    connotated = sentimentService
                        .connotateTextsFromCategory(chosenCategories);
                    setState(() => {});
                  })
      ],
    ));
  }

  String formatTime(int seconds) {
    return '${(Duration(seconds: seconds))}'.substring(2, 7);
  }

  String _timeEstimateOnCat() {
    int timeEstimate = 0;
    chosenCategories.forEach((element) {
      timeEstimate += (element.count * 0.0005).ceil();
    });
    return formatTime(timeEstimate);
  }

  List<Widget> _profileList() {
    return profiles.isEmpty
        ? [
            Text("No data to analyze",
                style: themeProvider.themeData().textTheme.headline4)
          ]
        : List.generate(
            profiles.length,
            (index) => Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        profiles[index].service.target!.serviceName,
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      SizedBox(height: 5),
                      _categoryList(profiles[index]),
                    ],
                  ),
                ));
  }

  Widget _categoryList(ProfileDocument profile) {
    return Container(
      constraints: BoxConstraints(maxHeight: 150),
      child: SingleChildScrollView(
        child: Column(
            children: List.generate(
                profile.categories.length,
                (index) => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Checkbox(
                                activeColor: const Color(0xFF5D97FF),
                                value: chosenCategories
                                    .where((element) =>
                                        element.id ==
                                        profile.categories[index].id)
                                    .toList()
                                    .isNotEmpty,
                                onChanged: (value) {
                                  !value!
                                      ? chosenCategories.remove(chosenCategories
                                          .firstWhere((element) =>
                                              element.id ==
                                              profile.categories[index].id))
                                      : chosenCategories
                                          .add(profile.categories[index]);
                                  setState(
                                    () {},
                                  );
                                }),
                            Text(profile.categories[index].category.name,
                                style: TextStyle(fontSize: 12)),
                          ],
                        ),
                        Text(profile.categories[index].count.toString())
                      ],
                    ))),
      ),
    );
  }
}
