@JS()
library main;

import 'dart:convert';

import 'package:js/js.dart';
import 'package:js/js_util.dart';
import 'package:tuple/tuple.dart';
import 'package:waultar/etebase/models/etebase_user.dart';
import 'package:waultar/exceptions/etebase_exceptions.dart';
import 'package:waultar/globals/globals.dart';

// Standard JS functions
@JS('JSON.stringify')
external String stringify(Object obj);

// Etebase functions
@JS()
@anonymous
class EtebaseUserJS {
  external String get username;
  external String get email;

  external factory EtebaseUserJS({String username, String email});
}

@JS('Etebase.Account.signup')
external dynamic signUpEtebase(dynamic usr, dynamic password, dynamic serverUrl);

@JS('Etebase.Account.login')
external dynamic login(dynamic username, dynamic password, dynamic serverUrl);

@JS('Etebase.Account.logout')
external dynamic logout();

dynamic signUp(EtebaseUser etebaseUser, String password) async {
  var response = await etebaseResponseToEtebaseUser(signUpEtebase(
      EtebaseUserJS(username: etebaseUser.username, email: etebaseUser.email),
      password,
      serverUrl));

  if (response.item1 != null) {
    return response.item1;
  } else {
    throw EtebaseExceptions(response.item2);
  }
}

Future<EtebaseUser?> signIn(String username, String password) async {
  var response = await etebaseResponseToEtebaseUser(login(username, password, serverUrl));

  if (response.item1 != null) {
    return response.item1;
  } else {
    throw EtebaseExceptions(response.item2);
  }
}

Future<Tuple2<EtebaseUser?, String>> etebaseResponseToEtebaseUser(dynamic fun) async {
  try {
    var future = promiseToFuture(fun);
    var rawData = await future;
    var jsonString = stringify(rawData);
    var dataAsMap = jsonDecode(jsonString);
    var parsedData = EtebaseUser.getUserFromEtebaseResponse(dataAsMap);
    return Tuple2(EtebaseUser.fromJson(parsedData), '');
  } catch (e) {
    return Tuple2(null, e.toString());
  }
}
