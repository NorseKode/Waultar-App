class ChangeModel {
  final int id;
  final String valueName;
  final String previousValue;
  final String newValue;
  final DateTime timestamp;
  final String raw;

  ChangeModel(
      {this.id = 0,
      required this.valueName,
      required this.previousValue,
      required this.newValue,
      required this.timestamp,
      required this.raw});
}
