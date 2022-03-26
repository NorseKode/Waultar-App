import 'package:flutter_test/flutter_test.dart';
import 'package:waultar/configs/globals/app_logger.dart';

import 'test_helper.dart';

Future<void> main() async {
  
  await TestHelper.runStartupScript();

  var worker = BaseWorker(print, testing: true);
  await worker.init();

  await Future.delayed(Duration(seconds: 10));

}
// C:\Users\gusta\workspace\waultar\Waultar-App\test\waultar\objectbox
// C:\Users\gusta\workspace\waultar\Waultar-App\test\waultar\objectbox

