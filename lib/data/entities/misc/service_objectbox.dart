import 'package:objectbox/objectbox.dart';

@Entity()
class ServiceObjectBox {
  int id;

  @Unique()
  String name;

  String company;
  String image;

  ServiceObjectBox({
    this.id = 0,
    required this.name,
    required this.company,
    required this.image,
  });
}
