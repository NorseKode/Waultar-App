import 'dart:math';

class ModelHelper {
  static const knownTimestampKeys = [
    "timestamp",
    "creation_timestamp",
    "timestamp_ms",
  ];

  static DateTime? getTimestamp(var jsonData) {
    var key = trySeveralKeys(jsonData, knownTimestampKeys);

    if (key != null) {
      return intToTimestamp(jsonData[key]);
    }

    return null;
  }

  static DateTime intToTimestamp(int timeSinceEpoch) {
    var amountOfCharacters = timeSinceEpoch.toString().length;
    var amountOfMissingCharacters = 16 - amountOfCharacters;

    return DateTime.fromMicrosecondsSinceEpoch(
        timeSinceEpoch * (pow(10, amountOfMissingCharacters).toInt()));
  }

  static String? trySeveralKeys(var jsonData, List<String> keys) {
    if (jsonData.containsKey("string_map_data")) {
      jsonData = jsonData["string_map_data"];
    }

    for (var key in keys) {
      if (jsonData is Map<String, dynamic> && jsonData.containsKey(key)) {
        return key;
      }
    }

    return null;
  }
}
