import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  
  final cEmail = TextEditingController();
  final cUser = TextEditingController();
  final cPass = TextEditingController();

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
    cEmail.dispose();
    cUser.dispose();
    cPass.dispose();
  }
}
