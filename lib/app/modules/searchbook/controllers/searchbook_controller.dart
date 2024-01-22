import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchbookController extends GetxController {
  final DatabaseReference dbTeklib = FirebaseDatabase.instance.ref();
  final cSearch = TextEditingController().obs;
  //TODO: Implement SearchbookController
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
