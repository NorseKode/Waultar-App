import 'package:objectbox/objectbox.dart';

@Entity()
class ChangeObjectBox {
  int id;
  String raw;

  String valueName;
  String previousValue;
  String newValue;

  @Property(type: PropertyType.date)
  DateTime timestamp;

  ChangeObjectBox(
      {this.id = 0,
      required this.raw,
      required this.valueName,
      required this.previousValue,
      required this.newValue,
      required this.timestamp});
}
