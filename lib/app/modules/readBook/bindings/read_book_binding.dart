import 'package:get/get.dart';

import '../controllers/read_book_controller.dart';

class ReadBookBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReadBookController>(
      () => ReadBookController(),
    );
  }
}
