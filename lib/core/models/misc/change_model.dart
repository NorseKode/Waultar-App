class ChangeModel {
  final int id;
  final String valueName;
  final String previousValue;
  final String newValue;
  final DateTime timestamp;
  final String raw;

  ChangeModel(this.id, this.valueName, this.previousValue, this.newValue, this.timestamp, this.raw);
}