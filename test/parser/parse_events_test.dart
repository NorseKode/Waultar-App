import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart' as path_dart;
import 'package:waultar/core/models/index.dart';
import 'package:waultar/core/parsers/facebook_parser.dart';

import '../test_helper.dart';

main() {
  
  var facebookProfilev2 = File(path_dart.join(
      TestHelper.pathToCurrentFile(), "data", "v2_profile_information.json"));
  var eventInvitations = File(path_dart.join(
      TestHelper.pathToCurrentFile(), "data", "event_invitations.json"));
  var eventResponses = File(path_dart.join(
      TestHelper.pathToCurrentFile(), "data", "your_event_responses.json"));
  var yourEvents = File(path_dart.join(
      TestHelper.pathToCurrentFile(), "data", "your_events.json"));

  late final FacebookParser parser;

  setUpAll(() {
    TestHelper.clearTestLogger();
    TestHelper.createTestLogger();
    parser = FacebookParser();
  });

  group("Testing parsing of event data: ", () {

    test('parse events belonging to user from your_events.json', () async {
      var profile = (await parser.parseProfile([facebookProfilev2.path])).item1;

      var result = parser.parseFile(yourEvents, profile: profile);
      var userEventsStream = result.cast<EventModel>();
      var userEvents = await userEventsStream.toList();

      expect(userEvents.length, 2);
      expect(userEvents.first.name, 'Test event 1');
      expect(userEvents.last.name, 'Coding camp at ITU');
      expect(userEvents.last.description, 'Hosted by Thore');
      expect(userEvents.first.isUsers, true);
      expect(userEvents.last.isUsers, true);
      expect(userEvents.first.place != null, true);
      expect(userEvents.first.place!.address, null);
      expect(userEvents.first.place!.name, 'Rued Langgaardsvej 7');
      expect(userEvents.first.place!.coordinate!.latitude, 55.659964);
    });

    test('parse events invitations from event_invitations.json', () async {
      var profile = (await parser.parseProfile([facebookProfilev2.path])).item1;

      var result = parser.parseFile(eventInvitations, profile: profile);
      var userEventsStream = result.cast<EventModel>();
      var userEvents = await userEventsStream.toList();

      expect(userEvents.length, 6);
      expect(userEvents.first.createdTimestamp, null);
      expect(userEvents.first.name, 'Event 1');
    });
    test('parse events responses from your_event_responses.json', () async {
      var profile = (await parser.parseProfile([facebookProfilev2.path])).item1;

      var result = parser.parseFile(eventResponses, profile: profile);
      var userEventsStream = result.cast<EventModel>();
      var userEvents = await userEventsStream.toList();

      expect(userEvents.length, 8);
      expect(userEvents.first.createdTimestamp, null);
      expect(userEvents.first.name, 'Event 1');
      expect(userEvents.first.response, EventResponse.joined);
      expect(userEvents.where((element) => element.response == EventResponse.joined).length, 4);
      expect(userEvents.where((element) => element.response == EventResponse.declined).length, 2);
      expect(userEvents.where((element) => element.response == EventResponse.interested).length, 2);
    });

  });
}
