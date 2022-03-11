import 'package:flutter_test/flutter_test.dart';
import 'package:waultar/presentation/screens/temp/file_sorting.dart';

import 'classifier.dart';

void main() {
  group('Welp', () {
    test('welp2', () {
      var classifier = Classifier();

      print(classifier.classify("This shit is nice"));
    });
  });
}
