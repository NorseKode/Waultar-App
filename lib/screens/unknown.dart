import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:waultar/globals/scaffold_main.dart';
import 'package:waultar/navigation/app_state.dart';
import 'package:waultar/navigation/router/app_route_path.dart';

class UnknownView extends StatefulWidget {
  const UnknownView({Key? key}) : super(key: key);

  @override
  _UnknownViewState createState() => _UnknownViewState();
}

class _UnknownViewState extends State<UnknownView> {
  _goToHome(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        context.read<AppState>().updateNavigatorState(AppRoutePath.home());
      },
      child: Text('Go To Home'),
    );
  }

  _goToTestScreen1Button() {
    return ElevatedButton(
      onPressed: () {
        context.read<AppState>().updateNavigatorState(AppRoutePath.testScreen1());
      },
      child: Text('Go To Test Screen'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return getScaffoldMain(
      context,
      Center(
        child: Column(
          children: [
            Text('404'),
            _goToHome(context),
            _goToTestScreen1Button(),
          ],
        ),
      ),
    );
  }
}
