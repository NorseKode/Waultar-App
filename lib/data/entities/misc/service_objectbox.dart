import 'package:objectbox/objectbox.dart';

@Entity()
class ServiceObjectBox {
  int id;
  String name;
  String company;
  String image;

  ServiceObjectBox(
      {this.id = 0,
      required this.name,
      required this.company,
      required this.image});
}
