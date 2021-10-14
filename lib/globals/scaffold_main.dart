import 'package:flutter/material.dart';

// var _selectedIndex = 0;

_getAppBar(BuildContext context, String? message, Function? onTap) {
  return AppBar(
    title: Text(message != null ? message : 'Waultar'),
    leading: GestureDetector(
      onTap: () => onTap != null ? onTap() : Navigator.pop(context),
      child: Icon(Icons.arrow_back),
    ),
  );
}

SafeArea _getSafeAreaMain(var body) {
  return SafeArea(
    minimum: EdgeInsets.all(26.0),
    child: Center(
      child: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: body,
      ),
    ),
  );
}

getScaffoldMain(BuildContext context, var body, {String? appBarText, Function? onTapAppBar}) {
  return Scaffold(
    // appBar: _getAppBar(context, appBarText, onTapAppBar),
    body: _getSafeAreaMain(body),
  );
}