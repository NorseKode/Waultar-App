import 'dart:math';
import 'package:flutter/material.dart';
import 'package:waultar/core/models/ui_model.dart';

class TimelineWidget extends StatefulWidget {
  //Time, Category, Models
  final Map<String, List<List<UIModel>>> categoryListsSorted;
  const TimelineWidget({Key? key, required this.categoryListsSorted})
      : super(key: key);

  @override
  State<TimelineWidget> createState() => _TimelineWidgetState();
}

class _TimelineWidgetState extends State<TimelineWidget> {
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
    List<Widget> timeAxis = [];
    widget.categoryListsSorted.forEach((k, v) => timeAxis.add(Expanded(
          child: Center(child: Text(k)),
        )));
    int rows = 4;
    return Padding(
      padding: const EdgeInsets.only(right: 20.0, bottom: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(width: 40, child: _leftbar(rows)),
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
          SizedBox(
            height: 40,
            child: Row(
              children: [
                const SizedBox(
                  width: 40,
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
                const SizedBox(
                  width: 10,
                ),
              ],
            ),
          )
        ],
      ),
    );

    // List<Widget> pointAxis = List.generate(
    //     5,
    //     (index) => Expanded(
    //         flex: max,
    //         child: Container(
    //           color: Colors.amber,
    //         )));

    // return Row(
    //   children: [
    //     Expanded(
    //       child: Column(
    //         children: [
    //           Expanded(
    //             child: Row(
    //               children: [
    //                 SizedBox(width: 50, child: Column(children: pointAxis)),
    //                 SizedBox(width: 5),
    //                 Expanded(
    //                   child: Row(children: blocks),
    //                 ),
    //               ],
    //             ),
    //           ),
    //           Padding(
    //             padding: const EdgeInsets.symmetric(vertical: 5.0),
    //             child: SizedBox(
    //               height: 20,
    //               child: Row(children: timeAxis),
    //             ),
    //           )
    //         ],
    //       ),
    //     ),
    //     SizedBox(width: 5),
    //   ],
    // );
  }
}
