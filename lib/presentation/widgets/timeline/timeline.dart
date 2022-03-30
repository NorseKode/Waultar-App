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
      legend: Legend(isVisible: true),
      primaryXAxis: CategoryAxis(
        labelIntersectAction: AxisLabelIntersectAction.rotate45,
      ),
      series: _generateTimeSeriesForChart(),
    );
  }

  List<ChartSeries> _generateTimeSeriesForChart() {
    var map = _generateChartObjects();

    var returnList = <ChartSeries>[];
    for (var entry in map.entries) {
      var outPut = StackedColumnSeries(
        dataSource: entry.value,
        xValueMapper: (TimeUnitWithTotal model, _) => model.timeValue,
        yValueMapper: (TimeUnitWithTotal model, _) => model.total,
        dataLabelMapper: (TimeUnitWithTotal model, _) => entry.key.categoryName,
        legendIconType: LegendIconType.rectangle,
        name: entry.key.categoryName,
        dataLabelSettings: const DataLabelSettings(
          isVisible: false,
          showCumulativeValues: false,
        ),
      );

      returnList.add(outPut);
    }

    return returnList;
  }

  Map<CategoryEnum, List<TimeUnitWithTotal>> _generateChartObjects() {
    var map = <CategoryEnum, List<TimeUnitWithTotal>>{};

    // generate the initial map with empty values to make sure every enum is covered
    for (var catEnum in CategoryEnum.values) {
      map.addAll({catEnum: <TimeUnitWithTotal>[]});
    }

    // we iterate the timeModels to project the timeValue to the TimeUnitWithTotal
    for (var timeModel in _timeSeries) {

      // iterate the categoryEnum keys in the initial map to update the list of 
      // TimeUnitWithTotal with respect to the values of the _timeSeries (timeModels from db)
      for (var key in map.keys) {
        // if the categoryCount list in timeModel contains the enum, we update the value in 
        // the map with the total value stored in the tuple.item2 in the timeModel categoryCount
        if (timeModel.categoryCount
            .any((element) => element.item1.category.index == key.index)) {
          var tuple = timeModel.categoryCount.singleWhere(
              (element) => element.item1.category.index == key.index);
          map.update(key, (value) {
            value.add(TimeUnitWithTotal(
              timeValue: timeModel.timeValue,
              total: tuple.item2,
            ));
            return value;
          });
        // otherwise, we add the timevalue from the timeModel with total = 0
        } else {
          map.update(key, (value) {
            value.add(TimeUnitWithTotal(
              timeValue: timeModel.timeValue,
              total: 0,
            ));
            return value;
          });
        }
      }
    }

    // remove all the entries where all elements in list have total == 0
    map.removeWhere((key, value) {
      var listWith0Total = value.where((element) => element.total == 0);
      return listWith0Total.length == value.length;
    });

    return map;
  }


}

// Im afraid we will have to project the timeModels to this class
// otherwise, the stacked charts render faulty
class TimeUnitWithTotal {
  int timeValue;
  int total;
  TimeUnitWithTotal({
    required this.timeValue,
    required this.total,
  });

  @override
  String toString() {
    return 'timeValue -> $timeValue \ntotal -> $total';
  }
}
