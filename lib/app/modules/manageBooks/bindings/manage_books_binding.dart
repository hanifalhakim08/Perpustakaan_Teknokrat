import 'package:get/get.dart';

import '../controllers/manage_books_controller.dart';

class ManageBooksBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ManageBooksController>(
      () => ManageBooksController(),
    );
  }
}
