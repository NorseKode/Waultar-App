import 'package:flutter_test/flutter_test.dart';
import 'package:waultar/configs/extensions/noresekode_list_extension.dart';

void main() {
  var testList0 = List.generate(0, (index) => index);
  var testList1 = List.generate(1, (index) => index);
  var testList2 = List.generate(2, (index) => index);
  var testList3 = List.generate(3, (index) => index);
  var testList4 = List.generate(4, (index) => index);
  var testList5 = List.generate(5, (index) => index);
  var testList6 = List.generate(6, (index) => index);

  setUpAll(() {
    testList0 = List.generate(0, (index) => index);
    testList1 = List.generate(1, (index) => index);
    testList2 = List.generate(2, (index) => index);
    testList3 = List.generate(3, (index) => index);
    testList4 = List.generate(4, (index) => index);
    testList5 = List.generate(5, (index) => index);
    testList6 = List.generate(6, (index) => index);
  });

  group('Test of NorseKode List extension splitEqualVerbose(int splits)', () {
    test('List of length 0', () {
      var result1 = testList0.splitEqualVerbose(splits: 1);
      var result2 = testList0.splitEqualVerbose(splits: 2);
      var result3 = testList0.splitEqualVerbose(splits: 3);

      expect(result1.length, 0);
      expect(result2.length, 0);
      expect(result3.length, 0);
    });

    test('List of length 1', () {
      var result1 = testList1.splitEqualVerbose(splits: 1);
      var result2 = testList1.splitEqualVerbose(splits: 2);
      var result3 = testList1.splitEqualVerbose(splits: 3);

      expect(result1.length, 1);

      expect(result1[0].item1, 0);
      expect(result1[0].item2, 1);

      expect(result2.length, 0);
      expect(result3.length, 0);
    });

    test('List of length 2', () {
      var result1 = testList2.splitEqualVerbose(splits: 1);
      var result2 = testList2.splitEqualVerbose(splits: 2);
      var result3 = testList2.splitEqualVerbose(splits: 3);

      expect(result1.length, 1);
      expect(result1[0].item1, 0);
      expect(result1[0].item2, 2);

      expect(result2.length, 2);
      expect(result2[0].item1, 0);
      expect(result2[0].item2, 1);
      expect(result2[1].item1, 1);
      expect(result2[1].item2, 2);

      expect(result3.length, 0);
    });

    test('List of length 3', () {
      var result1 = testList3.splitEqualVerbose(splits: 1);
      var result2 = testList3.splitEqualVerbose(splits: 2);
      var result3 = testList3.splitEqualVerbose(splits: 3);

      expect(result1.length, 1);
      expect(result1[0].item1, 0);
      expect(result1[0].item2, 3);

      expect(result2.length, 2);
      expect(result2[0].item1, 0);
      expect(result2[0].item2, 1);
      expect(result2[1].item1, 1);
      expect(result2[1].item2, 3);

      expect(result3.length, 3);
      expect(result3[0].item1, 0);
      expect(result3[0].item2, 1);
      expect(result3[1].item1, 1);
      expect(result3[1].item2, 2);
      expect(result3[2].item1, 2);
      expect(result3[2].item2, 3);
    });
    
    test('List of length 4', () {
      var result1 = testList4.splitEqualVerbose(splits: 1);
      var result2 = testList4.splitEqualVerbose(splits: 2);
      var result3 = testList4.splitEqualVerbose(splits: 3);

      expect(result1.length, 1);
      expect(result1[0].item1, 0);
      expect(result1[0].item2, 4);

      expect(result2.length, 2);
      expect(result2[0].item1, 0);
      expect(result2[0].item2, 2);
      expect(result2[1].item1, 2);
      expect(result2[1].item2, 4);

      expect(result3.length, 3);
      expect(result3[0].item1, 0);
      expect(result3[0].item2, 1);
      expect(result3[1].item1, 1);
      expect(result3[1].item2, 2);
      expect(result3[2].item1, 2);
      expect(result3[2].item2, 4);
    });

    test('List of length 5', () {
      var result1 = testList5.splitEqualVerbose(splits: 1);
      var result2 = testList5.splitEqualVerbose(splits: 2);
      var result3 = testList5.splitEqualVerbose(splits: 3);

      expect(result1.length, 1);
      expect(result1[0].item1, 0);
      expect(result1[0].item2, 5);

      expect(result2.length, 2);
      expect(result2[0].item1, 0);
      expect(result2[0].item2, 2);
      expect(result2[1].item1, 2);
      expect(result2[1].item2, 5);

      expect(result3.length, 3);
      expect(result3[0].item1, 0);
      expect(result3[0].item2, 1);
      expect(result3[1].item1, 1);
      expect(result3[1].item2, 2);
      expect(result3[2].item1, 2);
      expect(result3[2].item2, 5);
    });

    test('List of length 5', () {
      var result1 = testList6.splitEqualVerbose(splits: 1);
      var result2 = testList6.splitEqualVerbose(splits: 2);
      var result3 = testList6.splitEqualVerbose(splits: 3);

      expect(result1.length, 1);
      expect(result1[0].item1, 0);
      expect(result1[0].item2, 6);

      expect(result2.length, 2);
      expect(result2[0].item1, 0);
      expect(result2[0].item2, 3);
      expect(result2[1].item1, 3);
      expect(result2[1].item2, 6);

      expect(result3.length, 3);
      expect(result3[0].item1, 0);
      expect(result3[0].item2, 2);
      expect(result3[1].item1, 2);
      expect(result3[1].item2, 4);
      expect(result3[2].item1, 4);
      expect(result3[2].item2, 6);
    });
  });
}
