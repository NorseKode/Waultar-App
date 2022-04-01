import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:waultar/configs/globals/category_enums.dart';
import 'package:waultar/core/abstracts/abstract_services/i_timeline_service.dart';
import 'package:waultar/core/models/timeline/time_models.dart';
import 'package:waultar/presentation/providers/theme_provider.dart';
import 'package:waultar/startup.dart';

class Timeline extends StatefulWidget {
  const Timeline({Key? key}) : super(key: key);

  @override
  State<Timeline> createState() => _TimelineState();
}

class _TimelineState extends State<Timeline> {

  late ThemeProvider themeProvider;

  final ITimelineService _timelineService = locator.get<ITimelineService>(
    instanceName: 'timeService',
  );
  late List<TimeModel> _timeSeries;
  late TooltipBehavior _tooltipBehavior;
  late ChartSeriesType _chosenChartType;
  late TimeIntervalType _chosenTimeInterval;

  @override
  void initState() {
    _timeSeries = _timelineService.getAllYears();
    _tooltipBehavior = TooltipBehavior(enable: true);
    _chosenChartType = ChartSeriesType.stackedColumns;
    _chosenTimeInterval = TimeIntervalType.years;
    super.initState();
  }

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
        const SizedBox(height: 30),
        Row(
          children: [
            _chartTypeSelector(),
            const SizedBox(width: 20),
            _timeIntervalSelector(),
          ],
        ),
        // _chartTypeSelector(),
        const SizedBox(height: 30),
        Expanded(
          child: _timeSeries.isEmpty
              ? const Center(
                  child: Text('No datapoints found'),
                )
              : _chart(),
        ),
      ],
    );
  }

  Widget _chartTypeSelector() {
    return DropdownButton(
      value: _chosenChartType,
      items: List.generate(
        ChartSeriesType.values.length,
        (index) => DropdownMenuItem(
          child: Text(ChartSeriesType.values[index].chartName),
          value: ChartSeriesType.values[index],
        ),
      ),
      onChanged: (ChartSeriesType? chartType) {
        setState(() {
          _chosenChartType = chartType ?? ChartSeriesType.stackedColumns;
        });
      },
    );
  }

  Widget _timeIntervalSelector() {
    return DropdownButton(
      value: _chosenTimeInterval,
      items: List.generate(
        TimeIntervalType.values.length,
        (index) => DropdownMenuItem(
          child: Text(TimeIntervalType.values[index].timeIntervalName),
          value: TimeIntervalType.values[index],
        ),
      ),
      onChanged: (TimeIntervalType? timeInterval) {
        setState(() {
          _chosenTimeInterval = timeInterval ?? TimeIntervalType.years;

          switch (_chosenTimeInterval.intervalType) {
            case YearModel:
              _timeSeries = _timelineService.getAllYears();
              break;
            case MonthModel:
              _timeSeries = _timelineService.getAllMonths();
              break;
            case DayModel:
              _timeSeries = _timelineService.getAllDays();
              break;

            default:
              _timeSeries = _timelineService.getAllYears();
          }
        });
      },
    );
  }

  _chart() {
    return SfCartesianChart(
      tooltipBehavior: _tooltipBehavior,
      legend: Legend(isVisible: true),
      primaryXAxis: DateTimeCategoryAxis(
        // edgeLabelPlacement: EdgeLabelPlacement.shift,
        placeLabelsNearAxisLine: true,
        title: AxisTitle(
          text: 'Time',
        ),
        autoScrollingDeltaType: DateTimeIntervalType.auto,
        // autoScrollingDelta: 3,
        autoScrollingMode: AutoScrollingMode.start,
        labelIntersectAction: AxisLabelIntersectAction.rotate45,
        intervalType: _getCurrentXIntervalEnum(),
        minimum: _timeSeries.first.dateTime,
        maximum: _timeSeries.last.dateTime,
      ),
      zoomPanBehavior: ZoomPanBehavior(
        enablePanning: true,
        enableMouseWheelZooming: _chosenChartType.canZoom,
        zoomMode: ZoomMode.x,
      ),
      primaryYAxis: NumericAxis(
        title: AxisTitle(
          text: 'Amount of Datapoints',
        ),
      ),
      series: _getChartSeries(),
      trackballBehavior: TrackballBehavior(
        enable: true,
        activationMode: ActivationMode.longPress,
        tooltipDisplayMode: TrackballDisplayMode.groupAllPoints,
        lineColor: Colors.transparent,
        // we can use the builder to hide values where total == 0
      ),
    );
  }

  DateTimeIntervalType _getCurrentXIntervalEnum() {
    switch (_chosenTimeInterval.intervalType) {
      case YearModel:
        return DateTimeIntervalType.years;

      case MonthModel:
        return DateTimeIntervalType.months;

      case DayModel:
        return DateTimeIntervalType.days;

      case HourModel:
        return DateTimeIntervalType.hours;

      default:
        return DateTimeIntervalType.auto;
    }
  }

  List<ChartSeries> _getChartSeries() {
    var returnList = <ChartSeries>[];
    var categoryMap = _generateCategoryChartObjects();

    switch (_chosenChartType.chartType) {
      case StackedColumnSeries:
        for (var entry in categoryMap.entries) {
          var outPut = StackedColumnSeries(
            dataSource: entry.value,
            xValueMapper: (TimeUnitWithTotal model, _) => model.timeValue,
            yValueMapper: (TimeUnitWithTotal model, _) => model.total,
            dataLabelMapper: (TimeUnitWithTotal model, _) =>
                entry.key.categoryName,
            legendIconType: LegendIconType.rectangle,
            name: entry.key.categoryName,
          );

          returnList.add(outPut);
        }
        returnList.addAll(_getProfilesLineSeries());
        break;

      case StackedColumn100Series:
        for (var entry in categoryMap.entries) {
          var outPut = StackedColumn100Series(
            dataSource: entry.value,
            xValueMapper: (TimeUnitWithTotal model, _) => model.timeValue,
            yValueMapper: (TimeUnitWithTotal model, _) => model.total,
            dataLabelMapper: (TimeUnitWithTotal model, _) =>
                entry.key.categoryName,
            legendIconType: LegendIconType.rectangle,
            name: entry.key.categoryName,
          );

          returnList.add(outPut);
        }
        break;

      case StackedBarSeries:
        for (var entry in categoryMap.entries) {
          var outPut = StackedBarSeries(
            dataSource: entry.value,
            xValueMapper: (TimeUnitWithTotal model, _) => model.timeValue,
            yValueMapper: (TimeUnitWithTotal model, _) => model.total,
            dataLabelMapper: (TimeUnitWithTotal model, _) =>
                entry.key.categoryName,
            legendIconType: LegendIconType.rectangle,
            name: entry.key.categoryName,
          );

          returnList.add(outPut);
        }
        break;

      case StackedBar100Series:
        for (var entry in categoryMap.entries) {
          var outPut = StackedBar100Series(
            dataSource: entry.value,
            xValueMapper: (TimeUnitWithTotal model, _) => model.timeValue,
            yValueMapper: (TimeUnitWithTotal model, _) => model.total,
            dataLabelMapper: (TimeUnitWithTotal model, _) =>
                entry.key.categoryName,
            legendIconType: LegendIconType.rectangle,
            name: entry.key.categoryName,
          );

          returnList.add(outPut);
        }
        break;

      case LineSeries:
        for (var entry in categoryMap.entries) {
          var outPut = LineSeries(
            dataSource: entry.value,
            xValueMapper: (TimeUnitWithTotal model, _) => model.timeValue,
            yValueMapper: (TimeUnitWithTotal model, _) => model.total,
            dataLabelMapper: (TimeUnitWithTotal model, _) =>
                entry.key.categoryName,
            legendIconType: LegendIconType.rectangle,
            name: entry.key.categoryName,
          );

          returnList.add(outPut);
        }
        returnList.addAll(_getProfilesLineSeries());
        break;

      case ColumnSeries:
        for (var entry in categoryMap.entries) {
          var outPut = ColumnSeries(
            dataSource: entry.value,
            xValueMapper: (TimeUnitWithTotal model, _) => model.timeValue,
            yValueMapper: (TimeUnitWithTotal model, _) => model.total,
            dataLabelMapper: (TimeUnitWithTotal model, _) =>
                entry.key.categoryName,
            legendIconType: LegendIconType.rectangle,
            name: entry.key.categoryName,
          );

          returnList.add(outPut);
        }
        returnList.addAll(_getProfilesLineSeries());
        break;
    }

    return returnList;
  }

  List<LineSeries> _getProfilesLineSeries() {
    var returnList = <LineSeries>[];
    var profileMap = _generateProfileChartObjects();
    for (var entry in profileMap.entries) {
      var outPut = LineSeries(
        dataSource: entry.value,
        xValueMapper: (TimeUnitWithTotal model, _) => model.timeValue,
        yValueMapper: (TimeUnitWithTotal model, _) => model.total,
        name: '${entry.key} total',
        legendIconType: LegendIconType.horizontalLine,
      );
      returnList.add(outPut);
    }
    return returnList;
  }

  Map<String, List<TimeUnitWithTotal>> _generateProfileChartObjects() {
    var map = <String, List<TimeUnitWithTotal>>{};
    for (var timeModel in _timeSeries) {
      for (var profileTuple in timeModel.profileCount) {
        map.update(
          profileTuple.item1.name,
          (value) {
            value.add(
              TimeUnitWithTotal(
                timeValue: timeModel.dateTime,
                total: profileTuple.item2,
              ),
            );
            return value;
          },
          ifAbsent: () => <TimeUnitWithTotal>[
            TimeUnitWithTotal(
              timeValue: timeModel.dateTime,
              total: profileTuple.item2,
            )
          ],
        );
      }
    }
    return map;
  }

  Map<CategoryEnum, List<TimeUnitWithTotal>> _generateCategoryChartObjects() {
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
              timeValue: timeModel.dateTime,
              total: tuple.item2,
            ));
            return value;
          });
          // otherwise, we add the timevalue from the timeModel with total = 0
        } else {
          map.update(key, (value) {
            value.add(TimeUnitWithTotal(
              timeValue: timeModel.dateTime,
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
  DateTime timeValue;
  int total;
  TimeUnitWithTotal({
    required this.timeValue,
    required this.total,
  });

  @override
  String toString() {
    return 'timeValue -> ${timeValue.toString()} total -> $total';
  }
}

enum ChartSeriesType {
  stackedColumns,
  stackedColumns100,
  stackedBar,
  stackedBar100,
  lines,
  columns,
}

extension ChartSeriesTypeHelper on ChartSeriesType {
  static const namesMap = {
    ChartSeriesType.stackedColumns: 'Stacked Columns',
    ChartSeriesType.stackedColumns100: 'Stacked Columns Percentage',
    ChartSeriesType.stackedBar: 'Stacked Bars',
    ChartSeriesType.stackedBar100: 'Stacked Bars Percentage',
    ChartSeriesType.lines: 'Lines',
    ChartSeriesType.columns: 'Columns',
  };

  static const chartTypeMap = {
    ChartSeriesType.stackedColumns: StackedColumnSeries,
    ChartSeriesType.stackedColumns100: StackedColumn100Series,
    ChartSeriesType.stackedBar: StackedBarSeries,
    ChartSeriesType.stackedBar100: StackedBar100Series,
    ChartSeriesType.lines: LineSeries,
    ChartSeriesType.columns: ColumnSeries,
  };

  static const canZoomMap = {
    ChartSeriesType.stackedColumns: true,
    ChartSeriesType.stackedColumns100: false,
    ChartSeriesType.stackedBar: true,
    ChartSeriesType.stackedBar100: false,
    ChartSeriesType.lines: true,
    ChartSeriesType.columns: true,
  };

  String get chartName => namesMap[this] ?? 'Unknown';
  Type get chartType => chartTypeMap[this] ?? StackedColumnSeries;
  bool get canZoom => canZoomMap[this] ?? false;
}

enum TimeIntervalType {
  years,
  months,
  days,
}

extension TimeIntervalTypeHelper on TimeIntervalType {
  static const namesMap = {
    TimeIntervalType.years: 'Years',
    TimeIntervalType.months: 'Months',
    TimeIntervalType.days: 'Days',
  };

  static const intervalMap = {
    TimeIntervalType.years: YearModel,
    TimeIntervalType.months: MonthModel,
    TimeIntervalType.days: DayModel,
  };

  String get timeIntervalName => namesMap[this] ?? 'Unknown';
  Type get intervalType => intervalMap[this] ?? YearModel;
}
