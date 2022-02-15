import 'package:objectbox/objectbox.dart';

@Entity()
class CoordinateObjectBox {
  int id;
  double longitude;
  double latitude;

  CoordinateObjectBox(
      {this.id = 0, required this.longitude, required this.latitude});
}
