import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waultar/core/models/ui_model.dart';
import 'package:waultar/presentation/providers/theme_provider.dart';
import 'package:waultar/presentation/widgets/timeline/datapoint_widget.dart';
import 'package:waultar/presentation/widgets/timeline/datapointlist_widget.dart';
import 'package:waultar/presentation/widgets/timeline/timeline_widget.dart';
import 'package:waultar/presentation/widgets/timeline/test.dart' as test;

class Timeline extends StatefulWidget {
  const Timeline({Key? key}) : super(key: key);

  @override
  State<Timeline> createState() => _TimelineState();
}

class _TimelineState extends State<Timeline> {
  late ThemeProvider themeProvider;

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
        const SizedBox(height: 20),
        Expanded(
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    Expanded(
                        flex: 4,
                        child: TimelineWidget(
                          categoryListsSorted: test.list,
                        )),
                    SizedBox(height: 20),
                    Expanded(
                        flex: 2,
                        child: DatapointListWidget(
                            datapoints: test.list.values.first.first))
                  ],
                ),
              ),
              SizedBox(width: 20),
              Expanded(
                flex: 1,
                child: Column(
                  children: [Expanded(child: DatapointWidget())],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
