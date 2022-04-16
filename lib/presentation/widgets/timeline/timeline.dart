import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:tabbed_view/tabbed_view.dart';
import 'package:tuple/tuple.dart';
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
    tabs.add(TabData(
      text: 'Test',
      closable: false,
      content: _testChart(),
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
        Expanded(child: _averageChart()),
      ],
    );
  }

  Widget _averageChart() {
    bool anyData = _timelineService.mainChartCategorySeries.isNotEmpty;
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
      series: anyData ? _getAverageChartSeries() : null,
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
    bool anyData = _timelineService.mainChartCategorySeries.isNotEmpty;
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
    bool anyData = _timelineService.mainChartCategorySeries.isNotEmpty;
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
      onAxisLabelTapped: anyData
          ? (AxisLabelTapArgs args) {
              var index = args.value;
              setState(() {
                _timelineService.updateMainChartSeries(index);
              });
            }
          : null,
      plotAreaBorderWidth: 0,
      primaryXAxis: DateTimeCategoryAxis(
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
          );

          returnList.add(outPut);
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

      // case ColumnSeries:
      //   for (var plotPoint in chartObjects) {
      //     var outPut = ColumnSeries(
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
    );
    return [outPut];
  }

  Widget _testChart() {
    var user1 = UserChartData(userName: 'User 1');
    List<TestChartData> _dataSourceUser1 = [
      TestChartData.generateTestData(DateTime(2018)),
      TestChartData.generateTestData(DateTime(2019)),
      TestChartData.generateTestData(DateTime(2020)),
      TestChartData.generateTestData(DateTime(2021)),
      TestChartData.generateTestData(DateTime(2022)),
    ];
    user1.dataSeries = _dataSourceUser1;

    var user2 = UserChartData(userName: 'User 2');
    List<TestChartData> _dataSourceUser2 = [
      TestChartData.generateTestData(DateTime(2018)),
      TestChartData.generateTestData(DateTime(2019)),
      // TestChartData.generateTestData(DateTime(2020)),
      TestChartData.generateTestData(DateTime(2021)),
      TestChartData.generateTestData(DateTime(2022)),
    ];
    user2.dataSeries = _dataSourceUser2;
    List<UserChartData> users = [user1, user2];

    List<ChartSeries> chartSeries = [];

    for (var item in CategoryEnum.values) {
      for (var user in users) {
        var output = StackedColumnSeries(
          dataSource: user.dataSeries,
          xValueMapper: (TestChartData data, index) => data.xValue,
          yValueMapper: (TestChartData data, index) =>
              data.yValues[item.index].item2,
          pointColorMapper: (TestChartData data, index) =>
              data.yValues[item.index].item1.color,
          dataLabelMapper: (TestChartData data, index) =>
              data.yValues[item.index].item1.categoryName,
          name: CategoryEnum.values[item.index].categoryName,
          groupName: user.userName,
          selectionBehavior: _selectionBehavior,
          color: item.color,
          legendItemText: '${item.categoryName} - ${user.userName}',
          legendIconType: LegendIconType.circle,
          sortFieldValueMapper: (TestChartData data, _) => data.xValue,
        );
        chartSeries.add(output);
      }
    }

    for (var user in users) {
      var output = SplineSeries(
        dataSource: user.dataSeries,
        xValueMapper: (TestChartData data, _) => data.xValue,
        yValueMapper: (TestChartData data, _) => data.total,
        dataLabelMapper: (TestChartData data, _) => user.userName,
        name: '${user.userName} total',
        legendItemText: '${user.userName} total',
        legendIconType: LegendIconType.horizontalLine,
      );
      chartSeries.add(output);
    }

    return SfCartesianChart(
      primaryXAxis: DateTimeCategoryAxis(
        intervalType: DateTimeIntervalType.years,
      ),
      series: chartSeries,
      selectionType: SelectionType.series,
      enableMultiSelection: true,
      legend: Legend(
        isVisible: true,
        position: LegendPosition.right,
        toggleSeriesVisibility: true,
      ),
    );
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

class TestChartData {
  late DateTime xValue;
  late int total;
  late List<Tuple2<CategoryEnum, int>> yValues;

  TestChartData({
    required this.xValue,
    required this.total,
  }) : yValues = [];

  TestChartData.generateTestData(DateTime x) {
    xValue = x;
    Random random = Random();
    yValues = List.generate(CategoryEnum.values.length, (index) {
      var category = CategoryEnum.values[index];
      var yValue = random.nextInt(200);
      return Tuple2(category, yValue);
    });
    total = yValues.fold(
        0, (previousValue, element) => previousValue + element.item2);
  } //: this(xValue: x, groupName: groupBy)
}

class UserChartData {
  String userName;
  late List<TestChartData> dataSeries;
  UserChartData({
    required this.userName,
  }) {
    dataSeries = [];
  }
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
