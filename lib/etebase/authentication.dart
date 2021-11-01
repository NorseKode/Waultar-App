@JS()
library main;

import 'dart:convert';

import 'package:js/js.dart';
import 'package:js/js_util.dart';
import 'package:waultar/etebase/models/etebase_user.dart';
import 'package:waultar/navigation/app_state.dart';

// Standard JS functions
@JS('JSON.stringify')
external String stringify(Object obj);

// Etebase functions
@JS('Etebase.Account.signup')
external dynamic signUpEtebase(dynamic usr, dynamic password, dynamic serverUrl);

@JS('Etebase.Account.login')
external dynamic login(dynamic username, dynamic password, dynamic serverUrl);

@JS('Etebase.Account.logout')
external dynamic logout();

dynamic signUp(EtebaseUserAuth etebaseUserAuth, String password, String serverUrl) {
  return signUpEtebase({ etebaseUserAuth.username, etebaseUserAuth.email}, password, serverUrl);
}

Future<EtebaseUser> signIn(String username, String password, String serverUrl) async {
  var dataFuture = promiseToFuture(login(username, password, serverUrl));
  var rawData = await dataFuture;
  var jsonString = stringify(rawData);
  var dataAsMap = jsonDecode(jsonString);
  var parsedData = EtebaseUser.getUserFromEtebaseResponse(dataAsMap);
  return EtebaseUser.fromJson(parsedData);
}

class EtebaseUserAuth {
  String username;
  String email;

  EtebaseUserAuth(this.username, this.email);
}
