import 'package:waultar/core/parsers/parse_helper.dart';

import 'parser_enums.dart';

class ContentDTO {
  final String guid;
  final MyContentType contentType;
  final String title;
  final String description;

  ContentDTO(this.guid, this.contentType, this.title, this.description);

  ContentDTO.fromJson(Map<String, dynamic> json, List<String> contentTypeNames,
      List<String> titleNames, List<String> descriptionNames)
      : guid = 'TODO',
        contentType = MyContentType.unknown,
        title = ParseHelper.trySeveralNames(json, titleNames),
        description = ParseHelper.trySeveralNames(json, descriptionNames);

  @override
  String toString() {
    return "guid: $guid, content type: $contentType, title: $title, description: $description";
  }
}
