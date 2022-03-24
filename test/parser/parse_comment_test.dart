

main() {
  // var facebookProfile = TestHelper.facebookProfile;
  // var instagramProfile = TestHelper.instagramProfile;
  // var facebookComments = path_dart.join(
  //   TestHelper.pathToCurrentFile(),
  //   "data",
  //   "facebook_comments.json",
  // );
  // var instagramComments = path_dart.join(
  //   TestHelper.pathToCurrentFile(),
  //   "data",
  //   "post_comments.json",
  // );
  // late final TreeParser _parser;

  // setUpAll(() async {
  //   _parser = await TestHelper.getTreeParser();
  //   TestHelper.clearTestLogger();
  //   TestHelper.createTestLogger();
  // });

  // group("Parsing of comments: ", () {
  //   test("Facebook comments: ", () async {
  //     var results = await _parser.parsePath(
  //       facebookComments,
  //       TestHelper.profileDocument,
  //       TestHelper.serviceDocument,
  //     );

  //     var comments = <DataPoint>[];
  //     expect(results.dataPoints.length, 8);

  //     expect(results.children.length, 3);
  //     results.children.forEach((element) {
  //       comments.addAll(element.dataPoints);
  //     });

  //     expect(comments.length, 8);

  //     expect(comments[0].asMap["group"], "REDACTED GROUP");
  //     expect(comments[1].asMap["comment"], "REDACTED COMMENT");
  //     expect(comments[1].asMap["title"].contains("REDACTED PERSON"), true);
  //     expect(comments[2].images.isNotEmpty, true);
  //     expect(comments[3].links.isNotEmpty, true);
  //     expect(comments[4].videos.isNotEmpty, true);
  //     expect(comments[5].asMap["title"].contains("PROFILE"), true);
  //     expect(comments[7].asMap["name"], "REDACTED NAME");
  //   });

  //   test('Instagram comments: ', () async {
  //     var results = await _parser.parsePath(
  //       instagramComments,
  //       TestHelper.profileDocument,
  //       TestHelper.serviceDocument,
  //     );
      
  //     var comments = <DataPoint>[];

  //     results.children.forEach((element) {
  //       comments.addAll(element.dataPoints);
  //     });

  //     expect(comments.length, 2);

  //     var comment1 = comments[0].asMap;
  //     var comment2 = comments[1].asMap;

  //     expect(comment1["value"], "The comment");
  //     expect(comment2["value"], "The comment");
  //     expect(comment1["title"], "username");
  //     expect(comment2["title"], "username");
  //     expect(comment1["timestamp"], ModelHelper.intToTimestamp(1550618520));
  //     expect(comment2["timestamp"], ModelHelper.intToTimestamp(1550712540));
  //   });
  // });
}
