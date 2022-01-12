import 'package:waultar/parser/parse_helper.dart';
import 'package:waultar/parser/parser_enums.dart';

class MediaDTO {
  final String path;
  final MediaType mediaType;
  final String title;
  final String text;

  MediaDTO(var guid, var timestamp, var profileId, this.path, this.mediaType, this.title, this.text);// : super(guid, timestamp, guid);

  MediaDTO.fromJson(Map<String, dynamic> json, List<String> pathNames)
    : path = trySeveralNames(json, pathNames), 
      title = json['title'],
      mediaType = json['mediaType'],
      text = json['title'];
}
