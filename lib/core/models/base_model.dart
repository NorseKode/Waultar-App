import 'package:waultar/core/models/misc/service_model.dart';

abstract class BaseModel {  
  int id = 0;
  ServiceModel service;
  String raw;

  BaseModel(this.id, this.service, this.raw);
}
