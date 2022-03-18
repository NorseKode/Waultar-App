import 'dart:io';

import 'package:tuple/tuple.dart';
import 'package:waultar/core/models/index.dart';

abstract class BaseParser {
  /// Parses a single [file]
  ///
  /// Throws an [ParseException] if something unexpected in encountered
  Stream<dynamic> parseFile(File file, {ProfileModel profile});

  /// Parses a single [file] and looks for a specific [key]
  ///
  /// Throws an [ParseException] if something unexpected in encountered
  Stream<dynamic> parseFileLookForKey(File file, String key);

  /// Takes a list of [paths] and removes the files fully used in the creation of the profile
  ///
  /// An optional service can be given if a service needs to be connected to the profile
  /// Throws an [ParseException] if something unexpected in encountered
  Future<Tuple2<ProfileModel, List<String>>> parseProfile(List<String> paths,
      {ServiceModel? service});

  /// Only relevant for parsing of Facebook data
  /// Takes a list of [paths], finds the relevant file to parse group names and timestamps
  /// Returns a List of GroupModels to be inserted in db via one transaction
  /// These group names will be used later for parsing of group activity
  Future<Tuple2<List<GroupModel>, List<String>>> parseGroupNames(
      List<String> paths, ProfileModel profile);

  /// Parses a list of [paths] and returns the models that is found
  ///
  /// Throws an [ParseException] if something unexpected in encountered
  Stream<dynamic> parseListOfPaths(List<String> paths, ProfileModel profile);

  /// Parses all files in [directory]
  ///
  /// Takes a directory [directory] and reads all files in said directory.
  /// Followed by an parsing of every file in said directory
  ///
  /// Throws an [ParseException] if something unexpected in encountered
  Stream<dynamic> parseDirectory(Directory directory);
}

enum DataTypes { unknown, post, media }
