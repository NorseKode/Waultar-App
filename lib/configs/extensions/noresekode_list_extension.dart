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
      var limit = 0;
      var offset = 0;
      var splitCount = this.length ~/ splits;

      for (var i = 0; i < splits; i++) {
        limit = (i != splits - 1 ? (splitCount * (i + 1)) : this.length);
        offset = splitCount * i;

        returnList.add(Tuple3(
          offset,
          limit,
          this.getRange(offset, limit).toList(),
        ));
      }
    }

    return returnList;
  }
}
