import 'package:objectbox/objectbox.dart';

@Entity()
class ReactionObjectBox {
  int id;
  String raw;
  String reaction;

  ReactionObjectBox({this.id = 0, required this.raw, required this.reaction});
}