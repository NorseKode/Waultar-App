import 'dart:async';
import 'dart:isolate';

import 'package:flutter_test/flutter_test.dart';
import 'package:waultar/configs/globals/app_logger.dart';
import 'package:waultar/core/base_worker/base_worker.dart';
import 'package:waultar/core/base_worker/package_models.dart';
import 'package:waultar/core/inodes/profile_document.dart';
import 'package:waultar/core/inodes/profile_repo.dart';
import 'package:waultar/data/configs/objectbox.dart';
import 'package:waultar/startup.dart';

import 'test_helper.dart';

Future<void> main() async {
  await TestHelper.runStartupScript();

  /* 
  * mainhandler:
  *   - listens for events received by the isolate
  *   - this can be used to pipe a partial result from an isolate into another isolate waiting for such event
  *
  * initiator:
  *   - the setup package, that the isolate can use to determine how it should be configured
  *  
  * workerBody:
  *   - this is the actual task the isolate will be doing
  *   - the function MUST be top-level or static
  * 
  */

  var worker = BaseWorker(
    mainHandler: print,
    initiator: InitiatorPackage(testing: true),
  );
  worker.init(workerBody);

  // I delay the main function to allow for the isolate to finish its task
  // otherwise the mainthread (spawned with main) will be killed and all
  // spawned isolates within will be killed unconditionally 
  await Future.delayed(const Duration(seconds: 10));
}

// run setupServices with configuration
// this call enables you to use all normal dependencies, the logger and objectbox
// - it abstracts away that the code being executed is in its own memory space
Future<void> setupIsolate(SendPort sendPort, InitiatorPackage setupData) async {
  await setupServices(
      testing: setupData.testing, isolate: true, sendPort: sendPort);
}

Future testIsolateMethod(String message) async {
  final BaseLogger _logger = locator.get<BaseLogger>(instanceName: 'logger');
  _logger.logger.info(message);
  final ProfileRepository _profileRepo = locator.get<ProfileRepository>(
    instanceName: 'profileRepo',
  );
  var profile = ProfileDocument(name: 'I were created in an isolate');
  var created = _profileRepo.add(profile);
  _logger.logger.info(created.id.toString());
}


// the actual function to be executed inside the isolate
Future workerBody(dynamic data, SendPort mainSendPort, Function onError) async {
  if (data is InitiatorPackage) {
    
    // ! wrap with try-catch always
    // ! if any uncaught errors happen inside the isolate, it will terminate immediately
    try {

      // setup services and dependecies as we do on normal app startup, but with
      // configurations to match the isolate (logger and objectbox need special setup when in isolate) 
      await setupIsolate(mainSendPort, data);

      // .. we can now work with the dependecies as normally
      // the logger inside an isolate propagates back the log to the main thread where it is logged to file
      var _logger = locator.get<BaseLogger>(instanceName: 'logger');
      _logger.logger.info('dummy package log');

      // as well as calling other methods or creating normal classes
      await testIsolateMethod('I was logged inside a method invoked from the workerBody');

    } catch (e, stacktrace) {

      // we cannot yet guarentee that the logger is ready, so we just send the message directly with the sendport 
      mainSendPort.send(LogRecordPackage(e.toString(), stacktrace.toString()));

    } finally { // ! <== always close the store in the isolate with a finally block 
      var _context = locator.get<ObjectBox>(instanceName: 'context');
      _context.store.close();
    }
  }
}
