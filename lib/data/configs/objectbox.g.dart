// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: camel_case_types

import 'dart:typed_data';

import 'package:objectbox/flatbuffers/flat_buffers.dart' as fb;
import 'package:objectbox/internal.dart'; // generated code can access "internal" functionality
import 'package:objectbox/objectbox.dart';
import 'package:objectbox_flutter_libs/objectbox_flutter_libs.dart';

import '../../data/entities/content/comment_objectbox.dart';
import '../../data/entities/content/event_objectbox.dart';
import '../../data/entities/content/group_objectbox.dart';
import '../../data/entities/content/page_objectbox.dart';
import '../../data/entities/content/post_event_objectbox.dart';
import '../../data/entities/content/post_group_objectbox.dart';
import '../../data/entities/content/post_life_event_objectbox.dart';
import '../../data/entities/content/post_objectbox.dart';
import '../../data/entities/content/post_poll_objectbox.dart';
import '../../data/entities/media/file_objectbox.dart';
import '../../data/entities/media/image_objectbox.dart';
import '../../data/entities/media/link_objectbox.dart';
import '../../data/entities/media/video_objectbox.dart';
import '../../data/entities/misc/activity_objectbox.dart';
import '../../data/entities/misc/appsettings_objectbox.dart';
import '../../data/entities/misc/change_objectbox.dart';
import '../../data/entities/misc/coordinate_objectbox.dart';
import '../../data/entities/misc/email_objectbox.dart';
import '../../data/entities/misc/person_objectbox.dart';
import '../../data/entities/misc/place_objectbox.dart';
import '../../data/entities/misc/reaction_objectbox.dart';
import '../../data/entities/misc/service_objectbox.dart';
import '../../data/entities/misc/tag_objectbox.dart';
import '../../data/entities/profile/friend_objectbox.dart';
import '../../data/entities/profile/profile_objectbox.dart';

export 'package:objectbox/objectbox.dart'; // so that callers only have to import this file

final _entities = <ModelEntity>[
  ModelEntity(
      id: const IdUid(1, 1912080628647356680),
      name: 'ActivityObjectBox',
      lastPropertyId: const IdUid(3, 8490642500335233555),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 6893387787399187080),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 2385427543441790832),
            name: 'raw',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 8490642500335233555),
            name: 'timestamp',
            type: 10,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[]),
  ModelEntity(
      id: const IdUid(2, 6873178835934729354),
      name: 'AppSettingsObjectBox',
      lastPropertyId: const IdUid(2, 1561281531272101129),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 7721915155021888876),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 1561281531272101129),
            name: 'darkmode',
            type: 1,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[]),
  ModelEntity(
      id: const IdUid(3, 4520630462844098010),
      name: 'ChangeObjectBox',
      lastPropertyId: const IdUid(6, 1786862688585929688),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 4486380680140731375),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 7417388953913164448),
            name: 'raw',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 7753462835180747134),
            name: 'valueName',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(4, 6648941589677739859),
            name: 'previousValue',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(5, 8918477765335611150),
            name: 'newValue',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(6, 1786862688585929688),
            name: 'timestamp',
            type: 10,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[]),
  ModelEntity(
      id: const IdUid(4, 6450383553762762435),
      name: 'CommentObjectBox',
      lastPropertyId: const IdUid(8, 416383292422665678),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 2472785500247733795),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 4536285871360143555),
            name: 'commentedId',
            type: 11,
            flags: 520,
            indexId: const IdUid(1, 629100515272957232),
            relationTarget: 'PersonObjectBox'),
        ModelProperty(
            id: const IdUid(3, 3915269346634910749),
            name: 'text',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(4, 863163113423247358),
            name: 'timestamp',
            type: 10,
            flags: 0),
        ModelProperty(
            id: const IdUid(5, 548125475774423547),
            name: 'groupId',
            type: 11,
            flags: 520,
            indexId: const IdUid(2, 8638465562560938433),
            relationTarget: 'GroupObjectBox'),
        ModelProperty(
            id: const IdUid(6, 7057396337969248957),
            name: 'eventId',
            type: 11,
            flags: 520,
            indexId: const IdUid(3, 2297783619923642570),
            relationTarget: 'EventObjectBox'),
        ModelProperty(
            id: const IdUid(7, 8344773178462104370),
            name: 'profileId',
            type: 11,
            flags: 520,
            indexId: const IdUid(4, 3814687056846606283),
            relationTarget: 'ProfileObjectBox'),
        ModelProperty(
            id: const IdUid(8, 416383292422665678),
            name: 'textSearch',
            type: 9,
            flags: 0)
      ],
      relations: <ModelRelation>[
        ModelRelation(
            id: const IdUid(1, 5274319326385885688),
            name: 'images',
            targetId: const IdUid(11, 662540943555208646)),
        ModelRelation(
            id: const IdUid(2, 6266775452588102918),
            name: 'videos',
            targetId: const IdUid(25, 8250406239440631921)),
        ModelRelation(
            id: const IdUid(3, 7470564189234604089),
            name: 'files',
            targetId: const IdUid(8, 8260284028690414010)),
        ModelRelation(
            id: const IdUid(4, 7022063034956032179),
            name: 'links',
            targetId: const IdUid(12, 4418866182355057873))
      ],
      backlinks: <ModelBacklink>[]),
  ModelEntity(
      id: const IdUid(5, 1934597420623139024),
      name: 'CoordinateObjectBox',
      lastPropertyId: const IdUid(3, 1239495395720950897),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 29996083953010536),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 663040005234825690),
            name: 'longitude',
            type: 8,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 1239495395720950897),
            name: 'latitude',
            type: 8,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[]),
  ModelEntity(
      id: const IdUid(6, 1331698350771768634),
      name: 'EmailObjectBox',
      lastPropertyId: const IdUid(4, 8575974702364534804),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 1695080473201127618),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 5638498487149604562),
            name: 'raw',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 338897315528629494),
            name: 'email',
            type: 9,
            flags: 2080,
            indexId: const IdUid(5, 1485282458043777140)),
        ModelProperty(
            id: const IdUid(4, 8575974702364534804),
            name: 'isCurrent',
            type: 1,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[]),
  ModelEntity(
      id: const IdUid(7, 5120962936177154267),
      name: 'EventObjectBox',
      lastPropertyId: const IdUid(11, 1140062707292704486),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 7328131462176085504),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 3720156001576728797),
            name: 'profileId',
            type: 11,
            flags: 520,
            indexId: const IdUid(6, 6966059217322173985),
            relationTarget: 'ProfileObjectBox'),
        ModelProperty(
            id: const IdUid(3, 4470684229317603008),
            name: 'raw',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(4, 3732896325648713133),
            name: 'name',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(5, 8262464219761637751),
            name: 'startTimestamp',
            type: 10,
            flags: 0),
        ModelProperty(
            id: const IdUid(6, 1660946303299918884),
            name: 'endTimestamp',
            type: 10,
            flags: 0),
        ModelProperty(
            id: const IdUid(7, 4969442827286177606),
            name: 'createdTimestamp',
            type: 10,
            flags: 0),
        ModelProperty(
            id: const IdUid(8, 5762262280914809013),
            name: 'description',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(9, 1424067217761066674),
            name: 'isUsers',
            type: 1,
            flags: 0),
        ModelProperty(
            id: const IdUid(10, 6741820363222805236),
            name: 'placeId',
            type: 11,
            flags: 520,
            indexId: const IdUid(7, 1064420527729153363),
            relationTarget: 'PlaceObjectBox'),
        ModelProperty(
            id: const IdUid(11, 1140062707292704486),
            name: 'dbEventResponse',
            type: 6,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[]),
  ModelEntity(
      id: const IdUid(8, 8260284028690414010),
      name: 'FileObjectBox',
      lastPropertyId: const IdUid(8, 7260582653143323093),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 2335305702816743115),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 3011657819478943446),
            name: 'profileId',
            type: 11,
            flags: 520,
            indexId: const IdUid(8, 9177186155225754923),
            relationTarget: 'ProfileObjectBox'),
        ModelProperty(
            id: const IdUid(3, 1201832899940448555),
            name: 'raw',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(4, 7603297721082900241),
            name: 'uri',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(5, 3278947112593950595),
            name: 'metadata',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(6, 1485069041920473709),
            name: 'timestamp',
            type: 10,
            flags: 0),
        ModelProperty(
            id: const IdUid(7, 8612298802788903967),
            name: 'thumbnail',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(8, 7260582653143323093),
            name: 'textSearch',
            type: 9,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[]),
  ModelEntity(
      id: const IdUid(9, 403312551324125741),
      name: 'FriendObjectBox',
      lastPropertyId: const IdUid(5, 2481157544733041625),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 8665275842723456890),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 3422617888357163551),
            name: 'profileId',
            type: 11,
            flags: 520,
            indexId: const IdUid(9, 8338379776768471975),
            relationTarget: 'ProfileObjectBox'),
        ModelProperty(
            id: const IdUid(3, 2593848120338283021),
            name: 'timestamp',
            type: 10,
            flags: 0),
        ModelProperty(
            id: const IdUid(4, 9054224669596596849),
            name: 'raw',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(5, 2481157544733041625),
            name: 'dbFriendType',
            type: 6,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[]),
  ModelEntity(
      id: const IdUid(10, 7190362612651975481),
      name: 'GroupObjectBox',
      lastPropertyId: const IdUid(7, 6572870298901418878),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 8008058406236511321),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 2540644958543447050),
            name: 'profileId',
            type: 11,
            flags: 520,
            indexId: const IdUid(10, 8030783165899465374),
            relationTarget: 'ProfileObjectBox'),
        ModelProperty(
            id: const IdUid(3, 999890852547287957),
            name: 'raw',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(4, 753173698521875469),
            name: 'name',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(5, 8416272210837621658),
            name: 'isUsers',
            type: 1,
            flags: 0),
        ModelProperty(
            id: const IdUid(6, 4960675307078241456),
            name: 'badge',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(7, 6572870298901418878),
            name: 'timestamp',
            type: 10,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[]),
  ModelEntity(
      id: const IdUid(11, 662540943555208646),
      name: 'ImageObjectBox',
      lastPropertyId: const IdUid(9, 6718249011278207858),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 3459944659949675069),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 4942906189085333219),
            name: 'profileId',
            type: 11,
            flags: 520,
            indexId: const IdUid(11, 9206997069833840718),
            relationTarget: 'ProfileObjectBox'),
        ModelProperty(
            id: const IdUid(3, 4222855325412571031),
            name: 'uri',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(4, 6907656523645024818),
            name: 'metadata',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(5, 787880086410387189),
            name: 'timestamp',
            type: 10,
            flags: 0),
        ModelProperty(
            id: const IdUid(6, 9171722370738779143),
            name: 'title',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(7, 1368926140075168645),
            name: 'description',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(8, 5418453689436655894),
            name: 'raw',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(9, 6718249011278207858),
            name: 'textSearch',
            type: 9,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[]),
  ModelEntity(
      id: const IdUid(12, 4418866182355057873),
      name: 'LinkObjectBox',
      lastPropertyId: const IdUid(8, 6270550563450456740),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 6428997282190872974),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 1693009769036127925),
            name: 'uri',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 1040125184763467415),
            name: 'metadata',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(4, 702539592961782229),
            name: 'timestamp',
            type: 10,
            flags: 0),
        ModelProperty(
            id: const IdUid(5, 6423658189065595737),
            name: 'profileId',
            type: 11,
            flags: 520,
            indexId: const IdUid(12, 3680778357802092087),
            relationTarget: 'ProfileObjectBox'),
        ModelProperty(
            id: const IdUid(6, 3142503911150956867),
            name: 'source',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(7, 7573048209219397524),
            name: 'raw',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(8, 6270550563450456740),
            name: 'textSearch',
            type: 9,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[]),
  ModelEntity(
      id: const IdUid(13, 5582754838903929128),
      name: 'PageObjectBox',
      lastPropertyId: const IdUid(6, 5657133952340291882),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 7003881051853520543),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 4776757387585307214),
            name: 'raw',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 6113228625908848469),
            name: 'profileId',
            type: 11,
            flags: 520,
            indexId: const IdUid(13, 8532547955415729703),
            relationTarget: 'ProfileObjectBox'),
        ModelProperty(
            id: const IdUid(4, 4171690034080032634),
            name: 'name',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(5, 5456766266973373634),
            name: 'isUsers',
            type: 1,
            flags: 0),
        ModelProperty(
            id: const IdUid(6, 5657133952340291882),
            name: 'uri',
            type: 9,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[]),
  ModelEntity(
      id: const IdUid(14, 878853417345363325),
      name: 'PersonObjectBox',
      lastPropertyId: const IdUid(5, 2073975316169718426),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 305721196977410147),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 1966072091086284665),
            name: 'profileId',
            type: 11,
            flags: 520,
            indexId: const IdUid(14, 3865470305132635004),
            relationTarget: 'ProfileObjectBox'),
        ModelProperty(
            id: const IdUid(3, 6764431032902822035),
            name: 'raw',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(4, 5209590533821004266),
            name: 'name',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(5, 2073975316169718426),
            name: 'uri',
            type: 9,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[]),
  ModelEntity(
      id: const IdUid(15, 5317834770752724073),
      name: 'PlaceObjectBox',
      lastPropertyId: const IdUid(7, 5267445521619070638),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 6167725588192108916),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 2577198836116484375),
            name: 'profileId',
            type: 11,
            flags: 520,
            indexId: const IdUid(15, 9114197409934089798),
            relationTarget: 'ProfileObjectBox'),
        ModelProperty(
            id: const IdUid(3, 5589635674715895711),
            name: 'raw',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(4, 8205267103461780527),
            name: 'name',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(5, 3362770763657524008),
            name: 'address',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(6, 3440840608155280531),
            name: 'coordinateId',
            type: 11,
            flags: 520,
            indexId: const IdUid(16, 5830489875511892143),
            relationTarget: 'CoordinateObjectBox'),
        ModelProperty(
            id: const IdUid(7, 5267445521619070638),
            name: 'uri',
            type: 9,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[]),
  ModelEntity(
      id: const IdUid(16, 6777739493226425985),
      name: 'PostEventObjectBox',
      lastPropertyId: const IdUid(3, 4512969167490359509),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 6015659967856815425),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 3586759461912000580),
            name: 'postId',
            type: 11,
            flags: 520,
            indexId: const IdUid(17, 6168688153569712149),
            relationTarget: 'PostObjectBox'),
        ModelProperty(
            id: const IdUid(3, 4512969167490359509),
            name: 'eventId',
            type: 11,
            flags: 520,
            indexId: const IdUid(18, 592968829540666267),
            relationTarget: 'EventObjectBox')
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[]),
  ModelEntity(
      id: const IdUid(17, 261878621414442105),
      name: 'PostGroupObjectBox',
      lastPropertyId: const IdUid(3, 2013698900669807408),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 5453249027785645226),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 7013938433570782375),
            name: 'postId',
            type: 11,
            flags: 520,
            indexId: const IdUid(19, 6262967830878055836),
            relationTarget: 'PostObjectBox'),
        ModelProperty(
            id: const IdUid(3, 2013698900669807408),
            name: 'groupId',
            type: 11,
            flags: 520,
            indexId: const IdUid(20, 1267121154745073668),
            relationTarget: 'GroupObjectBox')
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[]),
  ModelEntity(
      id: const IdUid(18, 3831902592278326677),
      name: 'PostLifeEventObjectBox',
      lastPropertyId: const IdUid(6, 8830578035959692048),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 7318867396919620716),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 8662102463049364101),
            name: 'raw',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 230563339251800692),
            name: 'profileId',
            type: 11,
            flags: 520,
            indexId: const IdUid(21, 5891294796837699625),
            relationTarget: 'ProfileObjectBox'),
        ModelProperty(
            id: const IdUid(4, 8824679836434553284),
            name: 'postId',
            type: 11,
            flags: 520,
            indexId: const IdUid(22, 1103263682453381655),
            relationTarget: 'PostObjectBox'),
        ModelProperty(
            id: const IdUid(5, 233107481649946560),
            name: 'title',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(6, 8830578035959692048),
            name: 'placeId',
            type: 11,
            flags: 520,
            indexId: const IdUid(23, 7120948373470774066),
            relationTarget: 'PlaceObjectBox')
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[]),
  ModelEntity(
      id: const IdUid(19, 8540148060114693146),
      name: 'PostObjectBox',
      lastPropertyId: const IdUid(9, 6179070229043156263),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 447254901163274080),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 6606833732216901443),
            name: 'raw',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 6955011165009131800),
            name: 'profileId',
            type: 11,
            flags: 520,
            indexId: const IdUid(24, 3957880061924335097),
            relationTarget: 'ProfileObjectBox'),
        ModelProperty(
            id: const IdUid(4, 7674123982435537273),
            name: 'timestamp',
            type: 10,
            flags: 0),
        ModelProperty(
            id: const IdUid(5, 2332665821222382596),
            name: 'description',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(6, 3717683563627183653),
            name: 'title',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(7, 7726706581266861851),
            name: 'isArchived',
            type: 1,
            flags: 0),
        ModelProperty(
            id: const IdUid(8, 7279892085726712766),
            name: 'metadata',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(9, 6179070229043156263),
            name: 'textSearch',
            type: 9,
            flags: 8,
            indexId: const IdUid(25, 8863607769030969010))
      ],
      relations: <ModelRelation>[
        ModelRelation(
            id: const IdUid(5, 2929097468604639530),
            name: 'images',
            targetId: const IdUid(11, 662540943555208646)),
        ModelRelation(
            id: const IdUid(6, 3082113286280918651),
            name: 'videos',
            targetId: const IdUid(25, 8250406239440631921)),
        ModelRelation(
            id: const IdUid(7, 6553682569812688823),
            name: 'files',
            targetId: const IdUid(8, 8260284028690414010)),
        ModelRelation(
            id: const IdUid(8, 3768156164964826448),
            name: 'links',
            targetId: const IdUid(12, 4418866182355057873)),
        ModelRelation(
            id: const IdUid(9, 897167521031104159),
            name: 'mentions',
            targetId: const IdUid(14, 878853417345363325)),
        ModelRelation(
            id: const IdUid(10, 5646280327835134881),
            name: 'tags',
            targetId: const IdUid(24, 4529004567764969329))
      ],
      backlinks: <ModelBacklink>[]),
  ModelEntity(
      id: const IdUid(20, 2465801385863721148),
      name: 'PostPollObjectBox',
      lastPropertyId: const IdUid(5, 6265727405642792292),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 3538753009751186991),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 864528451815596086),
            name: 'postId',
            type: 11,
            flags: 520,
            indexId: const IdUid(26, 288016459491240746),
            relationTarget: 'PostObjectBox'),
        ModelProperty(
            id: const IdUid(3, 7798906048353476718),
            name: 'isUsers',
            type: 1,
            flags: 0),
        ModelProperty(
            id: const IdUid(4, 2521954459230765627),
            name: 'options',
            type: 30,
            flags: 0),
        ModelProperty(
            id: const IdUid(5, 6265727405642792292),
            name: 'timestamp',
            type: 10,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[]),
  ModelEntity(
      id: const IdUid(21, 3027236502519165456),
      name: 'ProfileObjectBox',
      lastPropertyId: const IdUid(20, 3482275641323029538),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 2598886766325549945),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 5037134838182955105),
            name: 'serviceId',
            type: 11,
            flags: 520,
            indexId: const IdUid(27, 1152716874549054518),
            relationTarget: 'ServiceObjectBox'),
        ModelProperty(
            id: const IdUid(3, 2735931104825572195),
            name: 'uri',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(4, 39597176255091494),
            name: 'username',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(5, 6673550050611398575),
            name: 'fullName',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(6, 50713284312940453),
            name: 'profilePictureId',
            type: 11,
            flags: 520,
            indexId: const IdUid(28, 2034418086983342780),
            relationTarget: 'ImageObjectBox'),
        ModelProperty(
            id: const IdUid(7, 8140353349190387808),
            name: 'gender',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(8, 7862492252751462882),
            name: 'bio',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(9, 3360963638294269705),
            name: 'currentCity',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(10, 2025297670436332433),
            name: 'phoneNumbers',
            type: 30,
            flags: 0),
        ModelProperty(
            id: const IdUid(11, 6088634768808756986),
            name: 'isPhoneConfirmed',
            type: 1,
            flags: 0),
        ModelProperty(
            id: const IdUid(12, 6353804608658864339),
            name: 'createdTimestamp',
            type: 10,
            flags: 0),
        ModelProperty(
            id: const IdUid(13, 6623459596880123088),
            name: 'isPrivate',
            type: 1,
            flags: 0),
        ModelProperty(
            id: const IdUid(14, 1513765972499409017),
            name: 'websites',
            type: 30,
            flags: 0),
        ModelProperty(
            id: const IdUid(15, 1448061739943954617),
            name: 'dateOfBirth',
            type: 10,
            flags: 0),
        ModelProperty(
            id: const IdUid(16, 2683326264607614103),
            name: 'bloodInfo',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(17, 5576091031474603045),
            name: 'friendPeerGroup',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(18, 3924543777059438296),
            name: 'eligibility',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(19, 4531489118360172184),
            name: 'metadata',
            type: 30,
            flags: 0),
        ModelProperty(
            id: const IdUid(20, 3482275641323029538),
            name: 'raw',
            type: 9,
            flags: 0)
      ],
      relations: <ModelRelation>[
        ModelRelation(
            id: const IdUid(11, 9069079095407819588),
            name: 'emails',
            targetId: const IdUid(6, 1331698350771768634)),
        ModelRelation(
            id: const IdUid(12, 7130496865414357401),
            name: 'changes',
            targetId: const IdUid(3, 4520630462844098010))
      ],
      backlinks: <ModelBacklink>[]),
  ModelEntity(
      id: const IdUid(22, 8728972178620915137),
      name: 'ReactionObjectBox',
      lastPropertyId: const IdUid(3, 8502798925434442250),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 5240491093120679498),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 3533329082631169331),
            name: 'raw',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 8502798925434442250),
            name: 'reaction',
            type: 9,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[]),
  ModelEntity(
      id: const IdUid(23, 4873736195006131309),
      name: 'ServiceObjectBox',
      lastPropertyId: const IdUid(4, 5617515766622137040),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 5804196511060297000),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 765237824623094772),
            name: 'name',
            type: 9,
            flags: 2080,
            indexId: const IdUid(29, 2801004683058653616)),
        ModelProperty(
            id: const IdUid(3, 7645204737226887742),
            name: 'company',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(4, 5617515766622137040),
            name: 'image',
            type: 9,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[]),
  ModelEntity(
      id: const IdUid(24, 4529004567764969329),
      name: 'TagObjectBox',
      lastPropertyId: const IdUid(2, 8126492529576562182),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 8067431106959856286),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 8126492529576562182),
            name: 'name',
            type: 9,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[]),
  ModelEntity(
      id: const IdUid(25, 8250406239440631921),
      name: 'VideoObjectBox',
      lastPropertyId: const IdUid(10, 6505990081828828779),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 3856275367664062746),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 1045359493330682657),
            name: 'profileId',
            type: 11,
            flags: 520,
            indexId: const IdUid(30, 3300592703765813293),
            relationTarget: 'ProfileObjectBox'),
        ModelProperty(
            id: const IdUid(3, 7548369091272811049),
            name: 'uri',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(4, 3538430949058707916),
            name: 'metadata',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(5, 6162212723258925100),
            name: 'timestamp',
            type: 10,
            flags: 0),
        ModelProperty(
            id: const IdUid(6, 6478107973456118321),
            name: 'title',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(7, 2290525579816027443),
            name: 'description',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(8, 579186340415832745),
            name: 'thumbnail',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(9, 5019515502508254453),
            name: 'raw',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(10, 6505990081828828779),
            name: 'textSearch',
            type: 9,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[])
];

/// Open an ObjectBox store with the model declared in this file.
Future<Store> openStore(
        {String? directory,
        int? maxDBSizeInKB,
        int? fileMode,
        int? maxReaders,
        bool queriesCaseSensitiveDefault = true,
        String? macosApplicationGroup}) async =>
    Store(getObjectBoxModel(),
        directory: directory ?? (await defaultStoreDirectory()).path,
        maxDBSizeInKB: maxDBSizeInKB,
        fileMode: fileMode,
        maxReaders: maxReaders,
        queriesCaseSensitiveDefault: queriesCaseSensitiveDefault,
        macosApplicationGroup: macosApplicationGroup);

/// ObjectBox model definition, pass it to [Store] - Store(getObjectBoxModel())
ModelDefinition getObjectBoxModel() {
  final model = ModelInfo(
      entities: _entities,
      lastEntityId: const IdUid(25, 8250406239440631921),
      lastIndexId: const IdUid(30, 3300592703765813293),
      lastRelationId: const IdUid(12, 7130496865414357401),
      lastSequenceId: const IdUid(0, 0),
      retiredEntityUids: const [],
      retiredIndexUids: const [],
      retiredPropertyUids: const [],
      retiredRelationUids: const [],
      modelVersion: 5,
      modelVersionParserMinimum: 5,
      version: 1);

  final bindings = <Type, EntityDefinition>{
    ActivityObjectBox: EntityDefinition<ActivityObjectBox>(
        model: _entities[0],
        toOneRelations: (ActivityObjectBox object) => [],
        toManyRelations: (ActivityObjectBox object) => {},
        getId: (ActivityObjectBox object) => object.id,
        setId: (ActivityObjectBox object, int id) {
          object.id = id;
        },
        objectToFB: (ActivityObjectBox object, fb.Builder fbb) {
          final rawOffset = fbb.writeString(object.raw);
          fbb.startTable(4);
          fbb.addInt64(0, object.id);
          fbb.addOffset(1, rawOffset);
          fbb.addInt64(2, object.timestamp.millisecondsSinceEpoch);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = ActivityObjectBox(
              id: const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0),
              timestamp: DateTime.fromMillisecondsSinceEpoch(
                  const fb.Int64Reader().vTableGet(buffer, rootOffset, 8, 0)),
              raw:
                  const fb.StringReader().vTableGet(buffer, rootOffset, 6, ''));

          return object;
        }),
    AppSettingsObjectBox: EntityDefinition<AppSettingsObjectBox>(
        model: _entities[1],
        toOneRelations: (AppSettingsObjectBox object) => [],
        toManyRelations: (AppSettingsObjectBox object) => {},
        getId: (AppSettingsObjectBox object) => object.id,
        setId: (AppSettingsObjectBox object, int id) {
          object.id = id;
        },
        objectToFB: (AppSettingsObjectBox object, fb.Builder fbb) {
          fbb.startTable(3);
          fbb.addInt64(0, object.id);
          fbb.addBool(1, object.darkmode);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = AppSettingsObjectBox(
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0),
              const fb.BoolReader().vTableGet(buffer, rootOffset, 6, false));

          return object;
        }),
    ChangeObjectBox: EntityDefinition<ChangeObjectBox>(
        model: _entities[2],
        toOneRelations: (ChangeObjectBox object) => [],
        toManyRelations: (ChangeObjectBox object) => {},
        getId: (ChangeObjectBox object) => object.id,
        setId: (ChangeObjectBox object, int id) {
          object.id = id;
        },
        objectToFB: (ChangeObjectBox object, fb.Builder fbb) {
          final rawOffset = fbb.writeString(object.raw);
          final valueNameOffset = fbb.writeString(object.valueName);
          final previousValueOffset = fbb.writeString(object.previousValue);
          final newValueOffset = fbb.writeString(object.newValue);
          fbb.startTable(7);
          fbb.addInt64(0, object.id);
          fbb.addOffset(1, rawOffset);
          fbb.addOffset(2, valueNameOffset);
          fbb.addOffset(3, previousValueOffset);
          fbb.addOffset(4, newValueOffset);
          fbb.addInt64(5, object.timestamp.millisecondsSinceEpoch);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = ChangeObjectBox(
              id: const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0),
              raw: const fb.StringReader().vTableGet(buffer, rootOffset, 6, ''),
              valueName:
                  const fb.StringReader().vTableGet(buffer, rootOffset, 8, ''),
              previousValue:
                  const fb.StringReader().vTableGet(buffer, rootOffset, 10, ''),
              newValue:
                  const fb.StringReader().vTableGet(buffer, rootOffset, 12, ''),
              timestamp: DateTime.fromMillisecondsSinceEpoch(
                  const fb.Int64Reader().vTableGet(buffer, rootOffset, 14, 0)));

          return object;
        }),
    CommentObjectBox: EntityDefinition<CommentObjectBox>(
        model: _entities[3],
        toOneRelations: (CommentObjectBox object) =>
            [object.commented, object.group, object.event, object.profile],
        toManyRelations: (CommentObjectBox object) => {
              RelInfo<CommentObjectBox>.toMany(1, object.id): object.images,
              RelInfo<CommentObjectBox>.toMany(2, object.id): object.videos,
              RelInfo<CommentObjectBox>.toMany(3, object.id): object.files,
              RelInfo<CommentObjectBox>.toMany(4, object.id): object.links
            },
        getId: (CommentObjectBox object) => object.id,
        setId: (CommentObjectBox object, int id) {
          object.id = id;
        },
        objectToFB: (CommentObjectBox object, fb.Builder fbb) {
          final textOffset = fbb.writeString(object.text);
          final textSearchOffset = fbb.writeString(object.textSearch);
          fbb.startTable(9);
          fbb.addInt64(0, object.id);
          fbb.addInt64(1, object.commented.targetId);
          fbb.addOffset(2, textOffset);
          fbb.addInt64(3, object.timestamp.millisecondsSinceEpoch);
          fbb.addInt64(4, object.group.targetId);
          fbb.addInt64(5, object.event.targetId);
          fbb.addInt64(6, object.profile.targetId);
          fbb.addOffset(7, textSearchOffset);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = CommentObjectBox(
              id: const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0),
              text:
                  const fb.StringReader().vTableGet(buffer, rootOffset, 8, ''),
              timestamp: DateTime.fromMillisecondsSinceEpoch(
                  const fb.Int64Reader().vTableGet(buffer, rootOffset, 10, 0)))
            ..textSearch =
                const fb.StringReader().vTableGet(buffer, rootOffset, 18, '');
          object.commented.targetId =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 6, 0);
          object.commented.attach(store);
          object.group.targetId =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 12, 0);
          object.group.attach(store);
          object.event.targetId =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 14, 0);
          object.event.attach(store);
          object.profile.targetId =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 16, 0);
          object.profile.attach(store);
          InternalToManyAccess.setRelInfo(
              object.images,
              store,
              RelInfo<CommentObjectBox>.toMany(1, object.id),
              store.box<CommentObjectBox>());
          InternalToManyAccess.setRelInfo(
              object.videos,
              store,
              RelInfo<CommentObjectBox>.toMany(2, object.id),
              store.box<CommentObjectBox>());
          InternalToManyAccess.setRelInfo(
              object.files,
              store,
              RelInfo<CommentObjectBox>.toMany(3, object.id),
              store.box<CommentObjectBox>());
          InternalToManyAccess.setRelInfo(
              object.links,
              store,
              RelInfo<CommentObjectBox>.toMany(4, object.id),
              store.box<CommentObjectBox>());
          return object;
        }),
    CoordinateObjectBox: EntityDefinition<CoordinateObjectBox>(
        model: _entities[4],
        toOneRelations: (CoordinateObjectBox object) => [],
        toManyRelations: (CoordinateObjectBox object) => {},
        getId: (CoordinateObjectBox object) => object.id,
        setId: (CoordinateObjectBox object, int id) {
          object.id = id;
        },
        objectToFB: (CoordinateObjectBox object, fb.Builder fbb) {
          fbb.startTable(4);
          fbb.addInt64(0, object.id);
          fbb.addFloat64(1, object.longitude);
          fbb.addFloat64(2, object.latitude);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = CoordinateObjectBox(
              id: const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0),
              longitude:
                  const fb.Float64Reader().vTableGet(buffer, rootOffset, 6, 0),
              latitude:
                  const fb.Float64Reader().vTableGet(buffer, rootOffset, 8, 0));

          return object;
        }),
    EmailObjectBox: EntityDefinition<EmailObjectBox>(
        model: _entities[5],
        toOneRelations: (EmailObjectBox object) => [],
        toManyRelations: (EmailObjectBox object) => {},
        getId: (EmailObjectBox object) => object.id,
        setId: (EmailObjectBox object, int id) {
          object.id = id;
        },
        objectToFB: (EmailObjectBox object, fb.Builder fbb) {
          final rawOffset = fbb.writeString(object.raw);
          final emailOffset = fbb.writeString(object.email);
          fbb.startTable(5);
          fbb.addInt64(0, object.id);
          fbb.addOffset(1, rawOffset);
          fbb.addOffset(2, emailOffset);
          fbb.addBool(3, object.isCurrent);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = EmailObjectBox(
              id: const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0),
              raw: const fb.StringReader().vTableGet(buffer, rootOffset, 6, ''),
              email:
                  const fb.StringReader().vTableGet(buffer, rootOffset, 8, ''),
              isCurrent: const fb.BoolReader()
                  .vTableGet(buffer, rootOffset, 10, false));

          return object;
        }),
    EventObjectBox: EntityDefinition<EventObjectBox>(
        model: _entities[6],
        toOneRelations: (EventObjectBox object) =>
            [object.profile, object.place],
        toManyRelations: (EventObjectBox object) => {},
        getId: (EventObjectBox object) => object.id,
        setId: (EventObjectBox object, int id) {
          object.id = id;
        },
        objectToFB: (EventObjectBox object, fb.Builder fbb) {
          final rawOffset = fbb.writeString(object.raw);
          final nameOffset = fbb.writeString(object.name);
          final descriptionOffset = object.description == null
              ? null
              : fbb.writeString(object.description!);
          fbb.startTable(12);
          fbb.addInt64(0, object.id);
          fbb.addInt64(1, object.profile.targetId);
          fbb.addOffset(2, rawOffset);
          fbb.addOffset(3, nameOffset);
          fbb.addInt64(4, object.startTimestamp?.millisecondsSinceEpoch);
          fbb.addInt64(5, object.endTimestamp?.millisecondsSinceEpoch);
          fbb.addInt64(6, object.createdTimestamp?.millisecondsSinceEpoch);
          fbb.addOffset(7, descriptionOffset);
          fbb.addBool(8, object.isUsers);
          fbb.addInt64(9, object.place.targetId);
          fbb.addInt64(10, object.dbEventResponse);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);
          final startTimestampValue =
              const fb.Int64Reader().vTableGetNullable(buffer, rootOffset, 12);
          final endTimestampValue =
              const fb.Int64Reader().vTableGetNullable(buffer, rootOffset, 14);
          final createdTimestampValue =
              const fb.Int64Reader().vTableGetNullable(buffer, rootOffset, 16);
          final object = EventObjectBox(
              id: const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0),
              raw: const fb.StringReader().vTableGet(buffer, rootOffset, 8, ''),
              name:
                  const fb.StringReader().vTableGet(buffer, rootOffset, 10, ''),
              startTimestamp: startTimestampValue == null
                  ? null
                  : DateTime.fromMillisecondsSinceEpoch(startTimestampValue),
              endTimestamp: endTimestampValue == null
                  ? null
                  : DateTime.fromMillisecondsSinceEpoch(endTimestampValue),
              createdTimestamp: createdTimestampValue == null
                  ? null
                  : DateTime.fromMillisecondsSinceEpoch(createdTimestampValue),
              description: const fb.StringReader()
                  .vTableGetNullable(buffer, rootOffset, 18),
              isUsers: const fb.BoolReader()
                  .vTableGet(buffer, rootOffset, 20, false))
            ..dbEventResponse = const fb.Int64Reader()
                .vTableGetNullable(buffer, rootOffset, 24);
          object.profile.targetId =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 6, 0);
          object.profile.attach(store);
          object.place.targetId =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 22, 0);
          object.place.attach(store);
          return object;
        }),
    FileObjectBox: EntityDefinition<FileObjectBox>(
        model: _entities[7],
        toOneRelations: (FileObjectBox object) => [object.profile],
        toManyRelations: (FileObjectBox object) => {},
        getId: (FileObjectBox object) => object.id,
        setId: (FileObjectBox object, int id) {
          object.id = id;
        },
        objectToFB: (FileObjectBox object, fb.Builder fbb) {
          final rawOffset = fbb.writeString(object.raw);
          final uriOffset = fbb.writeString(object.uri);
          final metadataOffset = object.metadata == null
              ? null
              : fbb.writeString(object.metadata!);
          final thumbnailOffset = object.thumbnail == null
              ? null
              : fbb.writeString(object.thumbnail!);
          final textSearchOffset = fbb.writeString(object.textSearch);
          fbb.startTable(9);
          fbb.addInt64(0, object.id);
          fbb.addInt64(1, object.profile.targetId);
          fbb.addOffset(2, rawOffset);
          fbb.addOffset(3, uriOffset);
          fbb.addOffset(4, metadataOffset);
          fbb.addInt64(5, object.timestamp?.millisecondsSinceEpoch);
          fbb.addOffset(6, thumbnailOffset);
          fbb.addOffset(7, textSearchOffset);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);
          final timestampValue =
              const fb.Int64Reader().vTableGetNullable(buffer, rootOffset, 14);
          final object = FileObjectBox(
              id: const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0),
              raw: const fb.StringReader().vTableGet(buffer, rootOffset, 8, ''),
              uri:
                  const fb.StringReader().vTableGet(buffer, rootOffset, 10, ''),
              metadata: const fb.StringReader()
                  .vTableGetNullable(buffer, rootOffset, 12),
              timestamp: timestampValue == null
                  ? null
                  : DateTime.fromMillisecondsSinceEpoch(timestampValue),
              thumbnail: const fb.StringReader()
                  .vTableGetNullable(buffer, rootOffset, 16))
            ..textSearch =
                const fb.StringReader().vTableGet(buffer, rootOffset, 18, '');
          object.profile.targetId =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 6, 0);
          object.profile.attach(store);
          return object;
        }),
    FriendObjectBox: EntityDefinition<FriendObjectBox>(
        model: _entities[8],
        toOneRelations: (FriendObjectBox object) => [object.profile],
        toManyRelations: (FriendObjectBox object) => {},
        getId: (FriendObjectBox object) => object.id,
        setId: (FriendObjectBox object, int id) {
          object.id = id;
        },
        objectToFB: (FriendObjectBox object, fb.Builder fbb) {
          final rawOffset = fbb.writeString(object.raw);
          fbb.startTable(6);
          fbb.addInt64(0, object.id);
          fbb.addInt64(1, object.profile.targetId);
          fbb.addInt64(2, object.timestamp?.millisecondsSinceEpoch);
          fbb.addOffset(3, rawOffset);
          fbb.addInt64(4, object.dbFriendType);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);
          final timestampValue =
              const fb.Int64Reader().vTableGetNullable(buffer, rootOffset, 8);
          final object = FriendObjectBox(
              id: const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0),
              timestamp: timestampValue == null
                  ? null
                  : DateTime.fromMillisecondsSinceEpoch(timestampValue),
              raw:
                  const fb.StringReader().vTableGet(buffer, rootOffset, 10, ''))
            ..dbFriendType = const fb.Int64Reader()
                .vTableGetNullable(buffer, rootOffset, 12);
          object.profile.targetId =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 6, 0);
          object.profile.attach(store);
          return object;
        }),
    GroupObjectBox: EntityDefinition<GroupObjectBox>(
        model: _entities[9],
        toOneRelations: (GroupObjectBox object) => [object.profile],
        toManyRelations: (GroupObjectBox object) => {},
        getId: (GroupObjectBox object) => object.id,
        setId: (GroupObjectBox object, int id) {
          object.id = id;
        },
        objectToFB: (GroupObjectBox object, fb.Builder fbb) {
          final rawOffset = fbb.writeString(object.raw);
          final nameOffset = fbb.writeString(object.name);
          final badgeOffset =
              object.badge == null ? null : fbb.writeString(object.badge!);
          fbb.startTable(8);
          fbb.addInt64(0, object.id);
          fbb.addInt64(1, object.profile.targetId);
          fbb.addOffset(2, rawOffset);
          fbb.addOffset(3, nameOffset);
          fbb.addBool(4, object.isUsers);
          fbb.addOffset(5, badgeOffset);
          fbb.addInt64(6, object.timestamp?.millisecondsSinceEpoch);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);
          final timestampValue =
              const fb.Int64Reader().vTableGetNullable(buffer, rootOffset, 16);
          final object = GroupObjectBox(
              id: const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0),
              raw: const fb.StringReader().vTableGet(buffer, rootOffset, 8, ''),
              name:
                  const fb.StringReader().vTableGet(buffer, rootOffset, 10, ''),
              isUsers: const fb.BoolReader()
                  .vTableGet(buffer, rootOffset, 12, false),
              badge: const fb.StringReader()
                  .vTableGetNullable(buffer, rootOffset, 14),
              timestamp: timestampValue == null
                  ? null
                  : DateTime.fromMillisecondsSinceEpoch(timestampValue));
          object.profile.targetId =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 6, 0);
          object.profile.attach(store);
          return object;
        }),
    ImageObjectBox: EntityDefinition<ImageObjectBox>(
        model: _entities[10],
        toOneRelations: (ImageObjectBox object) => [object.profile],
        toManyRelations: (ImageObjectBox object) => {},
        getId: (ImageObjectBox object) => object.id,
        setId: (ImageObjectBox object, int id) {
          object.id = id;
        },
        objectToFB: (ImageObjectBox object, fb.Builder fbb) {
          final uriOffset = fbb.writeString(object.uri);
          final metadataOffset = object.metadata == null
              ? null
              : fbb.writeString(object.metadata!);
          final titleOffset =
              object.title == null ? null : fbb.writeString(object.title!);
          final descriptionOffset = object.description == null
              ? null
              : fbb.writeString(object.description!);
          final rawOffset = fbb.writeString(object.raw);
          final textSearchOffset = fbb.writeString(object.textSearch);
          fbb.startTable(10);
          fbb.addInt64(0, object.id);
          fbb.addInt64(1, object.profile.targetId);
          fbb.addOffset(2, uriOffset);
          fbb.addOffset(3, metadataOffset);
          fbb.addInt64(4, object.timestamp?.millisecondsSinceEpoch);
          fbb.addOffset(5, titleOffset);
          fbb.addOffset(6, descriptionOffset);
          fbb.addOffset(7, rawOffset);
          fbb.addOffset(8, textSearchOffset);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);
          final timestampValue =
              const fb.Int64Reader().vTableGetNullable(buffer, rootOffset, 12);
          final object = ImageObjectBox(
              id: const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0),
              uri: const fb.StringReader().vTableGet(buffer, rootOffset, 8, ''),
              metadata: const fb.StringReader()
                  .vTableGetNullable(buffer, rootOffset, 10),
              timestamp: timestampValue == null
                  ? null
                  : DateTime.fromMillisecondsSinceEpoch(timestampValue),
              title: const fb.StringReader()
                  .vTableGetNullable(buffer, rootOffset, 14),
              description: const fb.StringReader()
                  .vTableGetNullable(buffer, rootOffset, 16),
              raw:
                  const fb.StringReader().vTableGet(buffer, rootOffset, 18, ''))
            ..textSearch =
                const fb.StringReader().vTableGet(buffer, rootOffset, 20, '');
          object.profile.targetId =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 6, 0);
          object.profile.attach(store);
          return object;
        }),
    LinkObjectBox: EntityDefinition<LinkObjectBox>(
        model: _entities[11],
        toOneRelations: (LinkObjectBox object) => [object.profile],
        toManyRelations: (LinkObjectBox object) => {},
        getId: (LinkObjectBox object) => object.id,
        setId: (LinkObjectBox object, int id) {
          object.id = id;
        },
        objectToFB: (LinkObjectBox object, fb.Builder fbb) {
          final uriOffset = fbb.writeString(object.uri);
          final metadataOffset = object.metadata == null
              ? null
              : fbb.writeString(object.metadata!);
          final sourceOffset =
              object.source == null ? null : fbb.writeString(object.source!);
          final rawOffset = fbb.writeString(object.raw);
          final textSearchOffset = fbb.writeString(object.textSearch);
          fbb.startTable(9);
          fbb.addInt64(0, object.id);
          fbb.addOffset(1, uriOffset);
          fbb.addOffset(2, metadataOffset);
          fbb.addInt64(3, object.timestamp?.millisecondsSinceEpoch);
          fbb.addInt64(4, object.profile.targetId);
          fbb.addOffset(5, sourceOffset);
          fbb.addOffset(6, rawOffset);
          fbb.addOffset(7, textSearchOffset);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);
          final timestampValue =
              const fb.Int64Reader().vTableGetNullable(buffer, rootOffset, 10);
          final object = LinkObjectBox(
              id: const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0),
              uri: const fb.StringReader().vTableGet(buffer, rootOffset, 6, ''),
              metadata: const fb.StringReader()
                  .vTableGetNullable(buffer, rootOffset, 8),
              timestamp: timestampValue == null
                  ? null
                  : DateTime.fromMillisecondsSinceEpoch(timestampValue),
              source: const fb.StringReader()
                  .vTableGetNullable(buffer, rootOffset, 14),
              raw:
                  const fb.StringReader().vTableGet(buffer, rootOffset, 16, ''))
            ..textSearch =
                const fb.StringReader().vTableGet(buffer, rootOffset, 18, '');
          object.profile.targetId =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 12, 0);
          object.profile.attach(store);
          return object;
        }),
    PageObjectBox: EntityDefinition<PageObjectBox>(
        model: _entities[12],
        toOneRelations: (PageObjectBox object) => [object.profile],
        toManyRelations: (PageObjectBox object) => {},
        getId: (PageObjectBox object) => object.id,
        setId: (PageObjectBox object, int id) {
          object.id = id;
        },
        objectToFB: (PageObjectBox object, fb.Builder fbb) {
          final rawOffset = fbb.writeString(object.raw);
          final nameOffset = fbb.writeString(object.name);
          final uriOffset =
              object.uri == null ? null : fbb.writeString(object.uri!);
          fbb.startTable(7);
          fbb.addInt64(0, object.id);
          fbb.addOffset(1, rawOffset);
          fbb.addInt64(2, object.profile.targetId);
          fbb.addOffset(3, nameOffset);
          fbb.addBool(4, object.isUsers);
          fbb.addOffset(5, uriOffset);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = PageObjectBox(
              id: const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0),
              raw: const fb.StringReader().vTableGet(buffer, rootOffset, 6, ''),
              name:
                  const fb.StringReader().vTableGet(buffer, rootOffset, 10, ''),
              isUsers: const fb.BoolReader()
                  .vTableGet(buffer, rootOffset, 12, false),
              uri: const fb.StringReader()
                  .vTableGetNullable(buffer, rootOffset, 14));
          object.profile.targetId =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 8, 0);
          object.profile.attach(store);
          return object;
        }),
    PersonObjectBox: EntityDefinition<PersonObjectBox>(
        model: _entities[13],
        toOneRelations: (PersonObjectBox object) => [object.profile],
        toManyRelations: (PersonObjectBox object) => {},
        getId: (PersonObjectBox object) => object.id,
        setId: (PersonObjectBox object, int id) {
          object.id = id;
        },
        objectToFB: (PersonObjectBox object, fb.Builder fbb) {
          final rawOffset = fbb.writeString(object.raw);
          final nameOffset = fbb.writeString(object.name);
          final uriOffset =
              object.uri == null ? null : fbb.writeString(object.uri!);
          fbb.startTable(6);
          fbb.addInt64(0, object.id);
          fbb.addInt64(1, object.profile.targetId);
          fbb.addOffset(2, rawOffset);
          fbb.addOffset(3, nameOffset);
          fbb.addOffset(4, uriOffset);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = PersonObjectBox(
              id: const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0),
              raw: const fb.StringReader().vTableGet(buffer, rootOffset, 8, ''),
              name:
                  const fb.StringReader().vTableGet(buffer, rootOffset, 10, ''),
              uri: const fb.StringReader()
                  .vTableGetNullable(buffer, rootOffset, 12));
          object.profile.targetId =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 6, 0);
          object.profile.attach(store);
          return object;
        }),
    PlaceObjectBox: EntityDefinition<PlaceObjectBox>(
        model: _entities[14],
        toOneRelations: (PlaceObjectBox object) =>
            [object.profile, object.coordinate],
        toManyRelations: (PlaceObjectBox object) => {},
        getId: (PlaceObjectBox object) => object.id,
        setId: (PlaceObjectBox object, int id) {
          object.id = id;
        },
        objectToFB: (PlaceObjectBox object, fb.Builder fbb) {
          final rawOffset = fbb.writeString(object.raw);
          final nameOffset = fbb.writeString(object.name);
          final addressOffset =
              object.address == null ? null : fbb.writeString(object.address!);
          final uriOffset =
              object.uri == null ? null : fbb.writeString(object.uri!);
          fbb.startTable(8);
          fbb.addInt64(0, object.id);
          fbb.addInt64(1, object.profile.targetId);
          fbb.addOffset(2, rawOffset);
          fbb.addOffset(3, nameOffset);
          fbb.addOffset(4, addressOffset);
          fbb.addInt64(5, object.coordinate.targetId);
          fbb.addOffset(6, uriOffset);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = PlaceObjectBox(
              id: const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0),
              raw: const fb.StringReader().vTableGet(buffer, rootOffset, 8, ''),
              name:
                  const fb.StringReader().vTableGet(buffer, rootOffset, 10, ''),
              address: const fb.StringReader()
                  .vTableGetNullable(buffer, rootOffset, 12),
              uri: const fb.StringReader()
                  .vTableGetNullable(buffer, rootOffset, 16));
          object.profile.targetId =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 6, 0);
          object.profile.attach(store);
          object.coordinate.targetId =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 14, 0);
          object.coordinate.attach(store);
          return object;
        }),
    PostEventObjectBox: EntityDefinition<PostEventObjectBox>(
        model: _entities[15],
        toOneRelations: (PostEventObjectBox object) =>
            [object.post, object.event],
        toManyRelations: (PostEventObjectBox object) => {},
        getId: (PostEventObjectBox object) => object.id,
        setId: (PostEventObjectBox object, int id) {
          object.id = id;
        },
        objectToFB: (PostEventObjectBox object, fb.Builder fbb) {
          fbb.startTable(4);
          fbb.addInt64(0, object.id);
          fbb.addInt64(1, object.post.targetId);
          fbb.addInt64(2, object.event.targetId);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = PostEventObjectBox(
              id: const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0));
          object.post.targetId =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 6, 0);
          object.post.attach(store);
          object.event.targetId =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 8, 0);
          object.event.attach(store);
          return object;
        }),
    PostGroupObjectBox: EntityDefinition<PostGroupObjectBox>(
        model: _entities[16],
        toOneRelations: (PostGroupObjectBox object) =>
            [object.post, object.group],
        toManyRelations: (PostGroupObjectBox object) => {},
        getId: (PostGroupObjectBox object) => object.id,
        setId: (PostGroupObjectBox object, int id) {
          object.id = id;
        },
        objectToFB: (PostGroupObjectBox object, fb.Builder fbb) {
          fbb.startTable(4);
          fbb.addInt64(0, object.id);
          fbb.addInt64(1, object.post.targetId);
          fbb.addInt64(2, object.group.targetId);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = PostGroupObjectBox(
              id: const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0));
          object.post.targetId =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 6, 0);
          object.post.attach(store);
          object.group.targetId =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 8, 0);
          object.group.attach(store);
          return object;
        }),
    PostLifeEventObjectBox: EntityDefinition<PostLifeEventObjectBox>(
        model: _entities[17],
        toOneRelations: (PostLifeEventObjectBox object) =>
            [object.profile, object.post, object.place],
        toManyRelations: (PostLifeEventObjectBox object) => {},
        getId: (PostLifeEventObjectBox object) => object.id,
        setId: (PostLifeEventObjectBox object, int id) {
          object.id = id;
        },
        objectToFB: (PostLifeEventObjectBox object, fb.Builder fbb) {
          final rawOffset = fbb.writeString(object.raw);
          final titleOffset = fbb.writeString(object.title);
          fbb.startTable(7);
          fbb.addInt64(0, object.id);
          fbb.addOffset(1, rawOffset);
          fbb.addInt64(2, object.profile.targetId);
          fbb.addInt64(3, object.post.targetId);
          fbb.addOffset(4, titleOffset);
          fbb.addInt64(5, object.place.targetId);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = PostLifeEventObjectBox(
              id: const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0),
              raw: const fb.StringReader().vTableGet(buffer, rootOffset, 6, ''),
              title: const fb.StringReader()
                  .vTableGet(buffer, rootOffset, 12, ''));
          object.profile.targetId =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 8, 0);
          object.profile.attach(store);
          object.post.targetId =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 10, 0);
          object.post.attach(store);
          object.place.targetId =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 14, 0);
          object.place.attach(store);
          return object;
        }),
    PostObjectBox: EntityDefinition<PostObjectBox>(
        model: _entities[18],
        toOneRelations: (PostObjectBox object) => [object.profile],
        toManyRelations: (PostObjectBox object) => {
              RelInfo<PostObjectBox>.toMany(5, object.id): object.images,
              RelInfo<PostObjectBox>.toMany(6, object.id): object.videos,
              RelInfo<PostObjectBox>.toMany(7, object.id): object.files,
              RelInfo<PostObjectBox>.toMany(8, object.id): object.links,
              RelInfo<PostObjectBox>.toMany(9, object.id): object.mentions,
              RelInfo<PostObjectBox>.toMany(10, object.id): object.tags
            },
        getId: (PostObjectBox object) => object.id,
        setId: (PostObjectBox object, int id) {
          object.id = id;
        },
        objectToFB: (PostObjectBox object, fb.Builder fbb) {
          final rawOffset = fbb.writeString(object.raw);
          final descriptionOffset = object.description == null
              ? null
              : fbb.writeString(object.description!);
          final titleOffset =
              object.title == null ? null : fbb.writeString(object.title!);
          final metadataOffset = object.metadata == null
              ? null
              : fbb.writeString(object.metadata!);
          final textSearchOffset = fbb.writeString(object.textSearch);
          fbb.startTable(10);
          fbb.addInt64(0, object.id);
          fbb.addOffset(1, rawOffset);
          fbb.addInt64(2, object.profile.targetId);
          fbb.addInt64(3, object.timestamp.millisecondsSinceEpoch);
          fbb.addOffset(4, descriptionOffset);
          fbb.addOffset(5, titleOffset);
          fbb.addBool(6, object.isArchived);
          fbb.addOffset(7, metadataOffset);
          fbb.addOffset(8, textSearchOffset);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = PostObjectBox(
              id: const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0),
              raw: const fb.StringReader().vTableGet(buffer, rootOffset, 6, ''),
              timestamp: DateTime.fromMillisecondsSinceEpoch(
                  const fb.Int64Reader().vTableGet(buffer, rootOffset, 10, 0)),
              description: const fb.StringReader()
                  .vTableGetNullable(buffer, rootOffset, 12),
              title: const fb.StringReader()
                  .vTableGetNullable(buffer, rootOffset, 14),
              isArchived: const fb.BoolReader()
                  .vTableGetNullable(buffer, rootOffset, 16),
              metadata: const fb.StringReader()
                  .vTableGetNullable(buffer, rootOffset, 18))
            ..textSearch =
                const fb.StringReader().vTableGet(buffer, rootOffset, 20, '');
          object.profile.targetId =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 8, 0);
          object.profile.attach(store);
          InternalToManyAccess.setRelInfo(
              object.images,
              store,
              RelInfo<PostObjectBox>.toMany(5, object.id),
              store.box<PostObjectBox>());
          InternalToManyAccess.setRelInfo(
              object.videos,
              store,
              RelInfo<PostObjectBox>.toMany(6, object.id),
              store.box<PostObjectBox>());
          InternalToManyAccess.setRelInfo(
              object.files,
              store,
              RelInfo<PostObjectBox>.toMany(7, object.id),
              store.box<PostObjectBox>());
          InternalToManyAccess.setRelInfo(
              object.links,
              store,
              RelInfo<PostObjectBox>.toMany(8, object.id),
              store.box<PostObjectBox>());
          InternalToManyAccess.setRelInfo(
              object.mentions,
              store,
              RelInfo<PostObjectBox>.toMany(9, object.id),
              store.box<PostObjectBox>());
          InternalToManyAccess.setRelInfo(
              object.tags,
              store,
              RelInfo<PostObjectBox>.toMany(10, object.id),
              store.box<PostObjectBox>());
          return object;
        }),
    PostPollObjectBox: EntityDefinition<PostPollObjectBox>(
        model: _entities[19],
        toOneRelations: (PostPollObjectBox object) => [object.post],
        toManyRelations: (PostPollObjectBox object) => {},
        getId: (PostPollObjectBox object) => object.id,
        setId: (PostPollObjectBox object, int id) {
          object.id = id;
        },
        objectToFB: (PostPollObjectBox object, fb.Builder fbb) {
          final optionsOffset = object.options == null
              ? null
              : fbb.writeList(
                  object.options!.map(fbb.writeString).toList(growable: false));
          fbb.startTable(6);
          fbb.addInt64(0, object.id);
          fbb.addInt64(1, object.post.targetId);
          fbb.addBool(2, object.isUsers);
          fbb.addOffset(3, optionsOffset);
          fbb.addInt64(4, object.timestamp?.millisecondsSinceEpoch);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);
          final timestampValue =
              const fb.Int64Reader().vTableGetNullable(buffer, rootOffset, 12);
          final object = PostPollObjectBox(
              id: const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0),
              isUsers:
                  const fb.BoolReader().vTableGet(buffer, rootOffset, 8, false),
              options:
                  const fb.ListReader<String>(fb.StringReader(), lazy: false)
                      .vTableGetNullable(buffer, rootOffset, 10),
              timestamp: timestampValue == null
                  ? null
                  : DateTime.fromMillisecondsSinceEpoch(timestampValue));
          object.post.targetId =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 6, 0);
          object.post.attach(store);
          return object;
        }),
    ProfileObjectBox: EntityDefinition<ProfileObjectBox>(
        model: _entities[20],
        toOneRelations: (ProfileObjectBox object) =>
            [object.service, object.profilePicture],
        toManyRelations: (ProfileObjectBox object) => {
              RelInfo<ProfileObjectBox>.toMany(11, object.id): object.emails,
              RelInfo<ProfileObjectBox>.toMany(12, object.id): object.changes
            },
        getId: (ProfileObjectBox object) => object.id,
        setId: (ProfileObjectBox object, int id) {
          object.id = id;
        },
        objectToFB: (ProfileObjectBox object, fb.Builder fbb) {
          final uriOffset = fbb.writeString(object.uri);
          final usernameOffset = object.username == null
              ? null
              : fbb.writeString(object.username!);
          final fullNameOffset = fbb.writeString(object.fullName);
          final genderOffset =
              object.gender == null ? null : fbb.writeString(object.gender!);
          final bioOffset =
              object.bio == null ? null : fbb.writeString(object.bio!);
          final currentCityOffset = object.currentCity == null
              ? null
              : fbb.writeString(object.currentCity!);
          final phoneNumbersOffset = object.phoneNumbers == null
              ? null
              : fbb.writeList(object.phoneNumbers!
                  .map(fbb.writeString)
                  .toList(growable: false));
          final websitesOffset = object.websites == null
              ? null
              : fbb.writeList(object.websites!
                  .map(fbb.writeString)
                  .toList(growable: false));
          final bloodInfoOffset = object.bloodInfo == null
              ? null
              : fbb.writeString(object.bloodInfo!);
          final friendPeerGroupOffset = object.friendPeerGroup == null
              ? null
              : fbb.writeString(object.friendPeerGroup!);
          final eligibilityOffset = object.eligibility == null
              ? null
              : fbb.writeString(object.eligibility!);
          final metadataOffset = object.metadata == null
              ? null
              : fbb.writeList(object.metadata!
                  .map(fbb.writeString)
                  .toList(growable: false));
          final rawOffset = fbb.writeString(object.raw);
          fbb.startTable(21);
          fbb.addInt64(0, object.id);
          fbb.addInt64(1, object.service.targetId);
          fbb.addOffset(2, uriOffset);
          fbb.addOffset(3, usernameOffset);
          fbb.addOffset(4, fullNameOffset);
          fbb.addInt64(5, object.profilePicture.targetId);
          fbb.addOffset(6, genderOffset);
          fbb.addOffset(7, bioOffset);
          fbb.addOffset(8, currentCityOffset);
          fbb.addOffset(9, phoneNumbersOffset);
          fbb.addBool(10, object.isPhoneConfirmed);
          fbb.addInt64(11, object.createdTimestamp.millisecondsSinceEpoch);
          fbb.addBool(12, object.isPrivate);
          fbb.addOffset(13, websitesOffset);
          fbb.addInt64(14, object.dateOfBirth?.millisecondsSinceEpoch);
          fbb.addOffset(15, bloodInfoOffset);
          fbb.addOffset(16, friendPeerGroupOffset);
          fbb.addOffset(17, eligibilityOffset);
          fbb.addOffset(18, metadataOffset);
          fbb.addOffset(19, rawOffset);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);
          final dateOfBirthValue =
              const fb.Int64Reader().vTableGetNullable(buffer, rootOffset, 32);
          final object = ProfileObjectBox(
              id: const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0),
              uri: const fb.StringReader().vTableGet(buffer, rootOffset, 8, ''),
              username: const fb.StringReader()
                  .vTableGetNullable(buffer, rootOffset, 10),
              fullName:
                  const fb.StringReader().vTableGet(buffer, rootOffset, 12, ''),
              gender: const fb.StringReader()
                  .vTableGetNullable(buffer, rootOffset, 16),
              bio: const fb.StringReader()
                  .vTableGetNullable(buffer, rootOffset, 18),
              currentCity: const fb.StringReader()
                  .vTableGetNullable(buffer, rootOffset, 20),
              phoneNumbers:
                  const fb.ListReader<String>(fb.StringReader(), lazy: false)
                      .vTableGetNullable(buffer, rootOffset, 22),
              isPhoneConfirmed: const fb.BoolReader()
                  .vTableGetNullable(buffer, rootOffset, 24),
              createdTimestamp: DateTime.fromMillisecondsSinceEpoch(
                  const fb.Int64Reader().vTableGet(buffer, rootOffset, 26, 0)),
              isPrivate: const fb.BoolReader()
                  .vTableGetNullable(buffer, rootOffset, 28),
              websites: const fb.ListReader<String>(fb.StringReader(), lazy: false)
                  .vTableGetNullable(buffer, rootOffset, 30),
              dateOfBirth: dateOfBirthValue == null ? null : DateTime.fromMillisecondsSinceEpoch(dateOfBirthValue),
              bloodInfo: const fb.StringReader().vTableGetNullable(buffer, rootOffset, 34),
              friendPeerGroup: const fb.StringReader().vTableGetNullable(buffer, rootOffset, 36),
              eligibility: const fb.StringReader().vTableGetNullable(buffer, rootOffset, 38),
              metadata: const fb.ListReader<String>(fb.StringReader(), lazy: false).vTableGetNullable(buffer, rootOffset, 40),
              raw: const fb.StringReader().vTableGet(buffer, rootOffset, 42, ''));
          object.service.targetId =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 6, 0);
          object.service.attach(store);
          object.profilePicture.targetId =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 14, 0);
          object.profilePicture.attach(store);
          InternalToManyAccess.setRelInfo(
              object.emails,
              store,
              RelInfo<ProfileObjectBox>.toMany(11, object.id),
              store.box<ProfileObjectBox>());
          InternalToManyAccess.setRelInfo(
              object.changes,
              store,
              RelInfo<ProfileObjectBox>.toMany(12, object.id),
              store.box<ProfileObjectBox>());
          return object;
        }),
    ReactionObjectBox: EntityDefinition<ReactionObjectBox>(
        model: _entities[21],
        toOneRelations: (ReactionObjectBox object) => [],
        toManyRelations: (ReactionObjectBox object) => {},
        getId: (ReactionObjectBox object) => object.id,
        setId: (ReactionObjectBox object, int id) {
          object.id = id;
        },
        objectToFB: (ReactionObjectBox object, fb.Builder fbb) {
          final rawOffset = fbb.writeString(object.raw);
          final reactionOffset = fbb.writeString(object.reaction);
          fbb.startTable(4);
          fbb.addInt64(0, object.id);
          fbb.addOffset(1, rawOffset);
          fbb.addOffset(2, reactionOffset);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = ReactionObjectBox(
              id: const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0),
              raw: const fb.StringReader().vTableGet(buffer, rootOffset, 6, ''),
              reaction:
                  const fb.StringReader().vTableGet(buffer, rootOffset, 8, ''));

          return object;
        }),
    ServiceObjectBox: EntityDefinition<ServiceObjectBox>(
        model: _entities[22],
        toOneRelations: (ServiceObjectBox object) => [],
        toManyRelations: (ServiceObjectBox object) => {},
        getId: (ServiceObjectBox object) => object.id,
        setId: (ServiceObjectBox object, int id) {
          object.id = id;
        },
        objectToFB: (ServiceObjectBox object, fb.Builder fbb) {
          final nameOffset = fbb.writeString(object.name);
          final companyOffset = fbb.writeString(object.company);
          final imageOffset = fbb.writeString(object.image);
          fbb.startTable(5);
          fbb.addInt64(0, object.id);
          fbb.addOffset(1, nameOffset);
          fbb.addOffset(2, companyOffset);
          fbb.addOffset(3, imageOffset);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = ServiceObjectBox(
              id: const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0),
              name:
                  const fb.StringReader().vTableGet(buffer, rootOffset, 6, ''),
              company:
                  const fb.StringReader().vTableGet(buffer, rootOffset, 8, ''),
              image: const fb.StringReader()
                  .vTableGet(buffer, rootOffset, 10, ''));

          return object;
        }),
    TagObjectBox: EntityDefinition<TagObjectBox>(
        model: _entities[23],
        toOneRelations: (TagObjectBox object) => [],
        toManyRelations: (TagObjectBox object) => {},
        getId: (TagObjectBox object) => object.id,
        setId: (TagObjectBox object, int id) {
          object.id = id;
        },
        objectToFB: (TagObjectBox object, fb.Builder fbb) {
          final nameOffset = fbb.writeString(object.name);
          fbb.startTable(3);
          fbb.addInt64(0, object.id);
          fbb.addOffset(1, nameOffset);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = TagObjectBox(
              id: const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0),
              name:
                  const fb.StringReader().vTableGet(buffer, rootOffset, 6, ''));

          return object;
        }),
    VideoObjectBox: EntityDefinition<VideoObjectBox>(
        model: _entities[24],
        toOneRelations: (VideoObjectBox object) => [object.profile],
        toManyRelations: (VideoObjectBox object) => {},
        getId: (VideoObjectBox object) => object.id,
        setId: (VideoObjectBox object, int id) {
          object.id = id;
        },
        objectToFB: (VideoObjectBox object, fb.Builder fbb) {
          final uriOffset = fbb.writeString(object.uri);
          final metadataOffset = object.metadata == null
              ? null
              : fbb.writeString(object.metadata!);
          final titleOffset =
              object.title == null ? null : fbb.writeString(object.title!);
          final descriptionOffset = object.description == null
              ? null
              : fbb.writeString(object.description!);
          final thumbnailOffset = object.thumbnail == null
              ? null
              : fbb.writeString(object.thumbnail!);
          final rawOffset = fbb.writeString(object.raw);
          final textSearchOffset = fbb.writeString(object.textSearch);
          fbb.startTable(11);
          fbb.addInt64(0, object.id);
          fbb.addInt64(1, object.profile.targetId);
          fbb.addOffset(2, uriOffset);
          fbb.addOffset(3, metadataOffset);
          fbb.addInt64(4, object.timestamp?.millisecondsSinceEpoch);
          fbb.addOffset(5, titleOffset);
          fbb.addOffset(6, descriptionOffset);
          fbb.addOffset(7, thumbnailOffset);
          fbb.addOffset(8, rawOffset);
          fbb.addOffset(9, textSearchOffset);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);
          final timestampValue =
              const fb.Int64Reader().vTableGetNullable(buffer, rootOffset, 12);
          final object = VideoObjectBox(
              id: const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0),
              uri: const fb.StringReader().vTableGet(buffer, rootOffset, 8, ''),
              metadata: const fb.StringReader()
                  .vTableGetNullable(buffer, rootOffset, 10),
              timestamp: timestampValue == null
                  ? null
                  : DateTime.fromMillisecondsSinceEpoch(timestampValue),
              title: const fb.StringReader()
                  .vTableGetNullable(buffer, rootOffset, 14),
              description: const fb.StringReader()
                  .vTableGetNullable(buffer, rootOffset, 16),
              thumbnail: const fb.StringReader()
                  .vTableGetNullable(buffer, rootOffset, 18),
              raw:
                  const fb.StringReader().vTableGet(buffer, rootOffset, 20, ''))
            ..textSearch =
                const fb.StringReader().vTableGet(buffer, rootOffset, 22, '');
          object.profile.targetId =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 6, 0);
          object.profile.attach(store);
          return object;
        })
  };

  return ModelDefinition(model, bindings);
}

/// [ActivityObjectBox] entity fields to define ObjectBox queries.
class ActivityObjectBox_ {
  /// see [ActivityObjectBox.id]
  static final id =
      QueryIntegerProperty<ActivityObjectBox>(_entities[0].properties[0]);

  /// see [ActivityObjectBox.raw]
  static final raw =
      QueryStringProperty<ActivityObjectBox>(_entities[0].properties[1]);

  /// see [ActivityObjectBox.timestamp]
  static final timestamp =
      QueryIntegerProperty<ActivityObjectBox>(_entities[0].properties[2]);
}

/// [AppSettingsObjectBox] entity fields to define ObjectBox queries.
class AppSettingsObjectBox_ {
  /// see [AppSettingsObjectBox.id]
  static final id =
      QueryIntegerProperty<AppSettingsObjectBox>(_entities[1].properties[0]);

  /// see [AppSettingsObjectBox.darkmode]
  static final darkmode =
      QueryBooleanProperty<AppSettingsObjectBox>(_entities[1].properties[1]);
}

/// [ChangeObjectBox] entity fields to define ObjectBox queries.
class ChangeObjectBox_ {
  /// see [ChangeObjectBox.id]
  static final id =
      QueryIntegerProperty<ChangeObjectBox>(_entities[2].properties[0]);

  /// see [ChangeObjectBox.raw]
  static final raw =
      QueryStringProperty<ChangeObjectBox>(_entities[2].properties[1]);

  /// see [ChangeObjectBox.valueName]
  static final valueName =
      QueryStringProperty<ChangeObjectBox>(_entities[2].properties[2]);

  /// see [ChangeObjectBox.previousValue]
  static final previousValue =
      QueryStringProperty<ChangeObjectBox>(_entities[2].properties[3]);

  /// see [ChangeObjectBox.newValue]
  static final newValue =
      QueryStringProperty<ChangeObjectBox>(_entities[2].properties[4]);

  /// see [ChangeObjectBox.timestamp]
  static final timestamp =
      QueryIntegerProperty<ChangeObjectBox>(_entities[2].properties[5]);
}

/// [CommentObjectBox] entity fields to define ObjectBox queries.
class CommentObjectBox_ {
  /// see [CommentObjectBox.id]
  static final id =
      QueryIntegerProperty<CommentObjectBox>(_entities[3].properties[0]);

  /// see [CommentObjectBox.commented]
  static final commented =
      QueryRelationToOne<CommentObjectBox, PersonObjectBox>(
          _entities[3].properties[1]);

  /// see [CommentObjectBox.text]
  static final text =
      QueryStringProperty<CommentObjectBox>(_entities[3].properties[2]);

  /// see [CommentObjectBox.timestamp]
  static final timestamp =
      QueryIntegerProperty<CommentObjectBox>(_entities[3].properties[3]);

  /// see [CommentObjectBox.group]
  static final group = QueryRelationToOne<CommentObjectBox, GroupObjectBox>(
      _entities[3].properties[4]);

  /// see [CommentObjectBox.event]
  static final event = QueryRelationToOne<CommentObjectBox, EventObjectBox>(
      _entities[3].properties[5]);

  /// see [CommentObjectBox.profile]
  static final profile = QueryRelationToOne<CommentObjectBox, ProfileObjectBox>(
      _entities[3].properties[6]);

  /// see [CommentObjectBox.textSearch]
  static final textSearch =
      QueryStringProperty<CommentObjectBox>(_entities[3].properties[7]);

  /// see [CommentObjectBox.images]
  static final images = QueryRelationToMany<CommentObjectBox, ImageObjectBox>(
      _entities[3].relations[0]);

  /// see [CommentObjectBox.videos]
  static final videos = QueryRelationToMany<CommentObjectBox, VideoObjectBox>(
      _entities[3].relations[1]);

  /// see [CommentObjectBox.files]
  static final files = QueryRelationToMany<CommentObjectBox, FileObjectBox>(
      _entities[3].relations[2]);

  /// see [CommentObjectBox.links]
  static final links = QueryRelationToMany<CommentObjectBox, LinkObjectBox>(
      _entities[3].relations[3]);
}

/// [CoordinateObjectBox] entity fields to define ObjectBox queries.
class CoordinateObjectBox_ {
  /// see [CoordinateObjectBox.id]
  static final id =
      QueryIntegerProperty<CoordinateObjectBox>(_entities[4].properties[0]);

  /// see [CoordinateObjectBox.longitude]
  static final longitude =
      QueryDoubleProperty<CoordinateObjectBox>(_entities[4].properties[1]);

  /// see [CoordinateObjectBox.latitude]
  static final latitude =
      QueryDoubleProperty<CoordinateObjectBox>(_entities[4].properties[2]);
}

/// [EmailObjectBox] entity fields to define ObjectBox queries.
class EmailObjectBox_ {
  /// see [EmailObjectBox.id]
  static final id =
      QueryIntegerProperty<EmailObjectBox>(_entities[5].properties[0]);

  /// see [EmailObjectBox.raw]
  static final raw =
      QueryStringProperty<EmailObjectBox>(_entities[5].properties[1]);

  /// see [EmailObjectBox.email]
  static final email =
      QueryStringProperty<EmailObjectBox>(_entities[5].properties[2]);

  /// see [EmailObjectBox.isCurrent]
  static final isCurrent =
      QueryBooleanProperty<EmailObjectBox>(_entities[5].properties[3]);
}

/// [EventObjectBox] entity fields to define ObjectBox queries.
class EventObjectBox_ {
  /// see [EventObjectBox.id]
  static final id =
      QueryIntegerProperty<EventObjectBox>(_entities[6].properties[0]);

  /// see [EventObjectBox.profile]
  static final profile = QueryRelationToOne<EventObjectBox, ProfileObjectBox>(
      _entities[6].properties[1]);

  /// see [EventObjectBox.raw]
  static final raw =
      QueryStringProperty<EventObjectBox>(_entities[6].properties[2]);

  /// see [EventObjectBox.name]
  static final name =
      QueryStringProperty<EventObjectBox>(_entities[6].properties[3]);

  /// see [EventObjectBox.startTimestamp]
  static final startTimestamp =
      QueryIntegerProperty<EventObjectBox>(_entities[6].properties[4]);

  /// see [EventObjectBox.endTimestamp]
  static final endTimestamp =
      QueryIntegerProperty<EventObjectBox>(_entities[6].properties[5]);

  /// see [EventObjectBox.createdTimestamp]
  static final createdTimestamp =
      QueryIntegerProperty<EventObjectBox>(_entities[6].properties[6]);

  /// see [EventObjectBox.description]
  static final description =
      QueryStringProperty<EventObjectBox>(_entities[6].properties[7]);

  /// see [EventObjectBox.isUsers]
  static final isUsers =
      QueryBooleanProperty<EventObjectBox>(_entities[6].properties[8]);

  /// see [EventObjectBox.place]
  static final place = QueryRelationToOne<EventObjectBox, PlaceObjectBox>(
      _entities[6].properties[9]);

  /// see [EventObjectBox.dbEventResponse]
  static final dbEventResponse =
      QueryIntegerProperty<EventObjectBox>(_entities[6].properties[10]);
}

/// [FileObjectBox] entity fields to define ObjectBox queries.
class FileObjectBox_ {
  /// see [FileObjectBox.id]
  static final id =
      QueryIntegerProperty<FileObjectBox>(_entities[7].properties[0]);

  /// see [FileObjectBox.profile]
  static final profile = QueryRelationToOne<FileObjectBox, ProfileObjectBox>(
      _entities[7].properties[1]);

  /// see [FileObjectBox.raw]
  static final raw =
      QueryStringProperty<FileObjectBox>(_entities[7].properties[2]);

  /// see [FileObjectBox.uri]
  static final uri =
      QueryStringProperty<FileObjectBox>(_entities[7].properties[3]);

  /// see [FileObjectBox.metadata]
  static final metadata =
      QueryStringProperty<FileObjectBox>(_entities[7].properties[4]);

  /// see [FileObjectBox.timestamp]
  static final timestamp =
      QueryIntegerProperty<FileObjectBox>(_entities[7].properties[5]);

  /// see [FileObjectBox.thumbnail]
  static final thumbnail =
      QueryStringProperty<FileObjectBox>(_entities[7].properties[6]);

  /// see [FileObjectBox.textSearch]
  static final textSearch =
      QueryStringProperty<FileObjectBox>(_entities[7].properties[7]);
}

/// [FriendObjectBox] entity fields to define ObjectBox queries.
class FriendObjectBox_ {
  /// see [FriendObjectBox.id]
  static final id =
      QueryIntegerProperty<FriendObjectBox>(_entities[8].properties[0]);

  /// see [FriendObjectBox.profile]
  static final profile = QueryRelationToOne<FriendObjectBox, ProfileObjectBox>(
      _entities[8].properties[1]);

  /// see [FriendObjectBox.timestamp]
  static final timestamp =
      QueryIntegerProperty<FriendObjectBox>(_entities[8].properties[2]);

  /// see [FriendObjectBox.raw]
  static final raw =
      QueryStringProperty<FriendObjectBox>(_entities[8].properties[3]);

  /// see [FriendObjectBox.dbFriendType]
  static final dbFriendType =
      QueryIntegerProperty<FriendObjectBox>(_entities[8].properties[4]);
}

/// [GroupObjectBox] entity fields to define ObjectBox queries.
class GroupObjectBox_ {
  /// see [GroupObjectBox.id]
  static final id =
      QueryIntegerProperty<GroupObjectBox>(_entities[9].properties[0]);

  /// see [GroupObjectBox.profile]
  static final profile = QueryRelationToOne<GroupObjectBox, ProfileObjectBox>(
      _entities[9].properties[1]);

  /// see [GroupObjectBox.raw]
  static final raw =
      QueryStringProperty<GroupObjectBox>(_entities[9].properties[2]);

  /// see [GroupObjectBox.name]
  static final name =
      QueryStringProperty<GroupObjectBox>(_entities[9].properties[3]);

  /// see [GroupObjectBox.isUsers]
  static final isUsers =
      QueryBooleanProperty<GroupObjectBox>(_entities[9].properties[4]);

  /// see [GroupObjectBox.badge]
  static final badge =
      QueryStringProperty<GroupObjectBox>(_entities[9].properties[5]);

  /// see [GroupObjectBox.timestamp]
  static final timestamp =
      QueryIntegerProperty<GroupObjectBox>(_entities[9].properties[6]);
}

/// [ImageObjectBox] entity fields to define ObjectBox queries.
class ImageObjectBox_ {
  /// see [ImageObjectBox.id]
  static final id =
      QueryIntegerProperty<ImageObjectBox>(_entities[10].properties[0]);

  /// see [ImageObjectBox.profile]
  static final profile = QueryRelationToOne<ImageObjectBox, ProfileObjectBox>(
      _entities[10].properties[1]);

  /// see [ImageObjectBox.uri]
  static final uri =
      QueryStringProperty<ImageObjectBox>(_entities[10].properties[2]);

  /// see [ImageObjectBox.metadata]
  static final metadata =
      QueryStringProperty<ImageObjectBox>(_entities[10].properties[3]);

  /// see [ImageObjectBox.timestamp]
  static final timestamp =
      QueryIntegerProperty<ImageObjectBox>(_entities[10].properties[4]);

  /// see [ImageObjectBox.title]
  static final title =
      QueryStringProperty<ImageObjectBox>(_entities[10].properties[5]);

  /// see [ImageObjectBox.description]
  static final description =
      QueryStringProperty<ImageObjectBox>(_entities[10].properties[6]);

  /// see [ImageObjectBox.raw]
  static final raw =
      QueryStringProperty<ImageObjectBox>(_entities[10].properties[7]);

  /// see [ImageObjectBox.textSearch]
  static final textSearch =
      QueryStringProperty<ImageObjectBox>(_entities[10].properties[8]);
}

/// [LinkObjectBox] entity fields to define ObjectBox queries.
class LinkObjectBox_ {
  /// see [LinkObjectBox.id]
  static final id =
      QueryIntegerProperty<LinkObjectBox>(_entities[11].properties[0]);

  /// see [LinkObjectBox.uri]
  static final uri =
      QueryStringProperty<LinkObjectBox>(_entities[11].properties[1]);

  /// see [LinkObjectBox.metadata]
  static final metadata =
      QueryStringProperty<LinkObjectBox>(_entities[11].properties[2]);

  /// see [LinkObjectBox.timestamp]
  static final timestamp =
      QueryIntegerProperty<LinkObjectBox>(_entities[11].properties[3]);

  /// see [LinkObjectBox.profile]
  static final profile = QueryRelationToOne<LinkObjectBox, ProfileObjectBox>(
      _entities[11].properties[4]);

  /// see [LinkObjectBox.source]
  static final source =
      QueryStringProperty<LinkObjectBox>(_entities[11].properties[5]);

  /// see [LinkObjectBox.raw]
  static final raw =
      QueryStringProperty<LinkObjectBox>(_entities[11].properties[6]);

  /// see [LinkObjectBox.textSearch]
  static final textSearch =
      QueryStringProperty<LinkObjectBox>(_entities[11].properties[7]);
}

/// [PageObjectBox] entity fields to define ObjectBox queries.
class PageObjectBox_ {
  /// see [PageObjectBox.id]
  static final id =
      QueryIntegerProperty<PageObjectBox>(_entities[12].properties[0]);

  /// see [PageObjectBox.raw]
  static final raw =
      QueryStringProperty<PageObjectBox>(_entities[12].properties[1]);

  /// see [PageObjectBox.profile]
  static final profile = QueryRelationToOne<PageObjectBox, ProfileObjectBox>(
      _entities[12].properties[2]);

  /// see [PageObjectBox.name]
  static final name =
      QueryStringProperty<PageObjectBox>(_entities[12].properties[3]);

  /// see [PageObjectBox.isUsers]
  static final isUsers =
      QueryBooleanProperty<PageObjectBox>(_entities[12].properties[4]);

  /// see [PageObjectBox.uri]
  static final uri =
      QueryStringProperty<PageObjectBox>(_entities[12].properties[5]);
}

/// [PersonObjectBox] entity fields to define ObjectBox queries.
class PersonObjectBox_ {
  /// see [PersonObjectBox.id]
  static final id =
      QueryIntegerProperty<PersonObjectBox>(_entities[13].properties[0]);

  /// see [PersonObjectBox.profile]
  static final profile = QueryRelationToOne<PersonObjectBox, ProfileObjectBox>(
      _entities[13].properties[1]);

  /// see [PersonObjectBox.raw]
  static final raw =
      QueryStringProperty<PersonObjectBox>(_entities[13].properties[2]);

  /// see [PersonObjectBox.name]
  static final name =
      QueryStringProperty<PersonObjectBox>(_entities[13].properties[3]);

  /// see [PersonObjectBox.uri]
  static final uri =
      QueryStringProperty<PersonObjectBox>(_entities[13].properties[4]);
}

/// [PlaceObjectBox] entity fields to define ObjectBox queries.
class PlaceObjectBox_ {
  /// see [PlaceObjectBox.id]
  static final id =
      QueryIntegerProperty<PlaceObjectBox>(_entities[14].properties[0]);

  /// see [PlaceObjectBox.profile]
  static final profile = QueryRelationToOne<PlaceObjectBox, ProfileObjectBox>(
      _entities[14].properties[1]);

  /// see [PlaceObjectBox.raw]
  static final raw =
      QueryStringProperty<PlaceObjectBox>(_entities[14].properties[2]);

  /// see [PlaceObjectBox.name]
  static final name =
      QueryStringProperty<PlaceObjectBox>(_entities[14].properties[3]);

  /// see [PlaceObjectBox.address]
  static final address =
      QueryStringProperty<PlaceObjectBox>(_entities[14].properties[4]);

  /// see [PlaceObjectBox.coordinate]
  static final coordinate =
      QueryRelationToOne<PlaceObjectBox, CoordinateObjectBox>(
          _entities[14].properties[5]);

  /// see [PlaceObjectBox.uri]
  static final uri =
      QueryStringProperty<PlaceObjectBox>(_entities[14].properties[6]);
}

/// [PostEventObjectBox] entity fields to define ObjectBox queries.
class PostEventObjectBox_ {
  /// see [PostEventObjectBox.id]
  static final id =
      QueryIntegerProperty<PostEventObjectBox>(_entities[15].properties[0]);

  /// see [PostEventObjectBox.post]
  static final post = QueryRelationToOne<PostEventObjectBox, PostObjectBox>(
      _entities[15].properties[1]);

  /// see [PostEventObjectBox.event]
  static final event = QueryRelationToOne<PostEventObjectBox, EventObjectBox>(
      _entities[15].properties[2]);
}

/// [PostGroupObjectBox] entity fields to define ObjectBox queries.
class PostGroupObjectBox_ {
  /// see [PostGroupObjectBox.id]
  static final id =
      QueryIntegerProperty<PostGroupObjectBox>(_entities[16].properties[0]);

  /// see [PostGroupObjectBox.post]
  static final post = QueryRelationToOne<PostGroupObjectBox, PostObjectBox>(
      _entities[16].properties[1]);

  /// see [PostGroupObjectBox.group]
  static final group = QueryRelationToOne<PostGroupObjectBox, GroupObjectBox>(
      _entities[16].properties[2]);
}

/// [PostLifeEventObjectBox] entity fields to define ObjectBox queries.
class PostLifeEventObjectBox_ {
  /// see [PostLifeEventObjectBox.id]
  static final id =
      QueryIntegerProperty<PostLifeEventObjectBox>(_entities[17].properties[0]);

  /// see [PostLifeEventObjectBox.raw]
  static final raw =
      QueryStringProperty<PostLifeEventObjectBox>(_entities[17].properties[1]);

  /// see [PostLifeEventObjectBox.profile]
  static final profile =
      QueryRelationToOne<PostLifeEventObjectBox, ProfileObjectBox>(
          _entities[17].properties[2]);

  /// see [PostLifeEventObjectBox.post]
  static final post = QueryRelationToOne<PostLifeEventObjectBox, PostObjectBox>(
      _entities[17].properties[3]);

  /// see [PostLifeEventObjectBox.title]
  static final title =
      QueryStringProperty<PostLifeEventObjectBox>(_entities[17].properties[4]);

  /// see [PostLifeEventObjectBox.place]
  static final place =
      QueryRelationToOne<PostLifeEventObjectBox, PlaceObjectBox>(
          _entities[17].properties[5]);
}

/// [PostObjectBox] entity fields to define ObjectBox queries.
class PostObjectBox_ {
  /// see [PostObjectBox.id]
  static final id =
      QueryIntegerProperty<PostObjectBox>(_entities[18].properties[0]);

  /// see [PostObjectBox.raw]
  static final raw =
      QueryStringProperty<PostObjectBox>(_entities[18].properties[1]);

  /// see [PostObjectBox.profile]
  static final profile = QueryRelationToOne<PostObjectBox, ProfileObjectBox>(
      _entities[18].properties[2]);

  /// see [PostObjectBox.timestamp]
  static final timestamp =
      QueryIntegerProperty<PostObjectBox>(_entities[18].properties[3]);

  /// see [PostObjectBox.description]
  static final description =
      QueryStringProperty<PostObjectBox>(_entities[18].properties[4]);

  /// see [PostObjectBox.title]
  static final title =
      QueryStringProperty<PostObjectBox>(_entities[18].properties[5]);

  /// see [PostObjectBox.isArchived]
  static final isArchived =
      QueryBooleanProperty<PostObjectBox>(_entities[18].properties[6]);

  /// see [PostObjectBox.metadata]
  static final metadata =
      QueryStringProperty<PostObjectBox>(_entities[18].properties[7]);

  /// see [PostObjectBox.textSearch]
  static final textSearch =
      QueryStringProperty<PostObjectBox>(_entities[18].properties[8]);

  /// see [PostObjectBox.images]
  static final images = QueryRelationToMany<PostObjectBox, ImageObjectBox>(
      _entities[18].relations[0]);

  /// see [PostObjectBox.videos]
  static final videos = QueryRelationToMany<PostObjectBox, VideoObjectBox>(
      _entities[18].relations[1]);

  /// see [PostObjectBox.files]
  static final files = QueryRelationToMany<PostObjectBox, FileObjectBox>(
      _entities[18].relations[2]);

  /// see [PostObjectBox.links]
  static final links = QueryRelationToMany<PostObjectBox, LinkObjectBox>(
      _entities[18].relations[3]);

  /// see [PostObjectBox.mentions]
  static final mentions = QueryRelationToMany<PostObjectBox, PersonObjectBox>(
      _entities[18].relations[4]);

  /// see [PostObjectBox.tags]
  static final tags = QueryRelationToMany<PostObjectBox, TagObjectBox>(
      _entities[18].relations[5]);
}

/// [PostPollObjectBox] entity fields to define ObjectBox queries.
class PostPollObjectBox_ {
  /// see [PostPollObjectBox.id]
  static final id =
      QueryIntegerProperty<PostPollObjectBox>(_entities[19].properties[0]);

  /// see [PostPollObjectBox.post]
  static final post = QueryRelationToOne<PostPollObjectBox, PostObjectBox>(
      _entities[19].properties[1]);

  /// see [PostPollObjectBox.isUsers]
  static final isUsers =
      QueryBooleanProperty<PostPollObjectBox>(_entities[19].properties[2]);

  /// see [PostPollObjectBox.options]
  static final options =
      QueryStringVectorProperty<PostPollObjectBox>(_entities[19].properties[3]);

  /// see [PostPollObjectBox.timestamp]
  static final timestamp =
      QueryIntegerProperty<PostPollObjectBox>(_entities[19].properties[4]);
}

/// [ProfileObjectBox] entity fields to define ObjectBox queries.
class ProfileObjectBox_ {
  /// see [ProfileObjectBox.id]
  static final id =
      QueryIntegerProperty<ProfileObjectBox>(_entities[20].properties[0]);

  /// see [ProfileObjectBox.service]
  static final service = QueryRelationToOne<ProfileObjectBox, ServiceObjectBox>(
      _entities[20].properties[1]);

  /// see [ProfileObjectBox.uri]
  static final uri =
      QueryStringProperty<ProfileObjectBox>(_entities[20].properties[2]);

  /// see [ProfileObjectBox.username]
  static final username =
      QueryStringProperty<ProfileObjectBox>(_entities[20].properties[3]);

  /// see [ProfileObjectBox.fullName]
  static final fullName =
      QueryStringProperty<ProfileObjectBox>(_entities[20].properties[4]);

  /// see [ProfileObjectBox.profilePicture]
  static final profilePicture =
      QueryRelationToOne<ProfileObjectBox, ImageObjectBox>(
          _entities[20].properties[5]);

  /// see [ProfileObjectBox.gender]
  static final gender =
      QueryStringProperty<ProfileObjectBox>(_entities[20].properties[6]);

  /// see [ProfileObjectBox.bio]
  static final bio =
      QueryStringProperty<ProfileObjectBox>(_entities[20].properties[7]);

  /// see [ProfileObjectBox.currentCity]
  static final currentCity =
      QueryStringProperty<ProfileObjectBox>(_entities[20].properties[8]);

  /// see [ProfileObjectBox.phoneNumbers]
  static final phoneNumbers =
      QueryStringVectorProperty<ProfileObjectBox>(_entities[20].properties[9]);

  /// see [ProfileObjectBox.isPhoneConfirmed]
  static final isPhoneConfirmed =
      QueryBooleanProperty<ProfileObjectBox>(_entities[20].properties[10]);

  /// see [ProfileObjectBox.createdTimestamp]
  static final createdTimestamp =
      QueryIntegerProperty<ProfileObjectBox>(_entities[20].properties[11]);

  /// see [ProfileObjectBox.isPrivate]
  static final isPrivate =
      QueryBooleanProperty<ProfileObjectBox>(_entities[20].properties[12]);

  /// see [ProfileObjectBox.websites]
  static final websites =
      QueryStringVectorProperty<ProfileObjectBox>(_entities[20].properties[13]);

  /// see [ProfileObjectBox.dateOfBirth]
  static final dateOfBirth =
      QueryIntegerProperty<ProfileObjectBox>(_entities[20].properties[14]);

  /// see [ProfileObjectBox.bloodInfo]
  static final bloodInfo =
      QueryStringProperty<ProfileObjectBox>(_entities[20].properties[15]);

  /// see [ProfileObjectBox.friendPeerGroup]
  static final friendPeerGroup =
      QueryStringProperty<ProfileObjectBox>(_entities[20].properties[16]);

  /// see [ProfileObjectBox.eligibility]
  static final eligibility =
      QueryStringProperty<ProfileObjectBox>(_entities[20].properties[17]);

  /// see [ProfileObjectBox.metadata]
  static final metadata =
      QueryStringVectorProperty<ProfileObjectBox>(_entities[20].properties[18]);

  /// see [ProfileObjectBox.raw]
  static final raw =
      QueryStringProperty<ProfileObjectBox>(_entities[20].properties[19]);

  /// see [ProfileObjectBox.emails]
  static final emails = QueryRelationToMany<ProfileObjectBox, EmailObjectBox>(
      _entities[20].relations[0]);

  /// see [ProfileObjectBox.changes]
  static final changes = QueryRelationToMany<ProfileObjectBox, ChangeObjectBox>(
      _entities[20].relations[1]);
}

/// [ReactionObjectBox] entity fields to define ObjectBox queries.
class ReactionObjectBox_ {
  /// see [ReactionObjectBox.id]
  static final id =
      QueryIntegerProperty<ReactionObjectBox>(_entities[21].properties[0]);

  /// see [ReactionObjectBox.raw]
  static final raw =
      QueryStringProperty<ReactionObjectBox>(_entities[21].properties[1]);

  /// see [ReactionObjectBox.reaction]
  static final reaction =
      QueryStringProperty<ReactionObjectBox>(_entities[21].properties[2]);
}

/// [ServiceObjectBox] entity fields to define ObjectBox queries.
class ServiceObjectBox_ {
  /// see [ServiceObjectBox.id]
  static final id =
      QueryIntegerProperty<ServiceObjectBox>(_entities[22].properties[0]);

  /// see [ServiceObjectBox.name]
  static final name =
      QueryStringProperty<ServiceObjectBox>(_entities[22].properties[1]);

  /// see [ServiceObjectBox.company]
  static final company =
      QueryStringProperty<ServiceObjectBox>(_entities[22].properties[2]);

  /// see [ServiceObjectBox.image]
  static final image =
      QueryStringProperty<ServiceObjectBox>(_entities[22].properties[3]);
}

/// [TagObjectBox] entity fields to define ObjectBox queries.
class TagObjectBox_ {
  /// see [TagObjectBox.id]
  static final id =
      QueryIntegerProperty<TagObjectBox>(_entities[23].properties[0]);

  /// see [TagObjectBox.name]
  static final name =
      QueryStringProperty<TagObjectBox>(_entities[23].properties[1]);
}

/// [VideoObjectBox] entity fields to define ObjectBox queries.
class VideoObjectBox_ {
  /// see [VideoObjectBox.id]
  static final id =
      QueryIntegerProperty<VideoObjectBox>(_entities[24].properties[0]);

  /// see [VideoObjectBox.profile]
  static final profile = QueryRelationToOne<VideoObjectBox, ProfileObjectBox>(
      _entities[24].properties[1]);

  /// see [VideoObjectBox.uri]
  static final uri =
      QueryStringProperty<VideoObjectBox>(_entities[24].properties[2]);

  /// see [VideoObjectBox.metadata]
  static final metadata =
      QueryStringProperty<VideoObjectBox>(_entities[24].properties[3]);

  /// see [VideoObjectBox.timestamp]
  static final timestamp =
      QueryIntegerProperty<VideoObjectBox>(_entities[24].properties[4]);

  /// see [VideoObjectBox.title]
  static final title =
      QueryStringProperty<VideoObjectBox>(_entities[24].properties[5]);

  /// see [VideoObjectBox.description]
  static final description =
      QueryStringProperty<VideoObjectBox>(_entities[24].properties[6]);

  /// see [VideoObjectBox.thumbnail]
  static final thumbnail =
      QueryStringProperty<VideoObjectBox>(_entities[24].properties[7]);

  /// see [VideoObjectBox.raw]
  static final raw =
      QueryStringProperty<VideoObjectBox>(_entities[24].properties[8]);

  /// see [VideoObjectBox.textSearch]
  static final textSearch =
      QueryStringProperty<VideoObjectBox>(_entities[24].properties[9]);
}
