import 'package:waultar/core/models/index.dart';
import 'package:waultar/data/entities/misc/email_objectbox.dart';

EmailModel makeEmailModel(EmailObjectBox entity) {
  var modelToReturn = EmailModel(
      id: entity.id,
      email: entity.email,
      isCurrent: entity.isCurrent,
      raw: entity.raw);
  return modelToReturn;
}
