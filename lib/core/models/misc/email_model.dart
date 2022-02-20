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

  EmailModel.fromJson(Map<String, dynamic> json, {bool? isCurrent}) 
    : id = 0,
      email = json["value"],
      isCurrent = isCurrent ?? false,
      raw = json.toString();
}
