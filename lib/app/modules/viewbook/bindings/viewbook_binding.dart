import 'package:get/get.dart';

import '../controllers/viewbook_controller.dart';

class ViewbookBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ViewbookController>(
      () => ViewbookController(),
    );
  }
}
