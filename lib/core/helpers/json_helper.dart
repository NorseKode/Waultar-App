import 'package:waultar/data/configs/objectbox.g.dart';

class JsonHelper {
  static convertToOneToJson(ToOne<dynamic> input) => input.targetId;
  static convertToManyToJson(ToMany<dynamic> input) => input.map((element) => element.id).toList();
  static convertIntIntMap(Map<int, int> input) => input.map((key, value) => MapEntry(key.toString(), value));
}