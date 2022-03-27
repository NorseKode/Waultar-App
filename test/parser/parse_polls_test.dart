


main() {
  // var facebookProfile = TestHelper.facebookProfile;
  // var facebookPolls =
  //     File(path_dart.join(TestHelper.pathToCurrentFile(), "data", "polls_you_voted_on.json"));
  // var facebookGroups =
  //     File(path_dart.join(TestHelper.pathToCurrentFile(), "data", "your_posts_in_groups.json"));

  // setUpAll(() {
  //   TestHelper.clearTestLogger();
  //   TestHelper.createTestLogger();
  // });

  // group("Parsing of polls: ", () {
  //   test('Facebook polls', () async {
  //     var polls = await FacebookParser().parseFile(facebookPolls, profile: facebookProfile).toList();

  //     expect(polls.length, 2);

  //     var poll1 = polls[0] as PostPollModel;
  //     var poll2 = polls[1] as PostPollModel;

  //     expect(poll1.post.title, "The user voted on some other user's poll.");
  //     expect(poll2.post.title, "The user voted on same or other user's poll.");
  //     expect(poll1.post.description, null);
  //     expect(poll2.post.description, "Option question");
  //     expect(poll1.options!.length, 2);
  //     expect(poll2.options!.length, 8);
  //     expect(poll1.isUsers, false);
  //     expect(poll2.isUsers, true);
  //     expect(poll1.timestamp, ModelHelper.intToTimestamp(1507814224));
  //     expect(poll2.timestamp, ModelHelper.intToTimestamp(1505670564));
  //   });

  //   test('Facebook polls in groups', () async {
  //     var results = await FacebookParser().parseFile(facebookGroups, profile: facebookProfile).toList();

  //     var polls = results.whereType<PostPollModel>();

  //     expect(polls.length, 1);

  //     var poll = polls.first;

  //     expect(poll.post.title, "REDACTED TITLE");
  //     expect(poll.post.description, "REDACTED QUESTION");
  //     expect(poll.options!.length, 4);
  //     expect(poll.isUsers, true);
  //     expect(poll.timestamp, ModelHelper.intToTimestamp(1449761175));
  //   });
  // });
}
