// ignore_for_file: unnecessary_this

import 'package:tuple/tuple.dart';

extension NorseKodeList<T> on List<T> {
  // List<List<T>> splitEqual(int splits)  {
  //   var returnList = <dynamic>[];
  //   var splitCount = splits / this.length;

  //   for (var i = 0; i < splits; i++) {
  //     returnList.add(this.)
  //   }

  //   return returnList;
  // }

  /// the tuples contains the first entry as offset, second limit
  List<Tuple3<int, int, List<T>>> splitEqualVerbose({required int splits}) {
    var test = this.length;
    var returnList = <Tuple3<int, int, List<T>>>[];

    if (this.isNotEmpty && splits != 0 && splits <= this.length) {
      var splitCount = this.length ~/ splits;
      var missing =  this.length - (splitCount * splits);
      var offset = 0;
      var limit = 0;

      for (var i = 0; i < splits; i++) {
        // limit = (i != splits - 1 ? splitCount : splitCount + 1);
        // offset = (splitCount + extendedCount) * i;

        if (missing > 0) {
          limit = splitCount + 1;
          missing--;
        } else {
          limit = splitCount;
        }

        returnList.add(
          Tuple3(
            offset,
            limit,
            <T>[],
            // this.getRange(offset, limit).toList(),
          ),
        );

        offset = offset + limit;
      }
    }

    return returnList;
  }
}
