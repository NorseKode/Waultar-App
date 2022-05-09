import 'package:tuple/tuple.dart';

extension NorseKodeInt on int {
  /// the tuples contains the first entry as offset, second limit
  List<Tuple2<int, int>> splitEqualOffsetLimit({required int splits}) {
    var returnList = <Tuple2<int, int>>[];

    if (splits > 0 && splits <= this) {
      var splitCount = this ~/ splits;
      var missing = this - (splitCount * splits);
      var offset = 0;
      var limit = 0;

      for (var i = 0; i < splits; i++) {
        if (missing > 0) {
          limit = splitCount + 1;
          missing--;
        } else {
          limit = splitCount;
        }

        returnList.add(
          Tuple2(
            offset,
            limit,
          ),
        );

        offset = offset + limit;
      }
    }

    return returnList;
  }
}
