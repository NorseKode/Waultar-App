import 'package:objectbox/objectbox.dart';

@Entity()
class TagObjectBox {
  int id = 0;
  String name;

  TagObjectBox({this.id = 0, required this.name});
}
