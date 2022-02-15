import 'package:objectbox/objectbox.dart';


@Entity()
class ActivityObjectBox {
  int id;
  String raw;
  @Property(type: PropertyType.date)
  DateTime timestamp;

  ActivityObjectBox({this.id = 0, required this.timestamp, required this.raw});
}