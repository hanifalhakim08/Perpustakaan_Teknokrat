import 'package:get/get.dart';

import '../controllers/searchbook_controller.dart';

class SearchbookBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SearchbookController>(
      () => SearchbookController(),
    );
  }
}
