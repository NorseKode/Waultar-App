class CoordinateModel {
  int id;
  double longitude;
  double latitude;

  CoordinateModel({
    this.id = 0,
    required this.longitude,
    required this.latitude,
  });

  CoordinateModel.fromJson(Map<String, dynamic> json)
    : id = 0,
    latitude = json['latitude'], 
    longitude = json['longitude']; 
}
