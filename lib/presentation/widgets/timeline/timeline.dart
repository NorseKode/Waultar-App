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
import 'package:waultar/data/entities/nodes/category_node.dart';
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

  late TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    _timeSeries = _timelineService.getAllYears();
    blocks = _timelineService.getAllYears();
    _tooltipBehavior = TooltipBehavior(enable: true);
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
              // const SizedBox(width: 20),
              // Expanded(flex: 2, child: FilterWidget(blocks: blocks))
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
      tooltipBehavior: _tooltipBehavior,
      primaryXAxis: CategoryAxis(
        labelIntersectAction: AxisLabelIntersectAction.rotate45,
      ),
      series: _getStackedTimeSeries(),
    );
  }

  List<StackedColumnSeries> _getStackedTimeSeries() {
    var returnList = <StackedColumnSeries>[];

    var dtoList = <TimeDTO>[];

    for (var timeModel in _timeSeries) {
      print('${timeModel.timeValue} -> ${timeModel.total}');
      for (var tuple in timeModel.categoryCount) {
        final output = StackedColumnSeries(
          dataSource: [tuple],
          xValueMapper: (Tuple2 tuple, index) => timeModel.timeValue,
          yValueMapper: (Tuple2 tuple, index) => tuple.item2,
          dataLabelMapper: (Tuple2<DataCategory, int> tuple, index) =>
              tuple.item1.category.categoryName,
          dataLabelSettings: const DataLabelSettings(
            isVisible: true,
            showCumulativeValues: true,
          ),
          markerSettings: const MarkerSettings(
            isVisible: true,
          ),
          name: tuple.item1.category.categoryName,
        );

        returnList.add(output);
      }
    }

    return returnList;
  }
}

class TimeDTO {
  int total;
  int timeValue;
  DataCategory category;
  TimeDTO({
    required this.category,
    required this.total,
    required this.timeValue,
  });
}
