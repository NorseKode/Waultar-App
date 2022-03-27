/*
* Classes that can be used as packages to send between isolate ports
* PLEASE NOTE: Each class can only have fields of primitive types
*/

class LogRecordPackage {
  String value;
  String error;
  LogRecordPackage(this.value, this.error);
}

class InitiatorPackage {
  bool testing;
  InitiatorPackage({this.testing = false});
}