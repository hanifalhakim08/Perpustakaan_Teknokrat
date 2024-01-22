import 'package:get/get.dart';

import '../../../controller/firebase_controller.dart';

class ViewbookController extends GetxController {
  final fbase = Get.find<FirestoreController>();
  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
