import 'package:flutter/material.dart';
import 'package:waultar/globals/scaffold_main.dart';

class UploaderView extends StatefulWidget {
  const UploaderView({Key? key}) : super(key: key);

  @override
  _UploaderViewState createState() => _UploaderViewState();
}

class _UploaderViewState extends State<UploaderView> {
  @override
  Widget build(BuildContext context) {
    return getScaffoldMain(
      context,
      Center(
        child: Column(
          children: [
            const Text('TODO'),
          ],
        ),
      ),
    );
  }
}
