class EmailModel {
  final int id = 0;
  final String email;
  final bool isCurrent;
  final DateTime timestamp;
  final String raw;

  EmailModel(this.email, this.isCurrent, this.timestamp, this.raw);
}