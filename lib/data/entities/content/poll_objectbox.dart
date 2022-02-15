import 'package:objectbox/objectbox.dart';
import 'package:waultar/data/entities/profile/profile_objectbox.dart';

@Entity()
class PollObjectBox {
  
  int id;
  final profile = ToOne<ProfileObjectBox>();
  String raw;

  @Property(type: PropertyType.date)
  DateTime? timestamp;

  String? question;
  bool isUsers;

  // store options in raw json
  String? options;

  PollObjectBox({
    this.id = 0, 
    required this.raw,
    this.timestamp,
    this.question,
    this.isUsers = false,
    this.options,
  });
  
}