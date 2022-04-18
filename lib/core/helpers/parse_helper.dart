import 'package:waultar/data/entities/nodes/datapoint_node.dart';

class ParseHelper {
  static List<DateTime> scrapeUniqueTimestampsFromDataPoint(DataPoint dataPoint) {
    return scrapeUniqueTimestamps(dataPoint.asMap);
  }

  static List<DateTime> scrapeUniqueTimestamps(dynamic data) {
    var timestampsSet = <DateTime>{};

    scrapeUniqueTimestamps(dynamic data) {
      if (data is Map<String, dynamic>) {
        for (var entry in data.entries) {
          if ((entry.key.contains('time') || entry.key.contains('date')) && entry.value is int) {
            var timestamp = _tryParse(entry.value);
            if (timestamp != null) timestampsSet.add(timestamp);
          }
          if (entry.value is Map<String, dynamic> || entry.value is List<dynamic>) {
            scrapeUniqueTimestamps(entry.value);
          }
        }
      }
      if (data is List<dynamic>) {
        for (var item in data) {
          scrapeUniqueTimestamps(item);
        }
      }
    }

    scrapeUniqueTimestamps(data);
    return timestampsSet.toList();
  }

  static DateTime? _tryParse(dynamic value) {
    if (value is int) {
      if (value <= 0) return null;

      var length = '$value'.length;
      if (length >= 10 && length < 12) {
        return DateTime.fromMillisecondsSinceEpoch(value * 1000);
      }

      if (length >= 12 && length < 15) {
        return DateTime.fromMillisecondsSinceEpoch(value);
      }

      if (length >= 15 && length < 23) {
        return DateTime.fromMicrosecondsSinceEpoch(value);
      }
    }

    return null;
  }
}
