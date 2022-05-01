class DoNotUseHelper {
  static int createMemoryOverflow() {
    var overflowList = <double>[];

    for (var i = 0; i < i + 1; i++) {
      overflowList.add(42.0);
    }
    
    return 1;
  }
}