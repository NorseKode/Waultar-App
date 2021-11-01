@JS()
library main;

import 'dart:convert';

import 'package:js/js.dart';
import 'package:js/js_util.dart';
import 'package:waultar/etebase/models/etebase_user.dart';
import 'package:waultar/globals/globals.dart';
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

dynamic signUp(EtebaseUser etebaseUserAuth, String password) async {
  var dataFuture = promiseToFuture(signUpEtebase({etebaseUserAuth.username, etebaseUserAuth.email}, password, serverUrl));
  print({ etebaseUserAuth.username, etebaseUserAuth.email});
  var rawData = await dataFuture;
  var jsonString = stringify(rawData);
  var dataAsMap = jsonDecode(jsonString);
  var parsedData = EtebaseUser.getUserFromEtebaseResponse(dataAsMap);
  return EtebaseUser.fromJson(parsedData);
  // return signUpEtebase({ etebaseUserAuth.username, etebaseUserAuth.email}, password, serverUrl);
}

Future<EtebaseUser> signIn(String username, String password) async {
  var dataFuture = promiseToFuture(login(username, password, serverUrl));
  var rawData = await dataFuture;
  var jsonString = stringify(rawData);
  var dataAsMap = jsonDecode(jsonString);
  var parsedData = EtebaseUser.getUserFromEtebaseResponse(dataAsMap);
  return EtebaseUser.fromJson(parsedData);
}

Future<EtebaseUser> etebaseResponseToEtebaseUser(Function fun) async {
  var future = promiseToFuture(fun);
  var rawData = await future;
  var jsonString = stringify(rawData);
  var dataAsMap = jsonDecode(jsonString);
  var parsedData = EtebaseUser.getUserFromEtebaseResponse(dataAsMap);
  return EtebaseUser.fromJson(parsedData);
}

// dynamic signUp(EtebaseUser etebaseUser, String password, String serverUrl) async {
//   var future = promiseToFuture(signUpEtebase({etebaseUser.username, etebaseUser.email}, password, serverUrl));
//   var rawData = await future;
//   var jsonString = stringify(rawData);
//   var dataAsMap = jsonDecode(jsonString);
//   var parsedData = EtebaseUser.getUserFromEtebaseResponse(dataAsMap);
//   return EtebaseUser.fromJson(parsedData);
//   // return await etebaseResponseToEtebaseUser(
//   //     signUpEtebase({etebaseUser.username, etebaseUser.email}, password, serverUrl));
// }

// Future<EtebaseUser> signIn(String username, String password, String serverUrl) async {
//   return etebaseResponseToEtebaseUser(login(username, password, serverUrl));
// }

// Future<EtebaseUser> etebaseResponseToEtebaseUser(dynamic fun) async {
//   var future = promiseToFuture(fun);
//   var rawData = await future;
//   var jsonString = stringify(rawData);
//   var dataAsMap = jsonDecode(jsonString);
//   var parsedData = EtebaseUser.getUserFromEtebaseResponse(dataAsMap);
//   return EtebaseUser.fromJson(parsedData);
// }
