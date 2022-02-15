class EmailModel {
  final int id;
  final String email;
  final bool isCurrent;
  final DateTime timestamp;
  final String raw;

  EmailModel(
      {this.id = 0,
      required this.email,
      required this.isCurrent,
      required this.timestamp,
      required this.raw});
}
