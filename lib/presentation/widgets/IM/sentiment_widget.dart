import 'package:flutter/material.dart';
import 'package:waultar/core/abstracts/abstract_services/i_ml_service.dart';
import 'package:waultar/presentation/widgets/general/default_widgets/default_widget.dart';
import 'package:waultar/startup.dart';

class SentimentWidget extends StatefulWidget {
  const SentimentWidget({Key? key}) : super(key: key);

  @override
  State<SentimentWidget> createState() => _SentimentWidgetState();
}

class _SentimentWidgetState extends State<SentimentWidget> {
  @override
  Widget build(BuildContext context) {
    final _mlService = locator.get<IMLService>(instanceName: 'mlService');
    return DefaultWidget(
        title: "Sentiment Analysis",
        child: Text("hello: ${_mlService.connotateText("hello")}"));
  }
}
