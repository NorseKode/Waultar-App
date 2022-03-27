import 'package:waultar/core/abstracts/abstract_services/i_sentiment_service.dart';

import 'package:waultar/core/ai/sentiment_classifier.dart';
import 'package:waultar/core/inodes/datapoint_repo.dart';

import 'package:waultar/core/inodes/profile_document.dart';
import 'package:waultar/core/inodes/profile_repo.dart';
import 'package:waultar/core/inodes/tree_nodes.dart';
import 'package:waultar/startup.dart';

class SentimentService extends ISentimentService {
  final _dataRepo = locator.get<DataPointRepository>(instanceName: 'dataRepo');
  final _profileRepo =
      locator.get<ProfileRepository>(instanceName: 'profileRepo');
  final _textClassifier =
      locator.get<SentimentClassifier>(instanceName: 'sentimentClassifier');

  @override
  Future<void> connotateAllTextSeparateThreadFromDB() {
    // TODO: implement connotateAllTextSeparateThreadFromDB
    throw UnimplementedError();
  }

  @override
  double connotateText(String text) {
    return double.parse(_textClassifier
        .classify(text)
        .last
        .toStringAsFixed(2)); //percent positive text
  }

  @override
  int connotateTextsFromCategory(List<DataCategory> categories) {
    var updated = 0;
    for (var category in categories) {
      List<DataPoint> dataPoints = _dataRepo.readAllFromCategory(category);

      for (var point in dataPoints) {
        var sentimentScore = _textClassifier.classify(point.stringName);
        point.sentimentScore = sentimentScore.last; //0-1
        _dataRepo.updateDataPoint(point);
        updated++;
      }
    }

    return updated;
  }

  @override
  List<ProfileDocument> getAllProfiles() {
    return _profileRepo.getAll();
  }
}
