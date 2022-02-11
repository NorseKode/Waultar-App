import 'package:objectbox/objectbox.dart';
import 'package:waultar/core/models/misc/change_model.dart';
import 'package:waultar/data/entities/misc/service_objectbox.dart';

@Entity()
class ProfileObjectBox {
  int id;
  final service = ToOne<ServiceObjectBox>();
  String uri;
  String? username;
  String fullName = "";
  // final emails = ToMany<EmailModel>();
  bool? gender;
  String? bio;
  String? currentCity;
  String? phoneNumber;
  bool? isPhoneConfirmed;
  @Property(type: PropertyType.date)
  DateTime createdTimestamp = DateTime.fromMicrosecondsSinceEpoch(0);
  bool? isPrivate;
  List<String>? websites;
  @Property(type: PropertyType.date)
  DateTime? dateOfBirth;
  String? bloodInfo;
  String? friendPeerGroup;
  List<ChangeModel>? changes;
  // final activities = ToMany<ActivityModel>();
  String? eligibility;
  String? metadata;
  String raw = "";

  ProfileObjectBox({
    this.id = 0, 
    required this.uri,
    this.username,
    required this.fullName,
    this.gender,
    this.bio,
    this.currentCity,
    this.phoneNumber,
    this.isPhoneConfirmed,
    required this.createdTimestamp,
    this.isPrivate,
    this.websites,
    this.dateOfBirth,
    this.bloodInfo,
    this.friendPeerGroup,
    this.changes,
    this.eligibility,
    this.metadata,
    required this.raw,
  });
}