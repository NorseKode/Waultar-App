import 'dart:ui';

import 'package:waultar/core/models/misc/person_model.dart';
import 'package:waultar/core/models/profile/profile_model.dart';

import '../base_model.dart';
import 'message_model.dart';

class MessageThreadModel extends BaseModel {
  final String title;
  final bool isParticiapting;
  final String magicWord;
  final List<PersonModel> participants;
  final List<MessageModel> messages;
  final MessageType messageType;

  MessageThreadModel(int id, ProfileModel profile, String raw, this.title, this.isParticiapting, this.magicWord, this.participants, this.messages, this.messageType) : super(id, profile, raw);

  @override
  Color getAssociatedColor() {
    // TODO: implement getAssociatedColor
    throw UnimplementedError();
  }

  @override
  String getMostInformativeField() {
    // TODO: implement getMostInformativeField
    throw UnimplementedError();
  }

  @override
  DateTime getTimestamp() {
    // TODO: implement getTimestamp
    throw UnimplementedError();
  }
}

enum MessageType {
  unknown,
  inbox
}