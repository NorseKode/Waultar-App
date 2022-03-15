import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';
import 'package:waultar/core/abstracts/abstract_repositories/i_timebuckets_repository.dart';
import 'package:waultar/core/abstracts/abstract_services/i_timeline_service.dart';
import 'package:waultar/core/models/timeline/time_models.dart';
import 'package:waultar/core/models/ui_model.dart';
import 'package:waultar/domain/services/timeline_service.dart';
import 'package:waultar/presentation/providers/theme_provider.dart';
import 'package:waultar/startup.dart';

class TimelineWidget extends StatefulWidget {
  const TimelineWidget({Key? key}) : super(key: key);

  @override
  State<TimelineWidget> createState() => _TimelineWidgetState();
}

class _TimelineWidgetState extends State<TimelineWidget> {
  late ThemeProvider themeProvider;
  late int maxDatapointCount;
  late int rowCount;

  Widget _yAxis(int max, int rowCount) {
    return Container(
      child: Column(
        children: [
          Expanded(
              child: Column(
            children: [
              Expanded(
                  child: Column(
                      children: List.generate(
                          rowCount,
                          (index) => Expanded(
                                child: Container(
                                    decoration: BoxDecoration(
                                        border: Border(
                                      top: index + 1 == rowCount
                                          ? BorderSide(color: Colors.white)
                                          : BorderSide.none,
                                      bottom: BorderSide(color: Colors.white),
                                    )),
                                    alignment: Alignment.bottomCenter,
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(NumberFormat.compact().format(
                                              ((max / rowCount) *
                                                  (index + 1)))),
                                          Text(NumberFormat.compact().format(
                                              ((max / rowCount) * (index)))),
                                        ])),
                              )).reversed.toList())),
            ],
          )),
        ],
      ),
    );
  }

  Widget _xAxis(List<TimeModel> blocks) {
    return Column(
      children: [
        const SizedBox(height: 20),
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(
                blocks.length,
                (index) => Expanded(
                    flex: 2,
                    child: Container(
                        alignment: Alignment.topCenter,
                        child: Text("${blocks[index].timeValue}")))),
          ),
        )
      ],
    );
  }

  Widget _grid(int max, int rowCount) {
    return Container(
      child: Column(
        children: [
          Expanded(
              child: Column(
            children: [
              Expanded(
                  child: Column(
                      children: List.generate(
                          rowCount,
                          (index) => Expanded(
                                  child: Container(
                                decoration: BoxDecoration(
                                    border: Border(
                                  top: index + 1 == rowCount
                                      ? BorderSide(
                                          color: Colors.grey.withOpacity(0.3))
                                      : BorderSide.none,
                                  bottom: BorderSide(
                                      color: Colors.grey.withOpacity(0.3)),
                                )),
                              ))).reversed.toList())),
            ],
          )),
        ],
      ),
    );
  }

  Widget _block(TimeModel model) {
    int blockHeight = ((model.total / maxDatapointCount) * 10000).round();
    return Column(
      children: [
        Expanded(
          flex: 10000 - blockHeight,
          child: Container(
            alignment: Alignment.bottomCenter,
            child: Text("${model.total}"),
          ),
        ),
        Expanded(
          flex: blockHeight,
          child: Column(
            children: List.generate(
                model.entries.length,
                (index) => Expanded(
                      flex: model.entries[index].item1,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Container(
                          color: model.entries[index].item3,
                        ),
                      ),
                    )),
          ),
        )
      ],
    );
  }

  Widget _blocks(
    List<TimeModel> blocks,
  ) {
    return Column(
      children: [
        Expanded(
          child: Row(
              children: List.generate(blocks.length,
                  (index) => Expanded(child: _block(blocks[index])))),
        ),
      ],
    );
  }

  int _maxListLength(List<TimeModel> blocks) {
    List<int> listLengths = [];
    blocks.forEach((model) => listLengths.add(model.total));
    return listLengths.isNotEmpty
        ? (listLengths.reduce(max) / 10).ceil() * 10
        : 0;
  }

  @override
  Widget build(BuildContext context) {
    themeProvider = Provider.of<ThemeProvider>(context);
    ITimelineService timelineService =
        locator.get<ITimelineService>(instanceName: 'timeService');

    //List<TimeModel> blocks = timelineService.getAllYears();
    List<TimeModel> blocks = List.generate(
        5,
        (index) =>
            YearModel(index, 2000 + index, (index + 1 * 2) + (index + 1 * 3), [
              Tuple3(index + 1 * 2, "Post:$index", Colors.pink),
              Tuple3(index + 1 * 3, "Image:$index", Colors.amber)
            ]));

    if (blocks.isEmpty) return Container();
    maxDatapointCount = _maxListLength(blocks);
    rowCount = 4;
    // rowCount =
    //     (((int.parse((maxDatapointCount.toString()).substring(0, 1))) * 5) / 2)
    //         .ceil();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [Text("Settings row")],
        ),
        blocks.isEmpty
            ? Expanded(child: Container(child: Center(child: Text("No data"))))
            : Expanded(
                child: Column(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          SizedBox(
                              width: 50,
                              child: _yAxis(maxDatapointCount, rowCount)),
                          Expanded(
                              child: Column(
                            children: [
                              Expanded(
                                child: Stack(
                                  children: [
                                    _grid(maxDatapointCount, rowCount),

                                    _blocks(blocks),
                                    // _graph(),
                                  ],
                                ),
                              ),
                            ],
                          )),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 50,
                          height: 50,
                          // child: Container(
                          //     decoration: BoxDecoration(
                          //         border: Border(
                          //       top: BorderSide(color: Colors.white),
                          //     )),
                          //     alignment: Alignment.topCenter,
                          //     child: Text("0")),
                        ),
                        Expanded(
                            child: SizedBox(height: 50, child: _xAxis(blocks))),
                      ],
                    )
                  ],
                ),
              ),
      ],
    );
  }
}
