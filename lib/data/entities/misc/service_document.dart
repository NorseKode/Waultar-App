
import 'package:objectbox/objectbox.dart';

@Entity()
class ServiceDocument {
  int id;
  @Unique()
  String serviceName;
  String companyName;
  String image;
  int totalDatapoints;

  ServiceDocument({
    this.id = 0,
    required this.serviceName,
    required this.companyName,
    required this.image,
    this.totalDatapoints = 0,
  });
}