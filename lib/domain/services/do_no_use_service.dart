import 'package:waultar/core/abstracts/abstract_services/i_do_not_user_service.dart';
import 'package:waultar/core/base_worker/base_worker.dart';
import 'package:waultar/core/helpers/do_not_use_helper.dart';
import 'package:waultar/domain/workers/do_not_user_worker.dart';
import 'package:waultar/startup.dart';

class DoNotUseService implements IDoNotUserService {
  @override
  int createMemoryOverflow() {
    dynamic uselessListener(dynamic welp) {
      switch ("!") {
        default:
          break;
      }
    }

    var worker = BaseWorker(
      mainHandler: uselessListener,
      initiator: IsolateDoNotUseStartPackage(
        waultarPath: locator.get<String>(instanceName: 'waultar_root_directory'),
      ),
    );

    worker.init(doNotUseWorkerBody);

    return 1;
  }
}
