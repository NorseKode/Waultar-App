import 'package:objectbox/objectbox.dart';
import 'package:waultar/core/inodes/media_documents.dart';
import 'package:waultar/core/inodes/service_document.dart';
import 'package:waultar/data/entities/misc/email_objectbox.dart';

@Entity()
class ProfileObjectBox {
  int id;
  final service = ToOne<ServiceDocument>();
  String uri;
  String? username;
  String fullName;
  final profilePicture = ToOne<ImageDocument>();
  final emails = ToMany<EmailObjectBox>();
  String? gender;
  String? bio;
  String? currentCity;
  List<String>? phoneNumbers;
  bool? isPhoneConfirmed;
  @Property(type: PropertyType.date)
  DateTime createdTimestamp = DateTime.fromMicrosecondsSinceEpoch(0);
  bool? isPrivate;
  List<String>? websites;
  @Property(type: PropertyType.date)
  DateTime? dateOfBirth;
  String? bloodInfo;
  String? friendPeerGroup;
  String? eligibility;
  List<String>? metadata;
  String? basePathToFiles;
  String raw;

  ProfileObjectBox({
    this.id = 0,
    required this.uri,
    this.username,
    required this.fullName,
    this.gender,
    this.bio,
    this.currentCity,
    this.phoneNumbers,
    this.isPhoneConfirmed,
    required this.createdTimestamp,
    this.isPrivate,
    this.websites,
    this.dateOfBirth,
    this.bloodInfo,
    this.friendPeerGroup,
    this.eligibility,
    this.metadata,
    this.basePathToFiles,
    required this.raw,
  });
}
