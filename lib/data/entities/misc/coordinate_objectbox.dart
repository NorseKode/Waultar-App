import 'package:objectbox/objectbox.dart';

@Entity()
class CoordinateObjectBox {
  int id;
  double longitude;
  double latitude;

  CoordinateObjectBox(this.id, this.longitude, this.latitude);
}