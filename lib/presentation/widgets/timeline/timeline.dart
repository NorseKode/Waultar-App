import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:waultar/configs/globals/category_enums.dart';
import 'package:waultar/core/abstracts/abstract_services/i_timeline_service.dart';
import 'package:waultar/core/models/timeline/time_models.dart';
import 'package:waultar/data/entities/misc/profile_document.dart';
import 'package:waultar/presentation/providers/theme_provider.dart';
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

  late List<TimeModel> _timeSeries;
  late TooltipBehavior _tooltipBehavior;
  late ChartSeriesType _chosenChartType;
  late TimeIntervalType _chosenTimeInterval;
  ChartSeriesController? _seriesController;
  late bool isLoadMoreView, isNeedToUpdateView, isDataUpdated;
  double? oldAxisVisibleMin, oldAxisVisibleMax;
  late ZoomPanBehavior _zoomPanBehavior;
  late GlobalKey<State> globalKey;
  late List<ProfileDocument> _profiles;
  late ProfileDocument _chosenProfile;

  @override
  void initState() {
    initVariables();
    super.initState();
  }

  void initVariables() {
    _timeSeries = _timelineService.getDaysFrom(DateTime(2019));
    _profiles = _timelineService.getAllProfiles();
    _chosenProfile = _profiles.first;
    _tooltipBehavior = TooltipBehavior(enable: true);
    _chosenChartType = ChartSeriesType.stackedColumns;
    _chosenTimeInterval = TimeIntervalType.days;
    isLoadMoreView = false;
    isNeedToUpdateView = false;
    isDataUpdated = true;
    globalKey = GlobalKey<State>();
    _zoomPanBehavior = ZoomPanBehavior(
      enablePanning: true,
      zoomMode: ZoomMode.x,
      enableMouseWheelZooming: _chosenChartType.canZoom,
    );
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
        Row(
          children: [
            _chartTypeSelector(),
            const SizedBox(width: 20),
            _timeIntervalSelector(),
            const SizedBox(width: 20),
            _profileSelector(),
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

  Widget _profileSelector() {
    return DropdownButton(
      value: _chosenProfile,
      items: List.generate(
        _profiles.length,
        (index) => DropdownMenuItem(
          child: Text(
              '${_profiles[index].name} - ${_profiles[index].service.target!.companyName}'),
          value: _profiles[index],
        ),
      ),
      onChanged: (ProfileDocument? profile) {
        setState(() {
          _chosenProfile = profile ?? _profiles.first;
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
              _timeSeries =
                  _timelineService.getDaysFrom(_timeSeries.first.dateTime);
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
      key: GlobalKey<State>(),
      onActualRangeChanged: _chosenTimeInterval == TimeIntervalType.days
          ? (ActualRangeChangedArgs args) {
              if (args.orientation == AxisOrientation.horizontal) {
                if (isLoadMoreView) {
                  args.visibleMin = oldAxisVisibleMin;
                  args.visibleMax = oldAxisVisibleMax;
                }
                oldAxisVisibleMin = args.visibleMin as double;
                oldAxisVisibleMax = args.visibleMax as double;
              }
              isLoadMoreView = false;
            }
          : null,
      loadMoreIndicatorBuilder: _chosenTimeInterval == TimeIntervalType.days
          ? (BuildContext context, ChartSwipeDirection direction) =>
              getloadMoreIndicatorBuilder(context, direction)
          : null,
      tooltipBehavior: _tooltipBehavior,
      zoomPanBehavior: _zoomPanBehavior,
      legend: Legend(isVisible: true),
      trackballBehavior: TrackballBehavior(
        enable: true,
        activationMode: ActivationMode.longPress,
        tooltipDisplayMode: TrackballDisplayMode.groupAllPoints,
        lineColor: Colors.transparent,
        // we can use the builder to hide values where total == 0
      ),
      primaryYAxis: NumericAxis(
        title: AxisTitle(
          text: 'Amount of Datapoints',
        ),
      ),
      onAxisLabelTapped: (AxisLabelTapArgs args) {
        print(args.value);
      },
      primaryXAxis: DateTimeCategoryAxis(
        placeLabelsNearAxisLine: true,
        title: AxisTitle(
          text: 'Time',
        ),
        labelIntersectAction: AxisLabelIntersectAction.rotate45,
        intervalType: _getCurrentXIntervalEnum(),
        minimum: _timeSeries.first.dateTime,
        maximum: _timeSeries.last.dateTime,
      ),
      series: _getChartSeries(),
    );
  }

  Widget getloadMoreIndicatorBuilder(
      BuildContext context, ChartSwipeDirection direction) {
    if (direction == ChartSwipeDirection.end) {
      isNeedToUpdateView = true;
      globalKey = GlobalKey<State>();
      return StatefulBuilder(
          key: globalKey,
          builder: (BuildContext context, StateSetter stateSetter) {
            Widget widget;
            if (isNeedToUpdateView) {
              widget = getProgressIndicator();
              _updateView();
              isDataUpdated = true;
            } else {
              widget = Container();
            }
            return widget;
          });
    } else if (direction == ChartSwipeDirection.start) {
      return SizedBox.fromSize(size: Size.zero);
    } else {
      return SizedBox.fromSize(size: Size.zero);
    }
  }

  //Adding new data to the chart.
  void _updateData() {
    var newData = _timelineService.getDaysFrom(_timeSeries.last.dateTime);
    _timeSeries.addAll(newData);
    isLoadMoreView = true;
    _seriesController?.updateDataSource(
        addedDataIndexes: getIndexes(newData.length));
  }

  getIndexes(int lenght) {
    List<int> indexes = <int>[];
    for (int i = lenght - 1; i >= 0; i--) {
      indexes.add(_timeSeries.length - 1 - i);
    }
    return indexes;
  }

  // Redrawing the chart with updated data by calling the chart state.
  Future<void> _updateView() async {
    await Future<void>.delayed(const Duration(seconds: 1), () {
      isNeedToUpdateView = false;
      if (isDataUpdated) {
        _updateData();
        isDataUpdated = false;
      }
      setState(() {});
    });
  }

  Widget getProgressIndicator() {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 22),
        child: Container(
          width: 50,
          alignment: Alignment.centerRight,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: _themeProvider.isLightTheme
                  ? <Color>[
                      Colors.white.withOpacity(0.0),
                      Colors.white.withOpacity(0.74)
                    ]
                  : const <Color>[
                      Color.fromRGBO(33, 33, 33, 0.0),
                      Color.fromRGBO(33, 33, 33, 0.74)
                    ],
              stops: const <double>[0.0, 1],
            ),
          ),
          child: const SizedBox(
            height: 35,
            width: 35,
            child: CircularProgressIndicator(
              backgroundColor: Colors.transparent,
              strokeWidth: 3,
            ),
          ),
        ),
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
            onRendererCreated: (ChartSeriesController controller) {
              _seriesController = controller;
            },
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
            onRendererCreated: (ChartSeriesController controller) {
              _seriesController = controller;
            },
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
            onRendererCreated: (ChartSeriesController controller) {
              _seriesController = controller;
            },
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
            onRendererCreated: (ChartSeriesController controller) {
              _seriesController = controller;
            },
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
            onRendererCreated: (ChartSeriesController controller) {
              _seriesController = controller;
            },
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
            onRendererCreated: (ChartSeriesController controller) {
              _seriesController = controller;
            },
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
        onRendererCreated: (ChartSeriesController controller) {
          _seriesController = controller;
        },
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
