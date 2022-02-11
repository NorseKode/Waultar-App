import 'dart:math';

class ModelHelper {
  static const knownTimestampKeys = [
    "timestamp",
    "creation_timestamp",
    "timestamp_ms"
  ];

  static DateTime? getTimestamp(var jsonData) {
    var key = trySeveralKeys(jsonData, knownTimestampKeys);

    if (key != null) {
      return intToTimestamp(jsonData[key]);
    }

    return null;
  }

  static DateTime? intToTimestamp(int? timeSinceEpoch) {
    if (timeSinceEpoch == null) {
      return null;
    } else {
      var amountOfCharacters = timeSinceEpoch.toString().length;
      var amountOfMissingCharacters = 16 - amountOfCharacters;

      return DateTime.fromMicrosecondsSinceEpoch(
          timeSinceEpoch * (pow(10, amountOfMissingCharacters).toInt()));
    }
  }

  static String? trySeveralKeys(var jsonData, List<String> keys) {
    for (var key in keys) {
      if (jsonData is Map<String, dynamic> && jsonData.containsKey(key)) {
        return key;
      }
    }

    return null;
  }
}
