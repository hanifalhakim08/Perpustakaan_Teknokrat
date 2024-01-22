import 'package:get/get.dart';

import '../controllers/addbook_controller.dart';

class AddbookBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddbookController>(
      () => AddbookController(),
    );
  }
}
