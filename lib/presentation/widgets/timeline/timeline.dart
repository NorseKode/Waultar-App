import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:tabbed_view/tabbed_view.dart';
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
  late int selectedTab;
  late SelectionBehavior _selectionBehavior;

  @override
  void initState() {
    initVariables();
    super.initState();
  }

  void initVariables() {
    selectedTab = 0;
    _timelineService.init();
    _tooltipBehavior = TooltipBehavior(enable: true);
    _selectionBehavior = SelectionBehavior(
      enable: true,
      unselectedOpacity: 0.2,
    );
    _chosenChartType = ChartSeriesType.stackedColumns;
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
        const SizedBox(height: 10),
        _profileSelector(),
        const SizedBox(height: 10),
        _tabs(),
      ],
    );
  }

  Widget _tabs() {
    List<TabData> tabs = [];

    tabs.add(TabData(
      text: 'Data over time',
      closable: false,
      content: _timeLineTabContent(),
    ));
    tabs.add(TabData(
      text: 'Averages',
      closable: false,
      content: _averageTabContent(),
    ));
    tabs.add(TabData(
      text: 'Sentiment',
      closable: false,
      content: _sentimentChart(),
    ));

    var controller = TabbedViewController(tabs);
    controller.selectedIndex = selectedTab;
    TabbedView tabbedView = TabbedView(
      controller: controller,
      onTabSelection: (index) => selectedTab = index ?? 0,
    );
    TabbedViewTheme tabTheme = TabbedViewTheme(
      child: tabbedView,
      data: TabbedViewThemeData.dark(
        colorSet: Colors.grey,
      ),
    );
    return Expanded(child: tabTheme);
  }

  Widget _profileSelector() {
    return DropdownButton(
      value: _timelineService.currentProfile,
      items: List.generate(
        _timelineService.allProfiles.length,
        (index) => DropdownMenuItem(
          child:
              Text(_profileNameInDropDown(_timelineService.allProfiles[index])),
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

  String _profileNameInDropDown(ProfileDocument profile) {
    if (profile.service.hasValue) {
      return '${profile.name} - ${profile.service.target!.serviceName}';
    } else {
      return profile.name;
    }
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

  Widget _averageTabContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: _getAverageChart()),
      ],
    );
  }

  Widget _sentimentChart() {
    bool anyData = _timelineService.chartData.isNotEmpty;
    return SfCartesianChart(
      title: ChartTitle(
        text: 'Sentiment over time per category',
      ),
      plotAreaBorderWidth: 0,
      tooltipBehavior: TooltipBehavior(
        enable: true,
      ),
      primaryYAxis: NumericAxis(
        majorGridLines: const MajorGridLines(width: 0),
      ),
      primaryXAxis: DateTimeCategoryAxis(
        majorGridLines: const MajorGridLines(width: 0),
        labelIntersectAction: AxisLabelIntersectAction.rotate45,
        intervalType: _timelineService.currentXAxisInterval,
        interval: 1,
        minimum: anyData ? _timelineService.minimum : null,
        maximum: anyData ? _timelineService.maximum : null,
      ),
      series: anyData ? _getSentimentChartSeries() : null,
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

  Widget _timeLineTabContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            _chartTypeSelector(),
            const SizedBox(width: 20),
            _resetButton(),
          ],
        ),
        const SizedBox(height: 15),
        Expanded(child: _timelineChart()),
      ],
    );
  }

  Widget _timelineChart() {
    bool anyData = _timelineService.chartData.isNotEmpty;
    return SfCartesianChart(
      key: GlobalKey<State>(),
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
        if (args.axisName == 'x_axis') {
          setState(() {
            _timelineService.updateMainChartSeries(args.value);
          });
        }
      },
      selectionType: SelectionType.series,
      enableMultiSelection: true,
      plotAreaBorderWidth: 0,
      primaryXAxis: DateTimeAxis(
        name: 'x_axis',
        majorGridLines: const MajorGridLines(width: 0),
        labelIntersectAction: AxisLabelIntersectAction.rotate45,
        intervalType: _timelineService.currentXAxisInterval,
        interval: 1,
        minimum: anyData ? _timelineService.minimum : null,
        maximum: anyData ? _timelineService.maximum : null,
      ),
      series: anyData ? _getMainChartSeries() : null,
    );
  }

  List<ChartSeries> _getMainChartSeries() {
    var returnList = <ChartSeries>[];
    switch (_chosenChartType.chartType) {
      case StackedColumnSeries:
        for (var item in CategoryEnum.values) {
          for (var user in _timelineService.chartData) {
            var output = StackedColumnSeries(
              dataSource: user.categorySeries,
              xValueMapper: (CategoryChartData data, index) => data.xValue,
              yValueMapper: (CategoryChartData data, index) =>
                  data.yValues[item.index].item2,
              pointColorMapper: (CategoryChartData data, index) => item.color,
              name: '${item.categoryName} - ${user.userName}',
              groupName: user.userName,
              selectionBehavior: _selectionBehavior,
              color: item.color,
              legendItemText: '${item.categoryName} - ${user.userName}',
              legendIconType: LegendIconType.circle,
            );
            returnList.add(output);
          }
        }
        returnList.addAll(_getProfilesLineSeries());
        break;

      case StackedColumn100Series:
        for (var item in CategoryEnum.values) {
          for (var user in _timelineService.chartData) {
            var output = StackedColumn100Series(
              dataSource: user.categorySeries,
              xValueMapper: (CategoryChartData data, index) => data.xValue,
              yValueMapper: (CategoryChartData data, index) =>
                  data.yValues[item.index].item2,
              pointColorMapper: (CategoryChartData data, index) => item.color,
              name: '${item.categoryName} - ${user.userName}',
              groupName: user.userName,
              selectionBehavior: _selectionBehavior,
              color: item.color,
              legendItemText: '${item.categoryName} - ${user.userName}',
              legendIconType: LegendIconType.circle,
            );
            returnList.add(output);
          }
        }
        break;

      case StackedBarSeries:
        for (var item in CategoryEnum.values) {
          for (var user in _timelineService.chartData) {
            var output = StackedBarSeries(
              dataSource: user.categorySeries,
              xValueMapper: (CategoryChartData data, index) => data.xValue,
              yValueMapper: (CategoryChartData data, index) =>
                  data.yValues[item.index].item2,
              pointColorMapper: (CategoryChartData data, index) => item.color,
              name: '${item.categoryName} - ${user.userName}',
              groupName: user.userName,
              selectionBehavior: _selectionBehavior,
              color: item.color,
              legendItemText: '${item.categoryName} - ${user.userName}',
              legendIconType: LegendIconType.circle,
            );
            returnList.add(output);
          }
        }
        break;

      case StackedBar100Series:
        for (var item in CategoryEnum.values) {
          for (var user in _timelineService.chartData) {
            var output = StackedBar100Series(
              dataSource: user.categorySeries,
              xValueMapper: (CategoryChartData data, index) => data.xValue,
              yValueMapper: (CategoryChartData data, index) =>
                  data.yValues[item.index].item2,
              pointColorMapper: (CategoryChartData data, index) => item.color,
              name: '${item.categoryName} - ${user.userName}',
              groupName: user.userName,
              selectionBehavior: _selectionBehavior,
              color: item.color,
              legendItemText: '${item.categoryName} - ${user.userName}',
              legendIconType: LegendIconType.circle,
            );
            returnList.add(output);
          }
        }
        break;

      // case LineSeries:
      //   for (var plotPoint in chartObjects) {
      //     var outPut = LineSeries(
      //       dataSource: plotPoint.chartDataPoints,
      //       xValueMapper: (TimeUnitWithTotal model, _) => model.timeValue,
      //       yValueMapper: (TimeUnitWithTotal model, _) => model.total,
      //       dataLabelMapper: (TimeUnitWithTotal model, _) =>
      //           plotPoint.category.categoryName,
      //       legendIconType: LegendIconType.rectangle,
      //       name: plotPoint.category.categoryName,
      //     );

      //     returnList.add(outPut);
      //   }
      //   returnList.addAll(_getProfilesLineSeries());
      //   break;

    //   case ColumnSeries:
    //     for (var plotPoint in chartObjects) {
    //       var outPut = ColumnSeries(
    //         dataSource: plotPoint.chartDataPoints,
    //         xValueMapper: (TimeUnitWithTotal model, _) => model.timeValue,
    //         yValueMapper: (TimeUnitWithTotal model, _) => model.total,
    //         dataLabelMapper: (TimeUnitWithTotal model, _) =>
    //             plotPoint.category.categoryName,
    //         legendIconType: LegendIconType.rectangle,
    //         name: plotPoint.category.categoryName,
    //       );

    //       returnList.add(outPut);
    //     }
    //     returnList.addAll(_getProfilesLineSeries());
    //     break;
    }

    return returnList;
  }

  List<ChartSeries> _getProfilesLineSeries() {
    var returnList = <ChartSeries>[];

    for (var user in _timelineService.chartData) {
      var output = SplineSeries(
        dataSource: user.categorySeries,
        xValueMapper: (CategoryChartData data, _) => data.xValue,
        yValueMapper: (CategoryChartData data, _) => data.total,
        name: '${user.userName} total',
        legendItemText: '${user.userName} total',
        legendIconType: LegendIconType.horizontalLine,
        splineType: SplineType.monotonic,
      );
      returnList.add(output);
    }

    return returnList;
  }

  Widget _getAverageChart() {
    bool anyData = _timelineService.chartData.isNotEmpty;
    return SfCartesianChart(
      title: ChartTitle(
        text: 'Average pr weekday',
      ),
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
      series: anyData ? _averageChartSeries() : null,
    );
  }

  List<ChartSeries> _averageChartSeries() {
    var returnList = <ChartSeries>[];
    for (var item in CategoryEnum.values) {
      for (var user in _timelineService.averageCharData) {
        var output = StackedColumnSeries(
          dataSource: user.averageSeries,
          xValueMapper: (WeekDayAverageChartPoint data, index) => data.xValue,
          yValueMapper: (WeekDayAverageChartPoint data, index) =>
              data.yValues[item.index].item2,
          pointColorMapper: (WeekDayAverageChartPoint data, _) => item.color,
          name: '${item.categoryName} - ${user.userName}',
          groupName: user.userName,
          color: item.color,
        );
        returnList.add(output);
      }
    }
    return returnList;
  }

}

enum ChartSeriesType {
  stackedColumns,
  stackedColumns100,
  stackedBar,
  stackedBar100,
  // lines,
  // columns,
}

extension ChartSeriesTypeHelper on ChartSeriesType {
  static const namesMap = {
    ChartSeriesType.stackedColumns: 'Stacked Columns',
    ChartSeriesType.stackedColumns100: 'Stacked Columns Percentage',
    ChartSeriesType.stackedBar: 'Stacked Bars',
    ChartSeriesType.stackedBar100: 'Stacked Bars Percentage',
    // ChartSeriesType.lines: 'Lines',
    // ChartSeriesType.columns: 'Columns',
  };

  static const chartTypeMap = {
    ChartSeriesType.stackedColumns: StackedColumnSeries,
    ChartSeriesType.stackedColumns100: StackedColumn100Series,
    ChartSeriesType.stackedBar: StackedBarSeries,
    ChartSeriesType.stackedBar100: StackedBar100Series,
    // ChartSeriesType.lines: LineSeries,
    // ChartSeriesType.columns: ColumnSeries,
  };

  static const canZoomMap = {
    ChartSeriesType.stackedColumns: true,
    ChartSeriesType.stackedColumns100: false,
    ChartSeriesType.stackedBar: true,
    ChartSeriesType.stackedBar100: false,
    // ChartSeriesType.lines: true,
    // ChartSeriesType.columns: true,
  };

  String get chartName => namesMap[this] ?? 'Unknown';
  Type get chartType => chartTypeMap[this] ?? StackedColumnSeries;
  bool get canZoom => canZoomMap[this] ?? false;
}
