import 'package:get/get.dart';

import '../controllers/devtest_controller.dart';

class DevtestBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DevtestController>(
      () => DevtestController(),
    );
  }
}
