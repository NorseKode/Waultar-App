import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:tuple/tuple.dart';
import 'package:waultar/configs/globals/category_enums.dart';
import 'package:waultar/core/abstracts/abstract_services/i_timeline_service.dart';
import 'package:waultar/core/models/timeline/time_models.dart';
import 'package:waultar/core/models/ui_model.dart';
import 'package:waultar/core/parsers/parse_helper.dart';
import 'package:waultar/presentation/providers/theme_provider.dart';
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

  final _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  final Random _rnd = Random();
  final ITimelineService _timelineService = locator.get<ITimelineService>(
    instanceName: 'timeService',
  );
  late List<TimeModel> _timeSeries;
  late List<TimeModel> blocks;

  @override
  void initState() {
    _timeSeries = _timelineService.getAllYears();
    blocks = _timelineService.getAllYears();
    super.initState();
  }

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  @override
  Widget build(BuildContext context) {
    themeProvider = Provider.of<ThemeProvider>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Timeline",
          style: themeProvider.themeData().textTheme.headline3,
        ),
        const SizedBox(height: 20),
        Expanded(
          flex: 3,
          child: Row(
            children: [
              Expanded(flex: 4, child: _columnChart()),
              const SizedBox(width: 20),
              Expanded(flex: 2, child: FilterWidget(blocks: blocks))
            ],
          ),
        ),
        // const SizedBox(height: 20),
        // Expanded(flex: 2, child: DataPointWidget(dpList: []))
      ],
    );
  }

  _columnChart() {
    return SfCartesianChart(
      series: _getStackedTimeSeries(),
      primaryXAxis: CategoryAxis(),
    );
  }

  _getStackedTimeSeries() {
    var returnList = <StackedColumnSeries>[];
    // for (var item in _timeSeries[1].categoryCount) {
    //   print(item.item1.category.categoryName);
    // }
    for (var timeModel in _timeSeries) {
      var column = StackedColumnSeries(
        dataSource: timeModel.categoryCount,
        xValueMapper: (model, _) => timeModel.timeValue,
        yValueMapper: (model, index) => timeModel.categoryCount[index].item2,
        dataLabelMapper: (model, index) =>
            '${timeModel.categoryCount[index].item1.category.categoryName} \n${timeModel.categoryCount[index].item2}',
        dataLabelSettings: const DataLabelSettings(
          isVisible: true,
          color: Colors.white
        ),
      );

      returnList.add(column);
    }
    return returnList;
  }
}
