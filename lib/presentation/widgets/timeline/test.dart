import 'dart:core';

import 'package:waultar/core/models/content/post_model.dart';
import 'package:waultar/core/models/media/image_model.dart';
import 'package:waultar/core/models/ui_model.dart';
import 'package:waultar/core/parsers/parse_helper.dart';

abstract class Weekdays {
  static String mon = "Mon";
  static String tue = "Tue";
  static String wed = "Wed";
  static String thu = "Thu";
  static String fri = "Fri";
  static String sat = "Sat";
  static String sun = "Sun";
}

enum Months { jan, feb, mar, apr, may, jun, jul, aug, sep, nov, dec }

//Time, Category, Models
Map<String, List<List<UIModel>>> list = {
  Weekdays.mon: [
    List.generate(
        10,
        (index) => PostModel(
            profile: ParseHelper.profile,
            raw: "",
            timestamp: DateTime.now())), //Post
    List.generate(
        2,
        (index) => ImageModel(
            profile: ParseHelper.profile, raw: "", uri: Uri(path: ""))), //Image
  ],
  Weekdays.tue: [
    List.generate(
        7,
        (index) => PostModel(
            profile: ParseHelper.profile,
            raw: "",
            timestamp: DateTime.now())), //Post
    List.generate(
        2,
        (index) => ImageModel(
            profile: ParseHelper.profile, raw: "", uri: Uri(path: ""))), //Image
  ],
  Weekdays.wed: [
    List.generate(
        12,
        (index) => PostModel(
            profile: ParseHelper.profile,
            raw: "",
            timestamp: DateTime.now())), //Post
    List.generate(
        6,
        (index) => ImageModel(
            profile: ParseHelper.profile, raw: "", uri: Uri(path: ""))), //Image
  ],
  Weekdays.thu: [
    List.generate(
        1,
        (index) => PostModel(
            profile: ParseHelper.profile,
            raw: "",
            timestamp: DateTime.now())), //Post
    List.generate(
        8,
        (index) => ImageModel(
            profile: ParseHelper.profile, raw: "", uri: Uri(path: ""))), //Image
  ],
  Weekdays.fri: [
    List.generate(
        10,
        (index) => PostModel(
            profile: ParseHelper.profile,
            raw: "",
            timestamp: DateTime.now())), //Post
    List.generate(
        12,
        (index) => ImageModel(
            profile: ParseHelper.profile, raw: "", uri: Uri(path: ""))), //Image
  ],
  Weekdays.sat: [
    List.generate(
        48,
        (index) => PostModel(
            profile: ParseHelper.profile,
            raw: "",
            timestamp: DateTime.now())), //Post
    List.generate(
        1,
        (index) => ImageModel(
            profile: ParseHelper.profile, raw: "", uri: Uri(path: ""))), //Image
  ],
  Weekdays.sun: [
    List.generate(
        1,
        (index) => PostModel(
            profile: ParseHelper.profile,
            raw: "",
            timestamp: DateTime.now())), //Post
    List.generate(
        48,
        (index) => ImageModel(
            profile: ParseHelper.profile, raw: "", uri: Uri(path: ""))), //Image
  ],
};
