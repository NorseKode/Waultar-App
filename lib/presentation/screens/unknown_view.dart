import 'package:flutter/material.dart';
// ignore: implementation_imports
import 'package:provider/src/provider.dart';
import 'package:waultar/configs/globals/scaffold_main.dart';
import 'package:waultar/configs/navigation/app_state.dart';
import 'package:waultar/configs/navigation/router/app_route_path.dart';


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
      child: const Text('Go To Home'),
    );
  }

  _goToTestScreen1Button() {
    return ElevatedButton(
      onPressed: () {
        context.read<AppState>().updateNavigatorState(AppRoutePath.testScreen1());
      },
      child: const Text('Go To Test Screen'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return getScaffoldMain(
      context,
      Center(
        child: Column(
          children: [
            const Text('404'),
            _goToHome(context),
            _goToTestScreen1Button(),
          ],
        ),
      ),
    );
  }
}
