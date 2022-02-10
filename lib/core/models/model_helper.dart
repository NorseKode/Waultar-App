import 'dart:math';

class ModelHelper {
  static const knownTimestampKeys = ["timestamp", "creation_timestamp", "timestamp_ms"];
  
  static DateTime? getTimestamp(var jsonData) {
    var key = trySeveralKeys(jsonData, knownTimestampKeys);

    if (key != null) {
      var amountOfCharacters = jsonData[key].toString().length;
      var amountOfMissingCharacters = 16 - amountOfCharacters;

      return DateTime.fromMicrosecondsSinceEpoch(
          jsonData[key] * (pow(10, amountOfMissingCharacters).toInt()));
    }
  }

  static String? trySeveralKeys(var jsonData, List<String> keys) {
    for (var key in keys) {
      if (jsonData is Map<String, dynamic> && jsonData.containsKey(key)) {
        return key;
      }
    }
  }
}
