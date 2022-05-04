import 'package:flutter/material.dart';
import 'package:pretty_json/pretty_json.dart';
import 'package:waultar/configs/globals/app_logger.dart';
import 'package:waultar/configs/globals/category_enums.dart';
import 'package:waultar/core/helpers/performance_helper.dart';
import 'package:waultar/core/models/ui_model.dart';
import 'package:waultar/data/configs/objectbox.dart';
import 'package:waultar/data/configs/objectbox.g.dart';
import 'package:waultar/data/entities/misc/profile_document.dart';
import 'package:waultar/data/entities/nodes/category_node.dart';
import 'package:waultar/data/entities/nodes/datapoint_node.dart';
import 'package:waultar/startup.dart';

class DataPointRepository {
  final ObjectBox _context;
  late final Box<DataPoint> _dataBox;
  final _performance = locator.get<PerformanceHelper>(instanceName: 'performance');
  final _logger = locator.get<BaseLogger>(instanceName: 'logger');

  DataPointRepository(this._context) {
    _dataBox = _context.store.box<DataPoint>();
  }

  int addDataPoint(DataPoint dataPoint) => _dataBox.put(dataPoint);
  List<int> addMany(List<DataPoint> dataPoints) => _dataBox.putMany(dataPoints);
  List<DataPoint> readAll() => _dataBox.getAll();
  int count() => _dataBox.count();

  List<DataPoint> readAllFromCategory(DataCategory category) {
    var query = _dataBox.query(DataPoint_.category.equals(category.id)).build().find();
    return query;
  }

  List<DataPoint> readAllFromCategoryPagination(DataCategory category, int offset, int limit) {
    var query = _dataBox.query(DataPoint_.category.equals(category.id)).build();

    query
      ..offset = offset
      ..limit = limit;

    return query.find();
  }

  List<UIDTO> search(List<int> categoryIds, List<int> profileIds, String searchString, int offset, int limit) {
    var builder = _dataBox.query(
      DataPoint_.searchTerms.contains(
        searchString,
        caseSensitive: false,
      ),
    );
    builder.link(
      DataPoint_.category,
      DataCategory_.dbCategory.oneOf(categoryIds),
    );

    var amountOfProfiles = _context.store.box<ProfileDocument>().getAll().length;
    if (amountOfProfiles > profileIds.length) {
      builder.link(DataPoint_.profile, ProfileDocument_.id.oneOf(profileIds));
    }

    var query = builder.build();

    query
      ..offset = offset
      ..limit = limit;

    var result = query.find().map((e) => e.getUIDTO).toList();

    return result;
  }

  int readAllSentimentCategory(int categoryId) {
    var query = _dataBox
        .query(DataPoint_.category
            .equals(categoryId)
            .and(DataPoint_.sentimentText.notNull())
            .and(DataPoint_.sentimentText.notEquals(""))
            .and(DataPoint_.sentimentScore.isNull()))
        .build()
        .count();
    return query;
  }

  List<ScatterSentimentDTO> getDataPointsWithSentiment(List<ProfileDocument> profiles) {
    var profileIds = profiles.map((e) => e.id).toList();
    var builder = _dataBox.query(DataPoint_.timestamp
        .notNull()
        .and(DataPoint_.sentimentScore.notNull())
        .and(DataPoint_.sentimentText.notNull()))
      ..link(DataPoint_.profile, ProfileDocument_.id.oneOf(profileIds));

    builder.order(DataPoint_.timestamp);
    var result = builder.build().find();

    var listToReturn = <ScatterSentimentDTO>[];
    for (var datapoint in result) {
      listToReturn.add(ScatterSentimentDTO.fromDataPoint(datapoint));
    }

    return listToReturn;
  }
}

class ScatterSentimentDTO {
  late DateTime timeStamp;
  late double sentimentScore;
  late String sentimentText;
  late CategoryEnum category;
  late String path;
  late String userName;

  ScatterSentimentDTO.fromDataPoint(DataPoint dataPoint) {
    timeStamp = dataPoint.timestamp!;
    sentimentScore = dataPoint.sentimentScore!;
    sentimentText = dataPoint.sentimentText!;
    category = dataPoint.category.target!.category;
    path = dataPoint.path;
    userName = dataPoint.profile.target!.name;
  }
}

class UIDTO implements UIModel {
  final DataPoint dataPoint;
  late Color associatedColor;
  late String mostInformativeField;
  late DateTime timeStamp;
  late String path;

  UIDTO({required this.dataPoint}) {
    associatedColor = dataPoint.category.target!.category.color;
    path = dataPoint.path;
  }

  @override
  Color getAssociatedColor() {
    return associatedColor;
  }

  @override
  String getMostInformativeField() {
    return dataPoint.stringName;
  }

  @override
  DateTime? getTimestamp() {
    return null;
  }

  @override
  Map<String, dynamic> toMap() {
    return dataPoint.asMap;
  }

  @override
  String toString() {
    return 'Path: $path \n${prettyJson(dataPoint.asMap)}';
  }
}
