import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waultar/core/models/ui_model.dart';
import 'package:waultar/data/entities/nodes/datapoint_node.dart';
import 'package:waultar/data/repositories/datapoint_repo.dart';
import 'package:waultar/presentation/providers/theme_provider.dart';

class DatapointWidget extends StatefulWidget {
  final dynamic datapoint;
  final String? title;
  const DatapointWidget({this.title, this.datapoint, Key? key})
      : super(key: key);

  @override
  State<DatapointWidget> createState() => _DatapointWidgetState();
}

class _DatapointWidgetState extends State<DatapointWidget> {
  late ThemeProvider themeProvider;

  @override
  Widget build(BuildContext context) {
    themeProvider = Provider.of<ThemeProvider>(context);
    switch (widget.datapoint.runtimeType) {
      case DataPoint:
        return _datapoint(widget.datapoint as DataPoint);

      case UIDTO:
        return _UIModel(widget.datapoint as UIDTO);
    }
    return Container();
  }

  Widget _datapoint(DataPoint datapoint) {
    print("Hej");
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title ?? datapoint.stringName,
          style: themeProvider.themeData().textTheme.headline1,
        ),
        SizedBox(height: 10),
        Wrap(
            spacing: double.infinity,
            runSpacing: 10,
            children: List.generate(
                datapoint.asMap.length,
                (index) => Wrap(
                      children: [
                        RichText(
                          text: TextSpan(
                            style: DefaultTextStyle.of(context).style,
                            children: <TextSpan>[
                              TextSpan(
                                text:
                                    "${datapoint.asMap.entries.elementAt(index).key}: ",
                                style: themeProvider
                                    .themeData()
                                    .textTheme
                                    .headline4,
                              ),
                              TextSpan(
                                text: "hello",
                              ),
                              TextSpan(
                                text:
                                    "${datapoint.asMap.entries.elementAt(index).value}",
                              ),
                            ],
                          ),
                        ),
                      ],
                    ))),
        Divider(
            height: 45,
            thickness: 2,
            color: themeProvider.themeMode().tonedColor),
      ],
    );
  }

  Widget _UIModel(UIDTO datapoint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title ?? datapoint.getMostInformativeField(),
          style: themeProvider.themeData().textTheme.headline1,
        ),
        SizedBox(height: 10),
        Wrap(
            spacing: double.infinity,
            runSpacing: 10,
            children: List.generate(
                datapoint.toMap().length,
                (index) => Wrap(
                      children: [
                        RichText(
                          text: TextSpan(
                            style: DefaultTextStyle.of(context).style,
                            children: <TextSpan>[
                              TextSpan(
                                text:
                                    "${datapoint.toMap().entries.elementAt(index).key}: ",
                                style: themeProvider
                                    .themeData()
                                    .textTheme
                                    .headline4,
                              ),
                              TextSpan(
                                text:
                                    "${datapoint.toMap().entries.elementAt(index).value}",
                              ),
                            ],
                          ),
                        ),
                      ],
                    ))),
        Divider(
            height: 45,
            thickness: 2,
            color: themeProvider.themeMode().tonedColor),
      ],
    );
  }
}
