// import 'package:objectbox/objectbox.dart';
// import 'package:waultar/core/models/profile/friend_model.dart';

// import 'profile_objectbox.dart';

// @Entity()
// class FriendObjectBox {
//   int id;
//   final profile = ToOne<ProfileObjectBox>();
//   // PersonObjectBox friend;
//   FriendType? friendType;
//   @Property(type: PropertyType.date)
//   DateTime? timestamp;
//   String raw;

//   int? get dbFriendType {
//     _ensureStableEnumValue();
//     return friendType!.index;
//   }

//   set dbFriendType(int? value) {
//     _ensureStableEnumValue();
//     if (value == null) {
//       friendType = null;
//     } else {
//     friendType = value >= 0 && value < FriendType.values.length
//         ? FriendType.values[value]
//         : FriendType.unknown;
//     }
//   }

//   FriendObjectBox({
//     this.id = 0,
//     this.friendType,
//     this.timestamp,
//     required this.raw,
//   });

//   void _ensureStableEnumValue() {
//     assert(FriendType.unknown.index == 0);
//     assert(FriendType.friend.index == 1);
//     assert(FriendType.deleted.index == 2);
//     assert(FriendType.rejected.index == 3);
//     assert(FriendType.sentRequest.index == 4);
//   }
// }
