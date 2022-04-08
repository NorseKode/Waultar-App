import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:waultar/configs/globals/category_enums.dart';
import 'package:waultar/core/abstracts/abstract_services/i_timeline_service.dart';
import 'package:waultar/data/entities/misc/profile_document.dart';
import 'package:waultar/domain/services/timeline_service.dart';
import 'package:waultar/presentation/providers/theme_provider.dart';
import 'package:waultar/presentation/widgets/general/util_widgets/default_button.dart';
import 'package:waultar/startup.dart';

class Timeline extends StatefulWidget {
  const Timeline({Key? key}) : super(key: key);

  @override
  State<Timeline> createState() => _TimelineState();
}

class _TimelineState extends State<Timeline> {
  late ThemeProvider _themeProvider;

  final ITimelineService _timelineService = locator.get<ITimelineService>(
    instanceName: 'timeService',
  );

  late TooltipBehavior _tooltipBehavior;
  late ChartSeriesType _chosenChartType;
  late bool isLoadMoreView, isNeedToUpdateView, isDataUpdated;
  double? oldAxisVisibleMin, oldAxisVisibleMax;
  // ChartSeriesController? _seriesController;

  @override
  void initState() {
    initVariables();
    super.initState();
  }

  void initVariables() {
    _timelineService.init();
    _tooltipBehavior = TooltipBehavior(enable: true);
    _chosenChartType = ChartSeriesType.stackedColumns;
    isLoadMoreView = false;
    isNeedToUpdateView = false;
    isDataUpdated = true;
  }

  @override
  Widget build(BuildContext context) {
    _themeProvider = Provider.of<ThemeProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Timeline",
          style: _themeProvider.themeData().textTheme.headline3,
        ),
        const SizedBox(height: 30),
        _timelineService.allProfiles.isEmpty
            ? Container()
            : Row(
                children: [
                  _chartTypeSelector(),
                  const SizedBox(width: 20),
                  _profileSelector(),
                  const SizedBox(width: 20),
                  _resetButton(),
                ],
              ),
        const SizedBox(height: 30),
        _chartArea(),
      ],
    );
  }

  Widget _chartArea() {
    if (_timelineService.allProfiles.isEmpty ||
        _timelineService.mainChartCategorySeries.isEmpty) {
      return const Center(
        child: Text('No datapoints found'),
      );
    } else {
      return Expanded(
        child: Column(
          children: [
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: _timelineChart(),
                  ),
                  Expanded(
                    flex: 1,
                    child: _averageChart(),
                  )
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: _sentimentChart(),
                  ),
                  Expanded(
                    flex: 1,
                    child: SfCartesianChart(),
                  ),
                ],
              ),
            )
          ],
        ),
      );
    }
  }

  Widget _profileSelector() {
    return DropdownButton(
      value: _timelineService.currentProfile,
      items: List.generate(
        _timelineService.allProfiles.length,
        (index) => DropdownMenuItem(
          child: Text(
              '${_timelineService.allProfiles[index].name} - ${_timelineService.allProfiles[index].service.target!.serviceName}'),
          value: _timelineService.allProfiles[index],
        ),
      ),
      onChanged: (ProfileDocument? profile) {
        setState(() {
          _timelineService.updateProfile(profile!);
        });
      },
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

  Widget _resetButton() {
    return DefaultButton(
      onPressed: () {
        _timelineService.reset();
        setState(() {});
      },
      text: 'Reset',
    );
  }

  Widget _averageChart() {
    return SfCartesianChart(
      title: ChartTitle(
        text: 'Average pr weekday',
      ),
      series: _getAverageChartSeries(),
      tooltipBehavior: TooltipBehavior(
        enable: true,
      ),
      plotAreaBorderWidth: 0,
      primaryXAxis: CategoryAxis(
        majorGridLines: const MajorGridLines(width: 0),
        desiredIntervals: 7,
      ),
      primaryYAxis: NumericAxis(
        majorGridLines: const MajorGridLines(width: 0),
      ),
    );
  }

  List<ChartSeries> _getAverageChartSeries() {
    var returnList = <ChartSeries>[];
    var plotPoints = _timelineService.averageWeekDayChartSeries;
    for (var plotPoint in plotPoints) {
      var output = StackedBarSeries(
        dataSource: plotPoint.chartDataPoints,
        xValueMapper: (WeekDayWithAverage model, _) => model.weekDay,
        yValueMapper: (WeekDayWithAverage model, _) => model.average,
        dataLabelMapper: (x, _) => plotPoint.category.categoryName,
        name: plotPoint.category.categoryName,
      );
      returnList.add(output);
    }
    return returnList;
  }

  Widget _sentimentChart() {
    return SfCartesianChart(
      title: ChartTitle(
        text: '${_timelineService.currentProfile!.name} sentiment over time',
      ),
      plotAreaBorderWidth: 0,
      tooltipBehavior: TooltipBehavior(
        enable: true,
      ),
      primaryYAxis: NumericAxis(
        majorGridLines: const MajorGridLines(width: 0),
        // minimum: 0.0,
        // maximum: 1.0,
      ),
      primaryXAxis: DateTimeCategoryAxis(
        majorGridLines: const MajorGridLines(width: 0),
        labelIntersectAction: AxisLabelIntersectAction.rotate45,
        intervalType: _timelineService.currentXAxisInterval,
        interval: 1,
        minimum: _timelineService.minimum,
        maximum: _timelineService.maximum,
      ),
      series: _getSentimentChartSeries(),
    );
  }

  List<ChartSeries> _getSentimentChartSeries() {
    var returnList = <ChartSeries>[];
    var plotPoints = _timelineService.sentimentChartSeries;
    for (var plotPoint in plotPoints) {
      var output = ColumnSeries(
        dataSource: plotPoint.chartDataPoints,
        xValueMapper: (SentimentWithAverage model, _) => model.timeValue,
        yValueMapper: (SentimentWithAverage model, _) => model.score,
        dataLabelMapper: (x, _) => plotPoint.category.categoryName,
        name: plotPoint.category.categoryName,
      );
      returnList.add(output);
    }

    return returnList;
  }

  Widget _timelineChart() {
    return SfCartesianChart(
      key: GlobalKey<State>(),
      title: ChartTitle(
        text: '${_timelineService.currentProfile!.name} data over time',
      ),
      // onActualRangeChanged: _currentTimeInterval == TimeIntervalType.days
      //     ? (ActualRangeChangedArgs args) {
      //         if (args.orientation == AxisOrientation.horizontal) {
      //           if (isLoadMoreView) {
      //             args.visibleMin = oldAxisVisibleMin;
      //             args.visibleMax = oldAxisVisibleMax;
      //           }
      //           oldAxisVisibleMin = args.visibleMin as double;
      //           oldAxisVisibleMax = args.visibleMax as double;
      //         }
      //         isLoadMoreView = false;
      //       }
      //     : null,
      // loadMoreIndicatorBuilder: _currentTimeInterval == TimeIntervalType.days
      //     ? (BuildContext context, ChartSwipeDirection direction) =>
      //         getloadMoreIndicatorBuilder(context, direction)
      //     : null,
      tooltipBehavior: _tooltipBehavior,
      zoomPanBehavior: ZoomPanBehavior(
        enablePanning: true,
        zoomMode: ZoomMode.x,
        enableMouseWheelZooming: _chosenChartType.canZoom,
      ),
      legend: Legend(
        isVisible: true,
        position: LegendPosition.right,
      ),
      trackballBehavior: TrackballBehavior(
        enable: true,
        activationMode: ActivationMode.longPress,
        tooltipDisplayMode: TrackballDisplayMode.groupAllPoints,
        lineColor: Colors.transparent,
        // we can use the builder to hide values where total == 0
      ),
      primaryYAxis: NumericAxis(
        majorGridLines: const MajorGridLines(width: 0),
      ),
      onAxisLabelTapped: (AxisLabelTapArgs args) {
        var index = args.value;
        setState(() {
          _timelineService.updateMainChartSeries(index);
        });
      },
      plotAreaBorderWidth: 0,
      primaryXAxis: DateTimeCategoryAxis(
        majorGridLines: const MajorGridLines(width: 0),
        labelIntersectAction: AxisLabelIntersectAction.rotate45,
        intervalType: _timelineService.currentXAxisInterval,
        interval: 1,
        minimum: _timelineService.minimum,
        maximum: _timelineService.maximum,
      ),
      series: _getMainChartSeries(),
    );
  }

  List<ChartSeries> _getMainChartSeries() {
    var returnList = <ChartSeries>[];
    var chartObjects = _timelineService.mainChartCategorySeries;

    switch (_chosenChartType.chartType) {
      case StackedColumnSeries:
        for (var plotPoint in chartObjects) {
          var outPut = StackedColumnSeries(
            dataSource: plotPoint.chartDataPoints,
            xValueMapper: (TimeUnitWithTotal model, _) => model.timeValue,
            yValueMapper: (TimeUnitWithTotal model, _) => model.total,
            dataLabelMapper: (TimeUnitWithTotal model, _) =>
                plotPoint.category.categoryName,
            legendIconType: LegendIconType.rectangle,
            name: plotPoint.category.categoryName,
            // onRendererCreated: (ChartSeriesController controller) {
            //   _seriesController = controller;
            // },
          );

          returnList.add(outPut);
        }
        returnList.addAll(_getProfilesLineSeries());
        break;

      case StackedColumn100Series:
        for (var plotPoint in chartObjects) {
          var outPut = StackedColumn100Series(
            dataSource: plotPoint.chartDataPoints,
            xValueMapper: (TimeUnitWithTotal model, _) => model.timeValue,
            yValueMapper: (TimeUnitWithTotal model, _) => model.total,
            dataLabelMapper: (TimeUnitWithTotal model, _) =>
                plotPoint.category.categoryName,
            legendIconType: LegendIconType.rectangle,
            name: plotPoint.category.categoryName,
            // onRendererCreated: (ChartSeriesController controller) {
            //   _seriesController = controller;
            // },
          );
          returnList.add(outPut);
        }
        break;

      case StackedBarSeries:
        for (var plotPoint in chartObjects) {
          var outPut = StackedBarSeries(
            dataSource: plotPoint.chartDataPoints,
            xValueMapper: (TimeUnitWithTotal model, _) => model.timeValue,
            yValueMapper: (TimeUnitWithTotal model, _) => model.total,
            dataLabelMapper: (TimeUnitWithTotal model, _) =>
                plotPoint.category.categoryName,
            legendIconType: LegendIconType.rectangle,
            name: plotPoint.category.categoryName,
            // onRendererCreated: (ChartSeriesController controller) {
            //   _seriesController = controller;
            // },
          );

          returnList.add(outPut);
        }
        break;

      case StackedBar100Series:
        for (var plotPoint in chartObjects) {
          var outPut = StackedBar100Series(
            dataSource: plotPoint.chartDataPoints,
            xValueMapper: (TimeUnitWithTotal model, _) => model.timeValue,
            yValueMapper: (TimeUnitWithTotal model, _) => model.total,
            dataLabelMapper: (TimeUnitWithTotal model, _) =>
                plotPoint.category.categoryName,
            legendIconType: LegendIconType.rectangle,
            name: plotPoint.category.categoryName,
            // onRendererCreated: (ChartSeriesController controller) {
            //   _seriesController = controller;
            // },
          );

          returnList.add(outPut);
        }
        break;

      case LineSeries:
        for (var plotPoint in chartObjects) {
          var outPut = LineSeries(
            dataSource: plotPoint.chartDataPoints,
            xValueMapper: (TimeUnitWithTotal model, _) => model.timeValue,
            yValueMapper: (TimeUnitWithTotal model, _) => model.total,
            dataLabelMapper: (TimeUnitWithTotal model, _) =>
                plotPoint.category.categoryName,
            legendIconType: LegendIconType.rectangle,
            name: plotPoint.category.categoryName,
            // onRendererCreated: (ChartSeriesController controller) {
            //   _seriesController = controller;
            // },
          );

          returnList.add(outPut);
        }
        returnList.addAll(_getProfilesLineSeries());
        break;

      case ColumnSeries:
        for (var plotPoint in chartObjects) {
          var outPut = ColumnSeries(
            dataSource: plotPoint.chartDataPoints,
            xValueMapper: (TimeUnitWithTotal model, _) => model.timeValue,
            yValueMapper: (TimeUnitWithTotal model, _) => model.total,
            dataLabelMapper: (TimeUnitWithTotal model, _) =>
                plotPoint.category.categoryName,
            legendIconType: LegendIconType.rectangle,
            name: plotPoint.category.categoryName,
            // onRendererCreated: (ChartSeriesController controller) {
            //   _seriesController = controller;
            // },
          );

          returnList.add(outPut);
        }
        returnList.addAll(_getProfilesLineSeries());
        break;
    }

    return returnList;
  }

  List<ChartSeries> _getProfilesLineSeries() {
    var chartObject = _timelineService.mainChartProfileTotalSeries;
    var outPut = SplineSeries(
      dataSource: chartObject.chartDataPoints,
      xValueMapper: (TimeUnitWithTotal model, _) => model.timeValue,
      yValueMapper: (TimeUnitWithTotal model, _) => model.total,
      name: '${chartObject.profile.name} total',
      legendIconType: LegendIconType.horizontalLine,
      // onRendererCreated: (ChartSeriesController controller) {
      //   _seriesController = controller;
      // },
    );
    return [outPut];
  }

  // Widget getloadMoreIndicatorBuilder(
  //     BuildContext context, ChartSwipeDirection direction) {
  //   if (direction == ChartSwipeDirection.end) {
  //     isNeedToUpdateView = true;
  //     globalKey = GlobalKey<State>();
  //     return StatefulBuilder(
  //         key: globalKey,
  //         builder: (BuildContext context, StateSetter stateSetter) {
  //           Widget widget;
  //           if (isNeedToUpdateView) {
  //             widget = getProgressIndicator();
  //             _updateView();
  //             isDataUpdated = true;
  //           } else {
  //             widget = Container();
  //           }
  //           return widget;
  //         });
  //   } else if (direction == ChartSwipeDirection.start) {
  //     return SizedBox.fromSize(size: Size.zero);
  //   } else {
  //     return SizedBox.fromSize(size: Size.zero);
  //   }
  // }

  // //Adding new data to the chart.
  // void _updateData() {
  //   var newData = _timelineService.getDaysFrom(_timeSeries.last.dateTime);
  //   _timeSeries.addAll(newData);
  //   isLoadMoreView = true;
  //   _seriesController?.updateDataSource(
  //       addedDataIndexes: getIndexes(newData.length));
  // }

  // getIndexes(int lenght) {
  //   List<int> indexes = <int>[];
  //   for (int i = lenght - 1; i >= 0; i--) {
  //     indexes.add(_timeSeries.length - 1 - i);
  //   }
  //   return indexes;
  // }

  // // Redrawing the chart with updated data by calling the chart state.
  // Future<void> _updateView() async {
  //   await Future<void>.delayed(const Duration(seconds: 1), () {
  //     isNeedToUpdateView = false;
  //     if (isDataUpdated) {
  //       _updateData();
  //       isDataUpdated = false;
  //     }
  //     setState(() {});
  //   });
  // }

  // Widget getProgressIndicator() {
  //   return Align(
  //     alignment: Alignment.centerRight,
  //     child: Padding(
  //       padding: const EdgeInsets.only(bottom: 22),
  //       child: Container(
  //         width: 50,
  //         alignment: Alignment.centerRight,
  //         decoration: BoxDecoration(
  //           gradient: LinearGradient(
  //             colors: _themeProvider.isLightTheme
  //                 ? <Color>[
  //                     Colors.white.withOpacity(0.0),
  //                     Colors.white.withOpacity(0.74)
  //                   ]
  //                 : const <Color>[
  //                     Color.fromRGBO(33, 33, 33, 0.0),
  //                     Color.fromRGBO(33, 33, 33, 0.74)
  //                   ],
  //             stops: const <double>[0.0, 1],
  //           ),
  //         ),
  //         child: const SizedBox(
  //           height: 35,
  //           width: 35,
  //           child: CircularProgressIndicator(
  //             backgroundColor: Colors.transparent,
  //             strokeWidth: 3,
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }
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
