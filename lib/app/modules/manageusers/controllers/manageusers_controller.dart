import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/auth_controller.dart';

class ManageusersController extends GetxController {
  final cAuth = Get.put(AuthController());
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final DatabaseReference dbTeklib = FirebaseDatabase.instance.ref();
  final cSearch = TextEditingController().obs;
  fetchUsers() async {
    
  }

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
