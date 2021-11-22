import 'package:flutter/material.dart';
// ignore: implementation_imports
import 'package:provider/src/provider.dart';
import 'package:waultar/globals/scaffold_main.dart';
import 'package:waultar/navigation/app_state.dart';
import 'package:waultar/navigation/router/app_route_path.dart';
import 'package:waultar/widgets/upload/uploader.dart';

class TestView1 extends StatefulWidget {
  const TestView1({Key? key}) : super(key: key);

  @override
  TestView1State createState() => TestView1State();
}

class TestView1State extends State<TestView1> {
  _goToUnkownButtion(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // context.read<AppState>().updateNavigatorState(AppRoutePath.unknown());
        _upload(context);
      },
      child: Text('Go To Unkonwn'),
    );
  }

  _upload(BuildContext context) {
    var result = Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => UploaderComponent(),
        ));

    print(result);

    // return UploaderComponent();
  }

  @override
  Widget build(BuildContext context) {
    return getScaffoldMain(
      context,
      Center(
        child: Column(
          children: [
            const Text('Test Screen 1'),
            _goToUnkownButtion(context),
          ],
        ),
      ),
    );
  }
}
