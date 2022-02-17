class EmailModel {
  int id;
  String email;
  bool isCurrent;
  String raw;

  EmailModel({
    this.id = 0,
    required this.email,
    required this.isCurrent,
    required this.raw,
  });
}
