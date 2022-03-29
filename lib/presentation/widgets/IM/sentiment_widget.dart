import 'package:flutter/material.dart';
import 'package:waultar/core/abstracts/abstract_services/i_sentiment_service.dart';
import 'package:waultar/data/entities/misc/profile_document.dart';
import 'package:waultar/data/entities/nodes/category_node.dart';
import 'package:waultar/presentation/widgets/general/default_widgets/default_widget.dart';
import 'package:waultar/presentation/widgets/general/util_widgets/default_button.dart';
import 'package:waultar/startup.dart';

class SentimentWidget extends StatefulWidget {
  const SentimentWidget({Key? key}) : super(key: key);

  @override
  State<SentimentWidget> createState() => _SentimentWidgetState();
}

class _SentimentWidgetState extends State<SentimentWidget> {
  List<DataCategory> chosenCategories = [];
  int connotated = 0;
  int timeEstimateSeconds = 0;

  @override
  Widget build(BuildContext context) {
    final sentimentService =
        locator.get<ISentimentService>(instanceName: 'sentimentService');
    List<ProfileDocument> profiles = sentimentService.getAllProfiles();
    String timeEstimate = _timeEstimateOnCat();

    return DefaultWidget(
        constraints: BoxConstraints(maxWidth: 350),
        title: "Sentiment Analysis",
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Analyse the connotation of the content of you data.",
              style: TextStyle(fontSize: 12),
            ),
            const SizedBox(height: 10),
            const Text("Choose what data to run analysis on: ",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            SingleChildScrollView(
                child: Column(children: _profileList(profiles))),
            Container(
                color: Color(0xFF202442),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text("Time estimate", style: TextStyle(fontSize: 9)),
                          Text("$timeEstimate", style: TextStyle(fontSize: 12))
                        ],
                      ),
                      SizedBox(width: 10),
                      DefaultButton(
                          text: "          Analyze          ",
                          onPressed: () {
                            connotated = sentimentService
                                .connotateTextsFromCategory(chosenCategories);
                            setState(() => {});
                          })
                    ],
                  ),
                )),
          ],
        ));
  }

  String formatTime(int seconds) {
    return '${(Duration(seconds: seconds))}'
        .substring(2, 7); //.padLeft(8, '0');
  }

  String _timeEstimateOnCat() {
    int timeEstimate = 0;
    chosenCategories.forEach((element) {
      timeEstimate += (element.count * 0.001).ceil();
    });
    return formatTime(timeEstimate);
  }

  List<Widget> _profileList(List<ProfileDocument> profiles) {
    return List.generate(
        profiles.length,
        (index) => Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(profiles[index].service.target!.serviceName),
                  SizedBox(height: 5),
                  _categoryList(profiles[index]),
                ],
              ),
            ));
  }

  Widget _categoryList(ProfileDocument profile) {
    return Container(
      constraints: BoxConstraints(maxHeight: 200),
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
