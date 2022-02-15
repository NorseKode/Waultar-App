import 'package:objectbox/objectbox.dart';

@Entity()
class EmailObjectBox {
  int id;
  String raw;
  String email;
  bool isCurrent;

  @Property(type: PropertyType.date)
  DateTime timestamp;

  EmailObjectBox(
      {this.id = 0,
      required this.raw,
      required this.email,
      this.isCurrent = false,
      required this.timestamp});
}
