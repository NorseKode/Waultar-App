import 'package:flutter_test/flutter_test.dart';

main() {
  // var pathToCurrentFile = path_dart
  //     .normalize(path_dart.join(
  //         path_dart.dirname(Platform.script.path), "test", "parser"))
  //     .substring(1);

  // var emptyObject =
  //     File(path_dart.join(pathToCurrentFile, "data", "empty_object.json"));
  // var emptyList =
  //     File(path_dart.join(pathToCurrentFile, "data", "empty_list.json"));
  // var corrupted =
  //     File(path_dart.join(pathToCurrentFile, "data", "corrupt.json"));
  // // var mediaJson1 = File(path_dart.join(pathToCurrentFile, "data", "each_media_type_list.json"));
  // var facebookProfile =
  //     File(path_dart.join(pathToCurrentFile, "data", "facebook_profile.json"));
  // var instagramProfile =
  //     File(path_dart.join(pathToCurrentFile, "data", "instagram_profile.json"));

  // parserRunner<T>(
  //     Function(File file) parser, File fileToRun, String key) async {
  //   var result = await parser(fileToRun);

  //   var object = result[key] as T;

  //   return object;
  // }

  group("Initial testing of edge cases with: ", () {
  //   test("empty json object", () async {
  //     var result = await NaiveParser.parseFile(emptyObject);

  //     var images = result["Images"] as List<ImageModel>;

  //     expect(images.isEmpty, true);
  //   });

  //   test("empty json list", () async {
  //     var result = await NaiveParser.parseFile(emptyList);

  //     var images = result["Images"] as List<ImageModel>;

  //     expect(images.isEmpty, true);
  //   });

  //   test("corrupted json", () async {
  //     expect(
  //         () async => await NaiveParser.parseFile(corrupted), throwsException);
  //   });
  // });

  // // group("Tests of json containing media. ", () {
  // //   test("Json containing one of each media", () async {
  // //     var result = await NaiveParser.parseFile(mediaJson1);

  // //     var images = result["Images"] as List<ImageModel>;

  // //     expect(images.length, 2);
  // //   });
  // // });

  // group("Parsing of profile data: ", () {
  //   test("Facebook profile v2", () async {
  //     var result = await parserRunner<ProfileModel?>(
  //         NaiveParser.parseFile, facebookProfile, "Profile");

  //     expect(result!.username, "");
  //     expect(result.name, "REDACTED FULLNAME");
  //     expect(result.email, "REDACTED@MAIL.COM");
  //     expect(result.gender, "MALE");
  //     expect(result.bio, "");
  //     expect(result.phoneNumber, "12345678");
  //     expect(result.dateOfBirth, "2021-02-12");
  //     expect(result.profileUri, "https://www.facebook.com/profile");
  //   });

  //   test("Instagram profile", () async {
  //     var result = await parserRunner<ProfileModel?>(
  //         NaiveParser.parseFile, instagramProfile, "Profile");

  //     expect(result != null, true);
  //     expect(result!.username, "REDACTED USERNAME");
  //     expect(result.email, "REDACTED@MAIL.COM");
  //     expect(result.gender, "male");
  //     expect(result.bio, "REDACTED BIO");
  //     expect(result.phoneNumber, "12345678");
  //     expect(result.dateOfBirth, "2021-02-12");
  //     expect(result.profileUri, "");
  //   });
  });
}
