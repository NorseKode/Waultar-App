import 'package:objectbox/objectbox.dart';

@Entity()
class EmailObjectBox {
  int id;
  String raw;

  @Unique()
  String email;
  bool isCurrent;

  EmailObjectBox({
    this.id = 0,
    required this.raw,
    required this.email,
    this.isCurrent = false,
  });
}
