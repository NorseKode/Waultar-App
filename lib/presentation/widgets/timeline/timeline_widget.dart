import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waultar/core/models/ui_model.dart';
import 'package:waultar/presentation/providers/theme_provider.dart';

class TimelineWidget extends StatefulWidget {
  //Time, Category, Models
  final Map<String, List<List<UIModel>>> categoryListsSorted;
  const TimelineWidget({Key? key, required this.categoryListsSorted})
      : super(key: key);

  @override
  State<TimelineWidget> createState() => _TimelineWidgetState();
}

class _TimelineWidgetState extends State<TimelineWidget> {
  late ThemeProvider themeProvider;

  Widget _timelineBlock(
      String time, List<List<UIModel>> categoryLists, int mostTotal) {
    int totalPointsInBlock = 0;
    categoryLists.forEach((list) => totalPointsInBlock += list.length);
    int blockheight = (totalPointsInBlock / mostTotal * 100).round();
    return Expanded(
      child: Column(
        children: [
          Expanded(
            flex: 100 - blockheight,
            child: Container(), // Empty space
          ),
          Expanded(
              flex: blockheight,
              child: Column(
                children: List.generate(
                    categoryLists.length,
                    (index) => Expanded(
                        flex: totalPointsInBlock - categoryLists[index].length,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Container(
                            decoration: index == 0
                                ? BoxDecoration(
                                    color: categoryLists[index]
                                        .first
                                        .getAssociatedColor(),
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(2),
                                        topRight: Radius.circular(2)))
                                : BoxDecoration(
                                    color: categoryLists[index]
                                        .first
                                        .getAssociatedColor(),
                                  ),
                          ),
                        ))),
              )),
        ],
      ),
    );
  }

  int _maxListLength() {
    List<int> listLengths = [];
    widget.categoryListsSorted
        .forEach((k, v) => listLengths.add(v[0].length + v[1].length));
    return (listLengths.reduce(max) / 10).ceil() * 10;
  }

  Widget _grid(int rows) {
    return Container(
      //decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
      child: Column(
        children: List.generate(
            rows + 1,
            (index) => Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                width: 1,
                                color: Colors.grey.withOpacity(0.3)))),
                  ),
                )),
      ),
    );
  }

  Widget _box() {
    return SizedBox(
        height: 100, width: 100, child: Container(color: Colors.green));
  }

  Widget _blocks() {
    List<Widget> blocks = [];
    int max = _maxListLength();
    widget.categoryListsSorted
        .forEach((k, v) => blocks.add(_timelineBlock(k, v, max)));
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(children: blocks),
    );
  }

  Widget _leftbar(int rows) {
    return Container(
      child: Column(
        children: [
          Expanded(flex: 1, child: Container()),
          Expanded(
              flex: rows * 2,
              child: Column(
                children: List.from((List.generate(
                    rows,
                    (index) => Expanded(
                            child: Center(
                          child: Container(
                            child: Text(
                                "${((_maxListLength() / (rows + 1)) * (index + 1)).round()}"),
                          ),
                        )))).reversed),
              )),
          Expanded(flex: 1, child: Container()),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    themeProvider = Provider.of<ThemeProvider>(context);
    List<Widget> timeAxis = [];
    widget.categoryListsSorted.forEach((k, v) => timeAxis.add(Expanded(
          child: Center(child: Text(k)),
        )));
    int rows = 4;
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color(0xFF272837)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Overview of datapoints",
                ),
                Text("datepicker")
              ],
            ),
            SizedBox(height: 10),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(width: 20, child: _leftbar(rows)),
                  Expanded(
                      child: Stack(
                    alignment: Alignment.bottomLeft,
                    children: [
                      _grid(rows),
                      //_box(),
                      _blocks()
                    ],
                  )),
                ],
              ),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                const SizedBox(
                  width: 20,
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Container(
                    child: Row(
                      children: timeAxis,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                    child: Row(children: [
                  SizedBox(
                      height: 10,
                      width: 10,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.circular(2)),
                      )),
                  SizedBox(width: 10),
                  Text("Posts: "),
                  Text("${widget.categoryListsSorted.values.first.length}")
                ])),
                Container(
                    child: Row(children: [
                  SizedBox(
                    height: 10,
                    width: 10,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.pink,
                          borderRadius: BorderRadius.circular(2)),
                    ),
                  ),
                  SizedBox(width: 10),
                  Text("Images: "),
                  Text(
                      "${widget.categoryListsSorted.values.elementAt(1).length}")
                ]))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
