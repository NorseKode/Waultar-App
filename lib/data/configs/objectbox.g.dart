// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: camel_case_types

import 'dart:typed_data';

import 'package:objectbox/flatbuffers/flat_buffers.dart' as fb;
import 'package:objectbox/internal.dart'; // generated code can access "internal" functionality
import 'package:objectbox/objectbox.dart';
import 'package:objectbox_flutter_libs/objectbox_flutter_libs.dart';

import '../../data/entities/content/event_objectbox.dart';
import '../../data/entities/content/group_objectbox.dart';
import '../../data/entities/content/life_event_objectbox.dart';
import '../../data/entities/content/page_objectbox.dart';
import '../../data/entities/content/poll_objectbox.dart';
import '../../data/entities/content/post_objectbox.dart';
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
      id: const IdUid(3, 8900465085811636702),
      name: 'AppSettingsObjectBox',
      lastPropertyId: const IdUid(2, 1215012359105287230),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 5546303035629335347),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 1215012359105287230),
            name: 'darkmode',
            type: 1,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[]),
  ModelEntity(
      id: const IdUid(4, 2566925674358462543),
      name: 'EventObjectBox',
      lastPropertyId: const IdUid(11, 8082148718529434695),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 4878258409898821268),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 7340476675784250437),
            name: 'profileId',
            type: 11,
            flags: 520,
            indexId: const IdUid(1, 6609294494622246788),
            relationTarget: 'ProfileObjectBox'),
        ModelProperty(
            id: const IdUid(3, 1950018273037483508),
            name: 'raw',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(4, 7888002340467079116),
            name: 'name',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(5, 913688411872759946),
            name: 'startTimestamp',
            type: 10,
            flags: 0),
        ModelProperty(
            id: const IdUid(6, 1006503207082243655),
            name: 'endTimestamp',
            type: 10,
            flags: 0),
        ModelProperty(
            id: const IdUid(7, 252280298853310437),
            name: 'createdTimestamp',
            type: 10,
            flags: 0),
        ModelProperty(
            id: const IdUid(8, 4701440639748503217),
            name: 'description',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(9, 5177674529170519954),
            name: 'isUsers',
            type: 1,
            flags: 0),
        ModelProperty(
            id: const IdUid(10, 6738178143332552151),
            name: 'placeId',
            type: 11,
            flags: 520,
            indexId: const IdUid(2, 7438411500152896368),
            relationTarget: 'PlaceObjectBox'),
        ModelProperty(
            id: const IdUid(11, 8082148718529434695),
            name: 'dbEventResponse',
            type: 6,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[]),
  ModelEntity(
      id: const IdUid(5, 7904827367213539019),
      name: 'ServiceObjectBox',
      lastPropertyId: const IdUid(4, 4989369752394289518),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 1838587479716504316),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 1725457736171191026),
            name: 'name',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 940101614267539913),
            name: 'company',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(4, 4989369752394289518),
            name: 'image',
            type: 9,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[]),
  ModelEntity(
      id: const IdUid(6, 1786282357926238948),
      name: 'ProfileObjectBox',
      lastPropertyId: const IdUid(19, 4608324703007646644),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 4697727666025452795),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 5956756246800386645),
            name: 'uri',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 150940219285517629),
            name: 'username',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(4, 6033775848085682414),
            name: 'fullName',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(5, 1252799269706424912),
            name: 'gender',
            type: 1,
            flags: 0),
        ModelProperty(
            id: const IdUid(6, 5316034422945385717),
            name: 'bio',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(7, 3588394692421559318),
            name: 'currentCity',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(8, 3700819771250547759),
            name: 'phoneNumber',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(9, 8529824417739135517),
            name: 'isPhoneConfirmed',
            type: 1,
            flags: 0),
        ModelProperty(
            id: const IdUid(10, 482557086549005907),
            name: 'createdTimestamp',
            type: 10,
            flags: 0),
        ModelProperty(
            id: const IdUid(11, 7012271168237861963),
            name: 'isPrivate',
            type: 1,
            flags: 0),
        ModelProperty(
            id: const IdUid(12, 8362101674599481860),
            name: 'websites',
            type: 30,
            flags: 0),
        ModelProperty(
            id: const IdUid(13, 4940623083677786395),
            name: 'dateOfBirth',
            type: 10,
            flags: 0),
        ModelProperty(
            id: const IdUid(14, 1029516864172124002),
            name: 'bloodInfo',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(15, 1943569074965759440),
            name: 'friendPeerGroup',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(16, 2377639145190349549),
            name: 'eligibility',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(17, 504423959685726527),
            name: 'metadata',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(18, 7323928305982656964),
            name: 'raw',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(19, 4608324703007646644),
            name: 'serviceId',
            type: 11,
            flags: 520,
            indexId: const IdUid(21, 1235049878482628590),
            relationTarget: 'ServiceObjectBox')
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[]),
  ModelEntity(
      id: const IdUid(7, 7610778147039031742),
      name: 'ActivityObjectBox',
      lastPropertyId: const IdUid(3, 6665348503643860803),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 462482792232421928),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 4203098633241439614),
            name: 'raw',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 6665348503643860803),
            name: 'timestamp',
            type: 10,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[]),
  ModelEntity(
      id: const IdUid(8, 8885644534967304783),
      name: 'ChangeObjectBox',
      lastPropertyId: const IdUid(6, 7362210297722175658),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 985081821155920078),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 4659922565779555661),
            name: 'raw',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 1950122342381917446),
            name: 'valueName',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(4, 1920807419209295577),
            name: 'previousValue',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(5, 8673896059398880281),
            name: 'newValue',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(6, 7362210297722175658),
            name: 'timestamp',
            type: 10,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[]),
  ModelEntity(
      id: const IdUid(9, 5500749891762925682),
      name: 'CoordinateObjectBox',
      lastPropertyId: const IdUid(3, 8955711482801444448),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 6854756541066192530),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 3341688226832098977),
            name: 'longitude',
            type: 8,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 8955711482801444448),
            name: 'latitude',
            type: 8,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[]),
  ModelEntity(
      id: const IdUid(10, 7875674094271168662),
      name: 'EmailObjectBox',
      lastPropertyId: const IdUid(5, 6279596052872176822),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 8133313644859298848),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 7526379445279563098),
            name: 'raw',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 4290218182173158043),
            name: 'email',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(4, 2251849766147901154),
            name: 'isCurrent',
            type: 1,
            flags: 0),
        ModelProperty(
            id: const IdUid(5, 6279596052872176822),
            name: 'timestamp',
            type: 10,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[]),
  ModelEntity(
      id: const IdUid(11, 575566687247819555),
      name: 'FileObjectBox',
      lastPropertyId: const IdUid(7, 1264177232458524261),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 4105910983556515421),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 5173291860459218223),
            name: 'profileId',
            type: 11,
            flags: 520,
            indexId: const IdUid(3, 4362353051619536960),
            relationTarget: 'ProfileObjectBox'),
        ModelProperty(
            id: const IdUid(3, 4835891250502864078),
            name: 'raw',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(4, 2702857996113930415),
            name: 'uri',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(5, 2058190551961481879),
            name: 'metadata',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(6, 8078918617339836296),
            name: 'timestamp',
            type: 10,
            flags: 0),
        ModelProperty(
            id: const IdUid(7, 1264177232458524261),
            name: 'thumbnail',
            type: 9,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[]),
  ModelEntity(
      id: const IdUid(12, 2655741356506140477),
      name: 'FriendObjectBox',
      lastPropertyId: const IdUid(6, 8990254563024664849),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 8360721464266979006),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 8408914666798356441),
            name: 'profileId',
            type: 11,
            flags: 520,
            indexId: const IdUid(4, 2711300462868674905),
            relationTarget: 'ProfileObjectBox'),
        ModelProperty(
            id: const IdUid(3, 7827412052446047276),
            name: 'timestamp',
            type: 10,
            flags: 0),
        ModelProperty(
            id: const IdUid(5, 4160832921089566994),
            name: 'raw',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(6, 8990254563024664849),
            name: 'dbFriendType',
            type: 6,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[]),
  ModelEntity(
      id: const IdUid(13, 3273540391756503100),
      name: 'GroupObjectBox',
      lastPropertyId: const IdUid(7, 4093684967311136696),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 6780366757174121247),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 5913885298364086954),
            name: 'profileId',
            type: 11,
            flags: 520,
            indexId: const IdUid(5, 4009700675598930647),
            relationTarget: 'ProfileObjectBox'),
        ModelProperty(
            id: const IdUid(3, 6205642571483083406),
            name: 'raw',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(4, 5234982945698306633),
            name: 'name',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(5, 4966642763486960809),
            name: 'isUsers',
            type: 1,
            flags: 0),
        ModelProperty(
            id: const IdUid(6, 7136594630385348382),
            name: 'badge',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(7, 4093684967311136696),
            name: 'timestamp',
            type: 10,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[]),
  ModelEntity(
      id: const IdUid(14, 4917345731593542244),
      name: 'ImageObjectBox',
      lastPropertyId: const IdUid(8, 2368861643283958423),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 7881486468232938211),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 3670418597695103545),
            name: 'profileId',
            type: 11,
            flags: 520,
            indexId: const IdUid(6, 7819819395113283949),
            relationTarget: 'ProfileObjectBox'),
        ModelProperty(
            id: const IdUid(3, 479919923647979150),
            name: 'uri',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(4, 4818651228614065897),
            name: 'metadata',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(5, 2866343745227666698),
            name: 'timestamp',
            type: 10,
            flags: 0),
        ModelProperty(
            id: const IdUid(6, 4083287085724442958),
            name: 'title',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(7, 530726129031572326),
            name: 'description',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(8, 2368861643283958423),
            name: 'raw',
            type: 9,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[]),
  ModelEntity(
      id: const IdUid(15, 4521581829489353372),
      name: 'LifeEventObjectBox',
      lastPropertyId: const IdUid(5, 5101253906812243554),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 5273233428025161888),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 5770586634777914851),
            name: 'raw',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 5929238326069376370),
            name: 'profileId',
            type: 11,
            flags: 520,
            indexId: const IdUid(7, 1108142740720186972),
            relationTarget: 'ProfileObjectBox'),
        ModelProperty(
            id: const IdUid(4, 3638688937140434513),
            name: 'title',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(5, 5101253906812243554),
            name: 'placeId',
            type: 11,
            flags: 520,
            indexId: const IdUid(8, 9218158865254685125),
            relationTarget: 'PlaceObjectBox')
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[]),
  ModelEntity(
      id: const IdUid(16, 3083520632734441177),
      name: 'LinkObjectBox',
      lastPropertyId: const IdUid(7, 7801353157999510033),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 5699906806606478496),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 5896084891178738544),
            name: 'uri',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 1013415529509987158),
            name: 'metadata',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(4, 1207932480499707319),
            name: 'timestamp',
            type: 10,
            flags: 0),
        ModelProperty(
            id: const IdUid(5, 3082530832129214104),
            name: 'profileId',
            type: 11,
            flags: 520,
            indexId: const IdUid(9, 5508360980596220612),
            relationTarget: 'ProfileObjectBox'),
        ModelProperty(
            id: const IdUid(6, 112463284468773608),
            name: 'source',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(7, 7801353157999510033),
            name: 'raw',
            type: 9,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[]),
  ModelEntity(
      id: const IdUid(17, 1600603355982785495),
      name: 'PageObjectBox',
      lastPropertyId: const IdUid(6, 5055389718668949616),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 7175129238727965062),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 1167529126306912109),
            name: 'raw',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 5386467497368169553),
            name: 'profileId',
            type: 11,
            flags: 520,
            indexId: const IdUid(10, 5840990842118139412),
            relationTarget: 'ProfileObjectBox'),
        ModelProperty(
            id: const IdUid(4, 4980673640163636600),
            name: 'name',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(5, 912539323666884786),
            name: 'isUsers',
            type: 1,
            flags: 0),
        ModelProperty(
            id: const IdUid(6, 5055389718668949616),
            name: 'uri',
            type: 9,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[]),
  ModelEntity(
      id: const IdUid(18, 6769473329456451923),
      name: 'PersonObjectBox',
      lastPropertyId: const IdUid(5, 1100301783817334673),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 7237213006141090280),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 6813600439492213726),
            name: 'profileId',
            type: 11,
            flags: 520,
            indexId: const IdUid(11, 5755555706141599144),
            relationTarget: 'ProfileObjectBox'),
        ModelProperty(
            id: const IdUid(3, 8331482932908887928),
            name: 'raw',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(4, 1013357834339007436),
            name: 'name',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(5, 1100301783817334673),
            name: 'uri',
            type: 9,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[]),
  ModelEntity(
      id: const IdUid(19, 8527057727816690070),
      name: 'PlaceObjectBox',
      lastPropertyId: const IdUid(7, 4238191806851404930),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 5148561020857648577),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 1489934716934386355),
            name: 'profileId',
            type: 11,
            flags: 520,
            indexId: const IdUid(12, 8691961604255510739),
            relationTarget: 'ProfileObjectBox'),
        ModelProperty(
            id: const IdUid(3, 7343115484733645835),
            name: 'raw',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(4, 2153802637169000355),
            name: 'name',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(5, 6537177147335484894),
            name: 'address',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(6, 2065110009519391022),
            name: 'coordinateId',
            type: 11,
            flags: 520,
            indexId: const IdUid(13, 9207120286272124524),
            relationTarget: 'CoordinateObjectBox'),
        ModelProperty(
            id: const IdUid(7, 4238191806851404930),
            name: 'uri',
            type: 9,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[]),
  ModelEntity(
      id: const IdUid(20, 2652951279138236051),
      name: 'PollObjectBox',
      lastPropertyId: const IdUid(7, 4392723400432572784),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 7248422152794599389),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 1888721063681089551),
            name: 'profileId',
            type: 11,
            flags: 520,
            indexId: const IdUid(14, 6523281121605597108),
            relationTarget: 'ProfileObjectBox'),
        ModelProperty(
            id: const IdUid(3, 1465752729792948772),
            name: 'raw',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(4, 2781293098887226224),
            name: 'timestamp',
            type: 10,
            flags: 0),
        ModelProperty(
            id: const IdUid(5, 3972303150322710599),
            name: 'question',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(6, 8828556671193391659),
            name: 'isUsers',
            type: 1,
            flags: 0),
        ModelProperty(
            id: const IdUid(7, 4392723400432572784),
            name: 'options',
            type: 9,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[]),
  ModelEntity(
      id: const IdUid(21, 1840073705676171105),
      name: 'PostObjectBox',
      lastPropertyId: const IdUid(12, 7987839579535190084),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 8276003456389851969),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 600680241969788084),
            name: 'raw',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 2065384154945556186),
            name: 'profileId',
            type: 11,
            flags: 520,
            indexId: const IdUid(15, 6481628281343852799),
            relationTarget: 'ProfileObjectBox'),
        ModelProperty(
            id: const IdUid(4, 19067708221955542),
            name: 'timestamp',
            type: 10,
            flags: 0),
        ModelProperty(
            id: const IdUid(5, 3566876786326136972),
            name: 'description',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(6, 2024717990031280075),
            name: 'title',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(7, 5341811089859233541),
            name: 'eventId',
            type: 11,
            flags: 520,
            indexId: const IdUid(16, 2188429983658332891),
            relationTarget: 'EventObjectBox'),
        ModelProperty(
            id: const IdUid(8, 2929942333910987479),
            name: 'groupId',
            type: 11,
            flags: 520,
            indexId: const IdUid(17, 8915507866262722089),
            relationTarget: 'GroupObjectBox'),
        ModelProperty(
            id: const IdUid(9, 7092817798915765009),
            name: 'pollId',
            type: 11,
            flags: 520,
            indexId: const IdUid(18, 6223371104317611347),
            relationTarget: 'PollObjectBox'),
        ModelProperty(
            id: const IdUid(10, 2568006049428907002),
            name: 'lifeEventId',
            type: 11,
            flags: 520,
            indexId: const IdUid(19, 5171466753838581702),
            relationTarget: 'LifeEventObjectBox'),
        ModelProperty(
            id: const IdUid(11, 3172795338753121399),
            name: 'isArchived',
            type: 1,
            flags: 0),
        ModelProperty(
            id: const IdUid(12, 7987839579535190084),
            name: 'meta',
            type: 9,
            flags: 0)
      ],
      relations: <ModelRelation>[
        ModelRelation(
            id: const IdUid(1, 5522014067521999835),
            name: 'images',
            targetId: const IdUid(14, 4917345731593542244)),
        ModelRelation(
            id: const IdUid(2, 7148228953090269690),
            name: 'videos',
            targetId: const IdUid(24, 1944258851869554230)),
        ModelRelation(
            id: const IdUid(3, 4275173052342726567),
            name: 'files',
            targetId: const IdUid(11, 575566687247819555)),
        ModelRelation(
            id: const IdUid(4, 1471480859975343021),
            name: 'links',
            targetId: const IdUid(16, 3083520632734441177)),
        ModelRelation(
            id: const IdUid(5, 8102051045803292045),
            name: 'mentions',
            targetId: const IdUid(18, 6769473329456451923)),
        ModelRelation(
            id: const IdUid(6, 3609669659353406727),
            name: 'tags',
            targetId: const IdUid(23, 3486554937597218899))
      ],
      backlinks: <ModelBacklink>[]),
  ModelEntity(
      id: const IdUid(22, 2610746200276322105),
      name: 'ReactionObjectBox',
      lastPropertyId: const IdUid(3, 7069307819952646077),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 3192414167973818857),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 8487870051248718428),
            name: 'raw',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 7069307819952646077),
            name: 'reaction',
            type: 9,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[]),
  ModelEntity(
      id: const IdUid(23, 3486554937597218899),
      name: 'TagObjectBox',
      lastPropertyId: const IdUid(2, 1621098965918379523),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 1441212728932799061),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 1621098965918379523),
            name: 'name',
            type: 9,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[]),
  ModelEntity(
      id: const IdUid(24, 1944258851869554230),
      name: 'VideoObjectBox',
      lastPropertyId: const IdUid(9, 5541901195020504566),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 3475617689999702941),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 4445384230550622304),
            name: 'profileId',
            type: 11,
            flags: 520,
            indexId: const IdUid(20, 9065870816709925746),
            relationTarget: 'ProfileObjectBox'),
        ModelProperty(
            id: const IdUid(3, 4074119583323526358),
            name: 'uri',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(4, 4943519819978689121),
            name: 'metadata',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(5, 7437185394396666476),
            name: 'timestamp',
            type: 10,
            flags: 0),
        ModelProperty(
            id: const IdUid(6, 6260355541513144129),
            name: 'title',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(7, 740893765700161565),
            name: 'description',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(8, 2037673960427544069),
            name: 'thumbnail',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(9, 5541901195020504566),
            name: 'raw',
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
      lastEntityId: const IdUid(24, 1944258851869554230),
      lastIndexId: const IdUid(21, 1235049878482628590),
      lastRelationId: const IdUid(6, 3609669659353406727),
      lastSequenceId: const IdUid(0, 0),
      retiredEntityUids: const [1837511870469432447, 2148786199038735847],
      retiredIndexUids: const [],
      retiredPropertyUids: const [
        219800542496953078,
        7926224797411893663,
        6880580214941458863,
        2600227792391331024,
        9155762340551357005,
        849533903163781586,
        7188254403453284626
      ],
      retiredRelationUids: const [],
      modelVersion: 5,
      modelVersionParserMinimum: 5,
      version: 1);

  final bindings = <Type, EntityDefinition>{
    AppSettingsObjectBox: EntityDefinition<AppSettingsObjectBox>(
        model: _entities[0],
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
    EventObjectBox: EntityDefinition<EventObjectBox>(
        model: _entities[1],
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
    ServiceObjectBox: EntityDefinition<ServiceObjectBox>(
        model: _entities[2],
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
    ProfileObjectBox: EntityDefinition<ProfileObjectBox>(
        model: _entities[3],
        toOneRelations: (ProfileObjectBox object) => [object.service],
        toManyRelations: (ProfileObjectBox object) => {},
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
          final bioOffset =
              object.bio == null ? null : fbb.writeString(object.bio!);
          final currentCityOffset = object.currentCity == null
              ? null
              : fbb.writeString(object.currentCity!);
          final phoneNumberOffset = object.phoneNumber == null
              ? null
              : fbb.writeString(object.phoneNumber!);
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
              : fbb.writeString(object.metadata!);
          final rawOffset = fbb.writeString(object.raw);
          fbb.startTable(20);
          fbb.addInt64(0, object.id);
          fbb.addOffset(1, uriOffset);
          fbb.addOffset(2, usernameOffset);
          fbb.addOffset(3, fullNameOffset);
          fbb.addBool(4, object.gender);
          fbb.addOffset(5, bioOffset);
          fbb.addOffset(6, currentCityOffset);
          fbb.addOffset(7, phoneNumberOffset);
          fbb.addBool(8, object.isPhoneConfirmed);
          fbb.addInt64(9, object.createdTimestamp.millisecondsSinceEpoch);
          fbb.addBool(10, object.isPrivate);
          fbb.addOffset(11, websitesOffset);
          fbb.addInt64(12, object.dateOfBirth?.millisecondsSinceEpoch);
          fbb.addOffset(13, bloodInfoOffset);
          fbb.addOffset(14, friendPeerGroupOffset);
          fbb.addOffset(15, eligibilityOffset);
          fbb.addOffset(16, metadataOffset);
          fbb.addOffset(17, rawOffset);
          fbb.addInt64(18, object.service.targetId);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);
          final dateOfBirthValue =
              const fb.Int64Reader().vTableGetNullable(buffer, rootOffset, 28);
          final object = ProfileObjectBox(
              id: const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0),
              uri: const fb.StringReader().vTableGet(buffer, rootOffset, 6, ''),
              username: const fb.StringReader()
                  .vTableGetNullable(buffer, rootOffset, 8),
              fullName:
                  const fb.StringReader().vTableGet(buffer, rootOffset, 10, ''),
              gender: const fb.BoolReader()
                  .vTableGetNullable(buffer, rootOffset, 12),
              bio: const fb.StringReader()
                  .vTableGetNullable(buffer, rootOffset, 14),
              currentCity: const fb.StringReader()
                  .vTableGetNullable(buffer, rootOffset, 16),
              phoneNumber: const fb.StringReader()
                  .vTableGetNullable(buffer, rootOffset, 18),
              isPhoneConfirmed: const fb.BoolReader()
                  .vTableGetNullable(buffer, rootOffset, 20),
              createdTimestamp: DateTime.fromMillisecondsSinceEpoch(
                  const fb.Int64Reader().vTableGet(buffer, rootOffset, 22, 0)),
              isPrivate: const fb.BoolReader()
                  .vTableGetNullable(buffer, rootOffset, 24),
              websites: const fb.ListReader<String>(fb.StringReader(), lazy: false)
                  .vTableGetNullable(buffer, rootOffset, 26),
              dateOfBirth: dateOfBirthValue == null
                  ? null
                  : DateTime.fromMillisecondsSinceEpoch(dateOfBirthValue),
              bloodInfo:
                  const fb.StringReader().vTableGetNullable(buffer, rootOffset, 30),
              friendPeerGroup: const fb.StringReader().vTableGetNullable(buffer, rootOffset, 32),
              eligibility: const fb.StringReader().vTableGetNullable(buffer, rootOffset, 34),
              metadata: const fb.StringReader().vTableGetNullable(buffer, rootOffset, 36),
              raw: const fb.StringReader().vTableGet(buffer, rootOffset, 38, ''));
          object.service.targetId =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 40, 0);
          object.service.attach(store);
          return object;
        }),
    ActivityObjectBox: EntityDefinition<ActivityObjectBox>(
        model: _entities[4],
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
    ChangeObjectBox: EntityDefinition<ChangeObjectBox>(
        model: _entities[5],
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
    CoordinateObjectBox: EntityDefinition<CoordinateObjectBox>(
        model: _entities[6],
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
        model: _entities[7],
        toOneRelations: (EmailObjectBox object) => [],
        toManyRelations: (EmailObjectBox object) => {},
        getId: (EmailObjectBox object) => object.id,
        setId: (EmailObjectBox object, int id) {
          object.id = id;
        },
        objectToFB: (EmailObjectBox object, fb.Builder fbb) {
          final rawOffset = fbb.writeString(object.raw);
          final emailOffset = fbb.writeString(object.email);
          fbb.startTable(6);
          fbb.addInt64(0, object.id);
          fbb.addOffset(1, rawOffset);
          fbb.addOffset(2, emailOffset);
          fbb.addBool(3, object.isCurrent);
          fbb.addInt64(4, object.timestamp.millisecondsSinceEpoch);
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
                  .vTableGet(buffer, rootOffset, 10, false),
              timestamp: DateTime.fromMillisecondsSinceEpoch(
                  const fb.Int64Reader().vTableGet(buffer, rootOffset, 12, 0)));

          return object;
        }),
    FileObjectBox: EntityDefinition<FileObjectBox>(
        model: _entities[8],
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
          fbb.startTable(8);
          fbb.addInt64(0, object.id);
          fbb.addInt64(1, object.profile.targetId);
          fbb.addOffset(2, rawOffset);
          fbb.addOffset(3, uriOffset);
          fbb.addOffset(4, metadataOffset);
          fbb.addInt64(5, object.timestamp?.millisecondsSinceEpoch);
          fbb.addOffset(6, thumbnailOffset);
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
                  .vTableGetNullable(buffer, rootOffset, 16));
          object.profile.targetId =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 6, 0);
          object.profile.attach(store);
          return object;
        }),
    FriendObjectBox: EntityDefinition<FriendObjectBox>(
        model: _entities[9],
        toOneRelations: (FriendObjectBox object) => [object.profile],
        toManyRelations: (FriendObjectBox object) => {},
        getId: (FriendObjectBox object) => object.id,
        setId: (FriendObjectBox object, int id) {
          object.id = id;
        },
        objectToFB: (FriendObjectBox object, fb.Builder fbb) {
          final rawOffset = fbb.writeString(object.raw);
          fbb.startTable(7);
          fbb.addInt64(0, object.id);
          fbb.addInt64(1, object.profile.targetId);
          fbb.addInt64(2, object.timestamp?.millisecondsSinceEpoch);
          fbb.addOffset(4, rawOffset);
          fbb.addInt64(5, object.dbFriendType);
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
                  const fb.StringReader().vTableGet(buffer, rootOffset, 12, ''))
            ..dbFriendType = const fb.Int64Reader()
                .vTableGetNullable(buffer, rootOffset, 14);
          object.profile.targetId =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 6, 0);
          object.profile.attach(store);
          return object;
        }),
    GroupObjectBox: EntityDefinition<GroupObjectBox>(
        model: _entities[10],
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
        model: _entities[11],
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
          fbb.startTable(9);
          fbb.addInt64(0, object.id);
          fbb.addInt64(1, object.profile.targetId);
          fbb.addOffset(2, uriOffset);
          fbb.addOffset(3, metadataOffset);
          fbb.addInt64(4, object.timestamp?.millisecondsSinceEpoch);
          fbb.addOffset(5, titleOffset);
          fbb.addOffset(6, descriptionOffset);
          fbb.addOffset(7, rawOffset);
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
              raw: const fb.StringReader()
                  .vTableGet(buffer, rootOffset, 18, ''));
          object.profile.targetId =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 6, 0);
          object.profile.attach(store);
          return object;
        }),
    LifeEventObjectBox: EntityDefinition<LifeEventObjectBox>(
        model: _entities[12],
        toOneRelations: (LifeEventObjectBox object) =>
            [object.profile, object.place],
        toManyRelations: (LifeEventObjectBox object) => {},
        getId: (LifeEventObjectBox object) => object.id,
        setId: (LifeEventObjectBox object, int id) {
          object.id = id;
        },
        objectToFB: (LifeEventObjectBox object, fb.Builder fbb) {
          final rawOffset = fbb.writeString(object.raw);
          final titleOffset = fbb.writeString(object.title);
          fbb.startTable(6);
          fbb.addInt64(0, object.id);
          fbb.addOffset(1, rawOffset);
          fbb.addInt64(2, object.profile.targetId);
          fbb.addOffset(3, titleOffset);
          fbb.addInt64(4, object.place.targetId);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = LifeEventObjectBox(
              id: const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0),
              raw: const fb.StringReader().vTableGet(buffer, rootOffset, 6, ''),
              title: const fb.StringReader()
                  .vTableGet(buffer, rootOffset, 10, ''));
          object.profile.targetId =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 8, 0);
          object.profile.attach(store);
          object.place.targetId =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 12, 0);
          object.place.attach(store);
          return object;
        }),
    LinkObjectBox: EntityDefinition<LinkObjectBox>(
        model: _entities[13],
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
          fbb.startTable(8);
          fbb.addInt64(0, object.id);
          fbb.addOffset(1, uriOffset);
          fbb.addOffset(2, metadataOffset);
          fbb.addInt64(3, object.timestamp?.millisecondsSinceEpoch);
          fbb.addInt64(4, object.profile.targetId);
          fbb.addOffset(5, sourceOffset);
          fbb.addOffset(6, rawOffset);
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
              raw: const fb.StringReader()
                  .vTableGet(buffer, rootOffset, 16, ''));
          object.profile.targetId =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 12, 0);
          object.profile.attach(store);
          return object;
        }),
    PageObjectBox: EntityDefinition<PageObjectBox>(
        model: _entities[14],
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
        model: _entities[15],
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
        model: _entities[16],
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
    PollObjectBox: EntityDefinition<PollObjectBox>(
        model: _entities[17],
        toOneRelations: (PollObjectBox object) => [object.profile],
        toManyRelations: (PollObjectBox object) => {},
        getId: (PollObjectBox object) => object.id,
        setId: (PollObjectBox object, int id) {
          object.id = id;
        },
        objectToFB: (PollObjectBox object, fb.Builder fbb) {
          final rawOffset = fbb.writeString(object.raw);
          final questionOffset = object.question == null
              ? null
              : fbb.writeString(object.question!);
          final optionsOffset =
              object.options == null ? null : fbb.writeString(object.options!);
          fbb.startTable(8);
          fbb.addInt64(0, object.id);
          fbb.addInt64(1, object.profile.targetId);
          fbb.addOffset(2, rawOffset);
          fbb.addInt64(3, object.timestamp?.millisecondsSinceEpoch);
          fbb.addOffset(4, questionOffset);
          fbb.addBool(5, object.isUsers);
          fbb.addOffset(6, optionsOffset);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);
          final timestampValue =
              const fb.Int64Reader().vTableGetNullable(buffer, rootOffset, 10);
          final object = PollObjectBox(
              id: const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0),
              raw: const fb.StringReader().vTableGet(buffer, rootOffset, 8, ''),
              timestamp: timestampValue == null
                  ? null
                  : DateTime.fromMillisecondsSinceEpoch(timestampValue),
              question: const fb.StringReader()
                  .vTableGetNullable(buffer, rootOffset, 12),
              isUsers: const fb.BoolReader()
                  .vTableGet(buffer, rootOffset, 14, false),
              options: const fb.StringReader()
                  .vTableGetNullable(buffer, rootOffset, 16));
          object.profile.targetId =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 6, 0);
          object.profile.attach(store);
          return object;
        }),
    PostObjectBox: EntityDefinition<PostObjectBox>(
        model: _entities[18],
        toOneRelations: (PostObjectBox object) => [
              object.profile,
              object.event,
              object.group,
              object.poll,
              object.lifeEvent
            ],
        toManyRelations: (PostObjectBox object) => {
              RelInfo<PostObjectBox>.toMany(1, object.id): object.images,
              RelInfo<PostObjectBox>.toMany(2, object.id): object.videos,
              RelInfo<PostObjectBox>.toMany(3, object.id): object.files,
              RelInfo<PostObjectBox>.toMany(4, object.id): object.links,
              RelInfo<PostObjectBox>.toMany(5, object.id): object.mentions,
              RelInfo<PostObjectBox>.toMany(6, object.id): object.tags
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
          final metaOffset =
              object.meta == null ? null : fbb.writeString(object.meta!);
          fbb.startTable(13);
          fbb.addInt64(0, object.id);
          fbb.addOffset(1, rawOffset);
          fbb.addInt64(2, object.profile.targetId);
          fbb.addInt64(3, object.timestamp.millisecondsSinceEpoch);
          fbb.addOffset(4, descriptionOffset);
          fbb.addOffset(5, titleOffset);
          fbb.addInt64(6, object.event.targetId);
          fbb.addInt64(7, object.group.targetId);
          fbb.addInt64(8, object.poll.targetId);
          fbb.addInt64(9, object.lifeEvent.targetId);
          fbb.addBool(10, object.isArchived);
          fbb.addOffset(11, metaOffset);
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
                  .vTableGetNullable(buffer, rootOffset, 24),
              meta: const fb.StringReader()
                  .vTableGetNullable(buffer, rootOffset, 26));
          object.profile.targetId =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 8, 0);
          object.profile.attach(store);
          object.event.targetId =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 16, 0);
          object.event.attach(store);
          object.group.targetId =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 18, 0);
          object.group.attach(store);
          object.poll.targetId =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 20, 0);
          object.poll.attach(store);
          object.lifeEvent.targetId =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 22, 0);
          object.lifeEvent.attach(store);
          InternalToManyAccess.setRelInfo(
              object.images,
              store,
              RelInfo<PostObjectBox>.toMany(1, object.id),
              store.box<PostObjectBox>());
          InternalToManyAccess.setRelInfo(
              object.videos,
              store,
              RelInfo<PostObjectBox>.toMany(2, object.id),
              store.box<PostObjectBox>());
          InternalToManyAccess.setRelInfo(
              object.files,
              store,
              RelInfo<PostObjectBox>.toMany(3, object.id),
              store.box<PostObjectBox>());
          InternalToManyAccess.setRelInfo(
              object.links,
              store,
              RelInfo<PostObjectBox>.toMany(4, object.id),
              store.box<PostObjectBox>());
          InternalToManyAccess.setRelInfo(
              object.mentions,
              store,
              RelInfo<PostObjectBox>.toMany(5, object.id),
              store.box<PostObjectBox>());
          InternalToManyAccess.setRelInfo(
              object.tags,
              store,
              RelInfo<PostObjectBox>.toMany(6, object.id),
              store.box<PostObjectBox>());
          return object;
        }),
    ReactionObjectBox: EntityDefinition<ReactionObjectBox>(
        model: _entities[19],
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
    TagObjectBox: EntityDefinition<TagObjectBox>(
        model: _entities[20],
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
        model: _entities[21],
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
          fbb.startTable(10);
          fbb.addInt64(0, object.id);
          fbb.addInt64(1, object.profile.targetId);
          fbb.addOffset(2, uriOffset);
          fbb.addOffset(3, metadataOffset);
          fbb.addInt64(4, object.timestamp?.millisecondsSinceEpoch);
          fbb.addOffset(5, titleOffset);
          fbb.addOffset(6, descriptionOffset);
          fbb.addOffset(7, thumbnailOffset);
          fbb.addOffset(8, rawOffset);
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
              raw: const fb.StringReader()
                  .vTableGet(buffer, rootOffset, 20, ''));
          object.profile.targetId =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 6, 0);
          object.profile.attach(store);
          return object;
        })
  };

  return ModelDefinition(model, bindings);
}

/// [AppSettingsObjectBox] entity fields to define ObjectBox queries.
class AppSettingsObjectBox_ {
  /// see [AppSettingsObjectBox.id]
  static final id =
      QueryIntegerProperty<AppSettingsObjectBox>(_entities[0].properties[0]);

  /// see [AppSettingsObjectBox.darkmode]
  static final darkmode =
      QueryBooleanProperty<AppSettingsObjectBox>(_entities[0].properties[1]);
}

/// [EventObjectBox] entity fields to define ObjectBox queries.
class EventObjectBox_ {
  /// see [EventObjectBox.id]
  static final id =
      QueryIntegerProperty<EventObjectBox>(_entities[1].properties[0]);

  /// see [EventObjectBox.profile]
  static final profile = QueryRelationToOne<EventObjectBox, ProfileObjectBox>(
      _entities[1].properties[1]);

  /// see [EventObjectBox.raw]
  static final raw =
      QueryStringProperty<EventObjectBox>(_entities[1].properties[2]);

  /// see [EventObjectBox.name]
  static final name =
      QueryStringProperty<EventObjectBox>(_entities[1].properties[3]);

  /// see [EventObjectBox.startTimestamp]
  static final startTimestamp =
      QueryIntegerProperty<EventObjectBox>(_entities[1].properties[4]);

  /// see [EventObjectBox.endTimestamp]
  static final endTimestamp =
      QueryIntegerProperty<EventObjectBox>(_entities[1].properties[5]);

  /// see [EventObjectBox.createdTimestamp]
  static final createdTimestamp =
      QueryIntegerProperty<EventObjectBox>(_entities[1].properties[6]);

  /// see [EventObjectBox.description]
  static final description =
      QueryStringProperty<EventObjectBox>(_entities[1].properties[7]);

  /// see [EventObjectBox.isUsers]
  static final isUsers =
      QueryBooleanProperty<EventObjectBox>(_entities[1].properties[8]);

  /// see [EventObjectBox.place]
  static final place = QueryRelationToOne<EventObjectBox, PlaceObjectBox>(
      _entities[1].properties[9]);

  /// see [EventObjectBox.dbEventResponse]
  static final dbEventResponse =
      QueryIntegerProperty<EventObjectBox>(_entities[1].properties[10]);
}

/// [ServiceObjectBox] entity fields to define ObjectBox queries.
class ServiceObjectBox_ {
  /// see [ServiceObjectBox.id]
  static final id =
      QueryIntegerProperty<ServiceObjectBox>(_entities[2].properties[0]);

  /// see [ServiceObjectBox.name]
  static final name =
      QueryStringProperty<ServiceObjectBox>(_entities[2].properties[1]);

  /// see [ServiceObjectBox.company]
  static final company =
      QueryStringProperty<ServiceObjectBox>(_entities[2].properties[2]);

  /// see [ServiceObjectBox.image]
  static final image =
      QueryStringProperty<ServiceObjectBox>(_entities[2].properties[3]);
}

/// [ProfileObjectBox] entity fields to define ObjectBox queries.
class ProfileObjectBox_ {
  /// see [ProfileObjectBox.id]
  static final id =
      QueryIntegerProperty<ProfileObjectBox>(_entities[3].properties[0]);

  /// see [ProfileObjectBox.uri]
  static final uri =
      QueryStringProperty<ProfileObjectBox>(_entities[3].properties[1]);

  /// see [ProfileObjectBox.username]
  static final username =
      QueryStringProperty<ProfileObjectBox>(_entities[3].properties[2]);

  /// see [ProfileObjectBox.fullName]
  static final fullName =
      QueryStringProperty<ProfileObjectBox>(_entities[3].properties[3]);

  /// see [ProfileObjectBox.gender]
  static final gender =
      QueryBooleanProperty<ProfileObjectBox>(_entities[3].properties[4]);

  /// see [ProfileObjectBox.bio]
  static final bio =
      QueryStringProperty<ProfileObjectBox>(_entities[3].properties[5]);

  /// see [ProfileObjectBox.currentCity]
  static final currentCity =
      QueryStringProperty<ProfileObjectBox>(_entities[3].properties[6]);

  /// see [ProfileObjectBox.phoneNumber]
  static final phoneNumber =
      QueryStringProperty<ProfileObjectBox>(_entities[3].properties[7]);

  /// see [ProfileObjectBox.isPhoneConfirmed]
  static final isPhoneConfirmed =
      QueryBooleanProperty<ProfileObjectBox>(_entities[3].properties[8]);

  /// see [ProfileObjectBox.createdTimestamp]
  static final createdTimestamp =
      QueryIntegerProperty<ProfileObjectBox>(_entities[3].properties[9]);

  /// see [ProfileObjectBox.isPrivate]
  static final isPrivate =
      QueryBooleanProperty<ProfileObjectBox>(_entities[3].properties[10]);

  /// see [ProfileObjectBox.websites]
  static final websites =
      QueryStringVectorProperty<ProfileObjectBox>(_entities[3].properties[11]);

  /// see [ProfileObjectBox.dateOfBirth]
  static final dateOfBirth =
      QueryIntegerProperty<ProfileObjectBox>(_entities[3].properties[12]);

  /// see [ProfileObjectBox.bloodInfo]
  static final bloodInfo =
      QueryStringProperty<ProfileObjectBox>(_entities[3].properties[13]);

  /// see [ProfileObjectBox.friendPeerGroup]
  static final friendPeerGroup =
      QueryStringProperty<ProfileObjectBox>(_entities[3].properties[14]);

  /// see [ProfileObjectBox.eligibility]
  static final eligibility =
      QueryStringProperty<ProfileObjectBox>(_entities[3].properties[15]);

  /// see [ProfileObjectBox.metadata]
  static final metadata =
      QueryStringProperty<ProfileObjectBox>(_entities[3].properties[16]);

  /// see [ProfileObjectBox.raw]
  static final raw =
      QueryStringProperty<ProfileObjectBox>(_entities[3].properties[17]);

  /// see [ProfileObjectBox.service]
  static final service = QueryRelationToOne<ProfileObjectBox, ServiceObjectBox>(
      _entities[3].properties[18]);
}

/// [ActivityObjectBox] entity fields to define ObjectBox queries.
class ActivityObjectBox_ {
  /// see [ActivityObjectBox.id]
  static final id =
      QueryIntegerProperty<ActivityObjectBox>(_entities[4].properties[0]);

  /// see [ActivityObjectBox.raw]
  static final raw =
      QueryStringProperty<ActivityObjectBox>(_entities[4].properties[1]);

  /// see [ActivityObjectBox.timestamp]
  static final timestamp =
      QueryIntegerProperty<ActivityObjectBox>(_entities[4].properties[2]);
}

/// [ChangeObjectBox] entity fields to define ObjectBox queries.
class ChangeObjectBox_ {
  /// see [ChangeObjectBox.id]
  static final id =
      QueryIntegerProperty<ChangeObjectBox>(_entities[5].properties[0]);

  /// see [ChangeObjectBox.raw]
  static final raw =
      QueryStringProperty<ChangeObjectBox>(_entities[5].properties[1]);

  /// see [ChangeObjectBox.valueName]
  static final valueName =
      QueryStringProperty<ChangeObjectBox>(_entities[5].properties[2]);

  /// see [ChangeObjectBox.previousValue]
  static final previousValue =
      QueryStringProperty<ChangeObjectBox>(_entities[5].properties[3]);

  /// see [ChangeObjectBox.newValue]
  static final newValue =
      QueryStringProperty<ChangeObjectBox>(_entities[5].properties[4]);

  /// see [ChangeObjectBox.timestamp]
  static final timestamp =
      QueryIntegerProperty<ChangeObjectBox>(_entities[5].properties[5]);
}

/// [CoordinateObjectBox] entity fields to define ObjectBox queries.
class CoordinateObjectBox_ {
  /// see [CoordinateObjectBox.id]
  static final id =
      QueryIntegerProperty<CoordinateObjectBox>(_entities[6].properties[0]);

  /// see [CoordinateObjectBox.longitude]
  static final longitude =
      QueryDoubleProperty<CoordinateObjectBox>(_entities[6].properties[1]);

  /// see [CoordinateObjectBox.latitude]
  static final latitude =
      QueryDoubleProperty<CoordinateObjectBox>(_entities[6].properties[2]);
}

/// [EmailObjectBox] entity fields to define ObjectBox queries.
class EmailObjectBox_ {
  /// see [EmailObjectBox.id]
  static final id =
      QueryIntegerProperty<EmailObjectBox>(_entities[7].properties[0]);

  /// see [EmailObjectBox.raw]
  static final raw =
      QueryStringProperty<EmailObjectBox>(_entities[7].properties[1]);

  /// see [EmailObjectBox.email]
  static final email =
      QueryStringProperty<EmailObjectBox>(_entities[7].properties[2]);

  /// see [EmailObjectBox.isCurrent]
  static final isCurrent =
      QueryBooleanProperty<EmailObjectBox>(_entities[7].properties[3]);

  /// see [EmailObjectBox.timestamp]
  static final timestamp =
      QueryIntegerProperty<EmailObjectBox>(_entities[7].properties[4]);
}

/// [FileObjectBox] entity fields to define ObjectBox queries.
class FileObjectBox_ {
  /// see [FileObjectBox.id]
  static final id =
      QueryIntegerProperty<FileObjectBox>(_entities[8].properties[0]);

  /// see [FileObjectBox.profile]
  static final profile = QueryRelationToOne<FileObjectBox, ProfileObjectBox>(
      _entities[8].properties[1]);

  /// see [FileObjectBox.raw]
  static final raw =
      QueryStringProperty<FileObjectBox>(_entities[8].properties[2]);

  /// see [FileObjectBox.uri]
  static final uri =
      QueryStringProperty<FileObjectBox>(_entities[8].properties[3]);

  /// see [FileObjectBox.metadata]
  static final metadata =
      QueryStringProperty<FileObjectBox>(_entities[8].properties[4]);

  /// see [FileObjectBox.timestamp]
  static final timestamp =
      QueryIntegerProperty<FileObjectBox>(_entities[8].properties[5]);

  /// see [FileObjectBox.thumbnail]
  static final thumbnail =
      QueryStringProperty<FileObjectBox>(_entities[8].properties[6]);
}

/// [FriendObjectBox] entity fields to define ObjectBox queries.
class FriendObjectBox_ {
  /// see [FriendObjectBox.id]
  static final id =
      QueryIntegerProperty<FriendObjectBox>(_entities[9].properties[0]);

  /// see [FriendObjectBox.profile]
  static final profile = QueryRelationToOne<FriendObjectBox, ProfileObjectBox>(
      _entities[9].properties[1]);

  /// see [FriendObjectBox.timestamp]
  static final timestamp =
      QueryIntegerProperty<FriendObjectBox>(_entities[9].properties[2]);

  /// see [FriendObjectBox.raw]
  static final raw =
      QueryStringProperty<FriendObjectBox>(_entities[9].properties[3]);

  /// see [FriendObjectBox.dbFriendType]
  static final dbFriendType =
      QueryIntegerProperty<FriendObjectBox>(_entities[9].properties[4]);
}

/// [GroupObjectBox] entity fields to define ObjectBox queries.
class GroupObjectBox_ {
  /// see [GroupObjectBox.id]
  static final id =
      QueryIntegerProperty<GroupObjectBox>(_entities[10].properties[0]);

  /// see [GroupObjectBox.profile]
  static final profile = QueryRelationToOne<GroupObjectBox, ProfileObjectBox>(
      _entities[10].properties[1]);

  /// see [GroupObjectBox.raw]
  static final raw =
      QueryStringProperty<GroupObjectBox>(_entities[10].properties[2]);

  /// see [GroupObjectBox.name]
  static final name =
      QueryStringProperty<GroupObjectBox>(_entities[10].properties[3]);

  /// see [GroupObjectBox.isUsers]
  static final isUsers =
      QueryBooleanProperty<GroupObjectBox>(_entities[10].properties[4]);

  /// see [GroupObjectBox.badge]
  static final badge =
      QueryStringProperty<GroupObjectBox>(_entities[10].properties[5]);

  /// see [GroupObjectBox.timestamp]
  static final timestamp =
      QueryIntegerProperty<GroupObjectBox>(_entities[10].properties[6]);
}

/// [ImageObjectBox] entity fields to define ObjectBox queries.
class ImageObjectBox_ {
  /// see [ImageObjectBox.id]
  static final id =
      QueryIntegerProperty<ImageObjectBox>(_entities[11].properties[0]);

  /// see [ImageObjectBox.profile]
  static final profile = QueryRelationToOne<ImageObjectBox, ProfileObjectBox>(
      _entities[11].properties[1]);

  /// see [ImageObjectBox.uri]
  static final uri =
      QueryStringProperty<ImageObjectBox>(_entities[11].properties[2]);

  /// see [ImageObjectBox.metadata]
  static final metadata =
      QueryStringProperty<ImageObjectBox>(_entities[11].properties[3]);

  /// see [ImageObjectBox.timestamp]
  static final timestamp =
      QueryIntegerProperty<ImageObjectBox>(_entities[11].properties[4]);

  /// see [ImageObjectBox.title]
  static final title =
      QueryStringProperty<ImageObjectBox>(_entities[11].properties[5]);

  /// see [ImageObjectBox.description]
  static final description =
      QueryStringProperty<ImageObjectBox>(_entities[11].properties[6]);

  /// see [ImageObjectBox.raw]
  static final raw =
      QueryStringProperty<ImageObjectBox>(_entities[11].properties[7]);
}

/// [LifeEventObjectBox] entity fields to define ObjectBox queries.
class LifeEventObjectBox_ {
  /// see [LifeEventObjectBox.id]
  static final id =
      QueryIntegerProperty<LifeEventObjectBox>(_entities[12].properties[0]);

  /// see [LifeEventObjectBox.raw]
  static final raw =
      QueryStringProperty<LifeEventObjectBox>(_entities[12].properties[1]);

  /// see [LifeEventObjectBox.profile]
  static final profile =
      QueryRelationToOne<LifeEventObjectBox, ProfileObjectBox>(
          _entities[12].properties[2]);

  /// see [LifeEventObjectBox.title]
  static final title =
      QueryStringProperty<LifeEventObjectBox>(_entities[12].properties[3]);

  /// see [LifeEventObjectBox.place]
  static final place = QueryRelationToOne<LifeEventObjectBox, PlaceObjectBox>(
      _entities[12].properties[4]);
}

/// [LinkObjectBox] entity fields to define ObjectBox queries.
class LinkObjectBox_ {
  /// see [LinkObjectBox.id]
  static final id =
      QueryIntegerProperty<LinkObjectBox>(_entities[13].properties[0]);

  /// see [LinkObjectBox.uri]
  static final uri =
      QueryStringProperty<LinkObjectBox>(_entities[13].properties[1]);

  /// see [LinkObjectBox.metadata]
  static final metadata =
      QueryStringProperty<LinkObjectBox>(_entities[13].properties[2]);

  /// see [LinkObjectBox.timestamp]
  static final timestamp =
      QueryIntegerProperty<LinkObjectBox>(_entities[13].properties[3]);

  /// see [LinkObjectBox.profile]
  static final profile = QueryRelationToOne<LinkObjectBox, ProfileObjectBox>(
      _entities[13].properties[4]);

  /// see [LinkObjectBox.source]
  static final source =
      QueryStringProperty<LinkObjectBox>(_entities[13].properties[5]);

  /// see [LinkObjectBox.raw]
  static final raw =
      QueryStringProperty<LinkObjectBox>(_entities[13].properties[6]);
}

/// [PageObjectBox] entity fields to define ObjectBox queries.
class PageObjectBox_ {
  /// see [PageObjectBox.id]
  static final id =
      QueryIntegerProperty<PageObjectBox>(_entities[14].properties[0]);

  /// see [PageObjectBox.raw]
  static final raw =
      QueryStringProperty<PageObjectBox>(_entities[14].properties[1]);

  /// see [PageObjectBox.profile]
  static final profile = QueryRelationToOne<PageObjectBox, ProfileObjectBox>(
      _entities[14].properties[2]);

  /// see [PageObjectBox.name]
  static final name =
      QueryStringProperty<PageObjectBox>(_entities[14].properties[3]);

  /// see [PageObjectBox.isUsers]
  static final isUsers =
      QueryBooleanProperty<PageObjectBox>(_entities[14].properties[4]);

  /// see [PageObjectBox.uri]
  static final uri =
      QueryStringProperty<PageObjectBox>(_entities[14].properties[5]);
}

/// [PersonObjectBox] entity fields to define ObjectBox queries.
class PersonObjectBox_ {
  /// see [PersonObjectBox.id]
  static final id =
      QueryIntegerProperty<PersonObjectBox>(_entities[15].properties[0]);

  /// see [PersonObjectBox.profile]
  static final profile = QueryRelationToOne<PersonObjectBox, ProfileObjectBox>(
      _entities[15].properties[1]);

  /// see [PersonObjectBox.raw]
  static final raw =
      QueryStringProperty<PersonObjectBox>(_entities[15].properties[2]);

  /// see [PersonObjectBox.name]
  static final name =
      QueryStringProperty<PersonObjectBox>(_entities[15].properties[3]);

  /// see [PersonObjectBox.uri]
  static final uri =
      QueryStringProperty<PersonObjectBox>(_entities[15].properties[4]);
}

/// [PlaceObjectBox] entity fields to define ObjectBox queries.
class PlaceObjectBox_ {
  /// see [PlaceObjectBox.id]
  static final id =
      QueryIntegerProperty<PlaceObjectBox>(_entities[16].properties[0]);

  /// see [PlaceObjectBox.profile]
  static final profile = QueryRelationToOne<PlaceObjectBox, ProfileObjectBox>(
      _entities[16].properties[1]);

  /// see [PlaceObjectBox.raw]
  static final raw =
      QueryStringProperty<PlaceObjectBox>(_entities[16].properties[2]);

  /// see [PlaceObjectBox.name]
  static final name =
      QueryStringProperty<PlaceObjectBox>(_entities[16].properties[3]);

  /// see [PlaceObjectBox.address]
  static final address =
      QueryStringProperty<PlaceObjectBox>(_entities[16].properties[4]);

  /// see [PlaceObjectBox.coordinate]
  static final coordinate =
      QueryRelationToOne<PlaceObjectBox, CoordinateObjectBox>(
          _entities[16].properties[5]);

  /// see [PlaceObjectBox.uri]
  static final uri =
      QueryStringProperty<PlaceObjectBox>(_entities[16].properties[6]);
}

/// [PollObjectBox] entity fields to define ObjectBox queries.
class PollObjectBox_ {
  /// see [PollObjectBox.id]
  static final id =
      QueryIntegerProperty<PollObjectBox>(_entities[17].properties[0]);

  /// see [PollObjectBox.profile]
  static final profile = QueryRelationToOne<PollObjectBox, ProfileObjectBox>(
      _entities[17].properties[1]);

  /// see [PollObjectBox.raw]
  static final raw =
      QueryStringProperty<PollObjectBox>(_entities[17].properties[2]);

  /// see [PollObjectBox.timestamp]
  static final timestamp =
      QueryIntegerProperty<PollObjectBox>(_entities[17].properties[3]);

  /// see [PollObjectBox.question]
  static final question =
      QueryStringProperty<PollObjectBox>(_entities[17].properties[4]);

  /// see [PollObjectBox.isUsers]
  static final isUsers =
      QueryBooleanProperty<PollObjectBox>(_entities[17].properties[5]);

  /// see [PollObjectBox.options]
  static final options =
      QueryStringProperty<PollObjectBox>(_entities[17].properties[6]);
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

  /// see [PostObjectBox.event]
  static final event = QueryRelationToOne<PostObjectBox, EventObjectBox>(
      _entities[18].properties[6]);

  /// see [PostObjectBox.group]
  static final group = QueryRelationToOne<PostObjectBox, GroupObjectBox>(
      _entities[18].properties[7]);

  /// see [PostObjectBox.poll]
  static final poll = QueryRelationToOne<PostObjectBox, PollObjectBox>(
      _entities[18].properties[8]);

  /// see [PostObjectBox.lifeEvent]
  static final lifeEvent =
      QueryRelationToOne<PostObjectBox, LifeEventObjectBox>(
          _entities[18].properties[9]);

  /// see [PostObjectBox.isArchived]
  static final isArchived =
      QueryBooleanProperty<PostObjectBox>(_entities[18].properties[10]);

  /// see [PostObjectBox.meta]
  static final meta =
      QueryStringProperty<PostObjectBox>(_entities[18].properties[11]);

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

/// [ReactionObjectBox] entity fields to define ObjectBox queries.
class ReactionObjectBox_ {
  /// see [ReactionObjectBox.id]
  static final id =
      QueryIntegerProperty<ReactionObjectBox>(_entities[19].properties[0]);

  /// see [ReactionObjectBox.raw]
  static final raw =
      QueryStringProperty<ReactionObjectBox>(_entities[19].properties[1]);

  /// see [ReactionObjectBox.reaction]
  static final reaction =
      QueryStringProperty<ReactionObjectBox>(_entities[19].properties[2]);
}

/// [TagObjectBox] entity fields to define ObjectBox queries.
class TagObjectBox_ {
  /// see [TagObjectBox.id]
  static final id =
      QueryIntegerProperty<TagObjectBox>(_entities[20].properties[0]);

  /// see [TagObjectBox.name]
  static final name =
      QueryStringProperty<TagObjectBox>(_entities[20].properties[1]);
}

/// [VideoObjectBox] entity fields to define ObjectBox queries.
class VideoObjectBox_ {
  /// see [VideoObjectBox.id]
  static final id =
      QueryIntegerProperty<VideoObjectBox>(_entities[21].properties[0]);

  /// see [VideoObjectBox.profile]
  static final profile = QueryRelationToOne<VideoObjectBox, ProfileObjectBox>(
      _entities[21].properties[1]);

  /// see [VideoObjectBox.uri]
  static final uri =
      QueryStringProperty<VideoObjectBox>(_entities[21].properties[2]);

  /// see [VideoObjectBox.metadata]
  static final metadata =
      QueryStringProperty<VideoObjectBox>(_entities[21].properties[3]);

  /// see [VideoObjectBox.timestamp]
  static final timestamp =
      QueryIntegerProperty<VideoObjectBox>(_entities[21].properties[4]);

  /// see [VideoObjectBox.title]
  static final title =
      QueryStringProperty<VideoObjectBox>(_entities[21].properties[5]);

  /// see [VideoObjectBox.description]
  static final description =
      QueryStringProperty<VideoObjectBox>(_entities[21].properties[6]);

  /// see [VideoObjectBox.thumbnail]
  static final thumbnail =
      QueryStringProperty<VideoObjectBox>(_entities[21].properties[7]);

  /// see [VideoObjectBox.raw]
  static final raw =
      QueryStringProperty<VideoObjectBox>(_entities[21].properties[8]);
}
