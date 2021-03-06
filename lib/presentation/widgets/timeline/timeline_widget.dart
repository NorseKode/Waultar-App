import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:waultar/configs/globals/category_enums.dart';
import 'package:waultar/core/models/timeline/time_models.dart';
import 'package:waultar/presentation/providers/theme_provider.dart';
import 'package:waultar/presentation/widgets/general/default_widgets/default_widget_box.dart';

class TimelineWidget extends StatefulWidget {
  List<TimeModel> blocks;
  TimelineWidget({required this.blocks, Key? key}) : super(key: key);

  @override
  State<TimelineWidget> createState() => _TimelineWidgetState();
}

class _TimelineWidgetState extends State<TimelineWidget> {
  late ThemeProvider themeProvider;
  late int maxDatapointCount;
  late int rowCount;
  String dropdownValue = '2000';

  Widget _yAxis(int max, int rowCount) {
    return Column(
      children: [
        Expanded(
            child: Column(
                children: List.generate(
                    rowCount + 1,
                    (index) => Expanded(
                          child: Container(
                              decoration: BoxDecoration(
                                  border: Border(
                                bottom: BorderSide(
                                    color: Colors.grey.withOpacity(0.3)),
                              )),
                              alignment: Alignment.bottomCenter,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(NumberFormat.compact()
                                        .format(((max / rowCount) * (index)))),
                                  ])),
                        )).reversed.toList())),
      ],
    );
  }

  Widget _xAxis(List<TimeModel> blocks) {
    return Column(
      children: [
        //const SizedBox(height: 20),
        Expanded(
          child: Row(
            children: List.generate(
                blocks.length,
                (index) => Expanded(
                    child: Container(
                        alignment: Alignment.bottomCenter,
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
                          rowCount + 1,
                          (index) => Expanded(
                                  child: Container(
                                decoration: BoxDecoration(
                                    border: Border(
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
            //child: Text("${model.total}"),
          ),
        ),
        Expanded(
          flex: blockHeight,
          child: Column(
            children: List.generate(
                model.categoryCount.length,
                (index) => Expanded(
                      flex: model.categoryCount[index].item1.count,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 10.0, right: 10, top: 3),
                        child: Container(
                          color:
                              model.categoryCount[index].item1.category.color,
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
        Expanded(flex: 1, child: Container()),
        Expanded(
          flex: rowCount,
          child: Row(
              children: List.generate(blocks.length,
                  (index) => Expanded(child: _block(blocks[index])))),
        ),
      ],
    );
  }

  int _maxListLength(List<TimeModel> blocks) {
    List<int> listLengths = [];
    for (var model in blocks) {
      listLengths.add(model.total);
    }
    return listLengths.isNotEmpty
        ? (listLengths.reduce(max) / 10000).ceil() * 10000
        : 0;
  }

  @override
  Widget build(BuildContext context) {
    themeProvider = Provider.of<ThemeProvider>(context);

    List<TimeModel> blocks = widget.blocks;
    if (blocks.isEmpty) return Container();
    maxDatapointCount = _maxListLength(blocks);
    rowCount = 5;

    return DefaultWidgetBox(
        child: Container(
      child: blocks.isEmpty
          ? Expanded(child: Container(child: const Center(child: Text("No data"))))
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Overview of datapoints",
                      style: themeProvider.themeData().textTheme.headline4,
                    ),
                    Text(
                      "ALL YEARS",
                      style: themeProvider.themeData().textTheme.headline4,
                    ),
                  ],
                ),
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
                    const SizedBox(
                      width: 50,
                    ),
                    Expanded(
                        child: SizedBox(height: 30, child: _xAxis(blocks))),
                  ],
                )
              ],
            ),
    ));
  }
}
