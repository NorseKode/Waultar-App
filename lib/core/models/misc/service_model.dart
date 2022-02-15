class ServiceModel {
  int id;
  String name;
  String company;
  Uri image;

  ServiceModel(
      {this.id = 0,
      required this.name,
      required this.company,
      required this.image});
}
