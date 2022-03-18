import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';
import 'package:waultar/core/abstracts/abstract_services/i_timeline_service.dart';
import 'package:waultar/core/models/content/post_model.dart';
import 'package:waultar/core/models/timeline/time_models.dart';
import 'package:waultar/core/models/ui_model.dart';
import 'package:waultar/core/parsers/parse_helper.dart';
import 'package:waultar/presentation/providers/theme_provider.dart';
import 'package:waultar/presentation/widgets/general/default_widgets/default_widget_box.dart';
import 'package:waultar/presentation/widgets/timeline/datapoint_widget.dart';
import 'package:waultar/presentation/widgets/timeline/filter_widget.dart';
import 'package:waultar/presentation/widgets/timeline/timeline_widget.dart';
import 'package:waultar/startup.dart';

class Timeline extends StatefulWidget {
  const Timeline({Key? key}) : super(key: key);

  @override
  State<Timeline> createState() => _TimelineState();
}

class _TimelineState extends State<Timeline> {
  late ThemeProvider themeProvider;

  var _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random _rnd = Random();

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  @override
  Widget build(BuildContext context) {
    themeProvider = Provider.of<ThemeProvider>(context);

    ITimelineService timelineService =
        locator.get<ITimelineService>(instanceName: 'timeService');

    //List<TimeModel> blocks = timelineService.getAllYears();

    List<TimeModel> blocks = List.generate(
        4,
        (index) => YearModel(index, 2000 + index,
                ((index + 1) * 1405) + ((index + 1) * 3342), [
              Tuple3((index + 1) * 2405, "Post:$index", Color(0xFF19A8F5)),
              Tuple3((index + 1) * 1442, "Image:$index", Color(0xFFF06D85))
            ]));
    blocks.addAll(List.generate(
        6,
        (index) => YearModel(index, 2000 + index,
                ((index + 1) * 1405) + ((index + 1) * 3342), [
              Tuple3((index + 1) * 2405, "Post:$index", Color(0xFF19A8F5)),
              Tuple3((index + 1) * 1442, "Image:$index", Color(0xFFF06D85))
            ])).reversed);
    blocks.addAll(List.generate(
        2,
        (index) => YearModel(index, 2000 + index,
                ((index + 1) * 1405) + ((index + 1) * 3342), [
              Tuple3((index + 1) * 2405, "Post:$index", Color(0xFF19A8F5)),
              Tuple3((index + 1) * 1442, "Image:$index", Color(0xFFF06D85))
            ])));

    List<UIModel> dpList = List.generate(
      10,
      (index) => PostModel(
          title: getRandomString(100),
          profile: ParseHelper.profile,
          raw: "",
          timestamp: DateTime.now()),
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Timeline",
          style: themeProvider.themeData().textTheme.headline3,
        ),
        SizedBox(height: 20),
        Expanded(
          flex: 3,
          child: Row(
            children: [
              Expanded(
                  flex: 4,
                  child:
                      DefaultWidgetBox(child: TimelineWidget(blocks: blocks))),
              SizedBox(width: 20),
              Expanded(flex: 2, child: FilterWidget(blocks: blocks))
            ],
          ),
        ),
        SizedBox(height: 20),
        Expanded(flex: 2, child: DataPointWidget(dpList: dpList))
      ],
    );
  }
}
