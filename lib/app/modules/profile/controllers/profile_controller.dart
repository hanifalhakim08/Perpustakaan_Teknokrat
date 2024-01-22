import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:perpustakaan_teknokrat/app/controller/auth_controller.dart';

class ProfileController extends GetxController {
  final cAuth = Get.put(AuthController());
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final DatabaseReference dbTeklib = FirebaseDatabase.instance.ref();
  final cUsername = TextEditingController();
  final cBio = TextEditingController();
  final cEmail = TextEditingController();
  Map pickedImage = {};
  RxMap cImage = {
    "image_path": "",
    "image_name": "",
  }.obs;

  clearController() {
    username.clear();
    email.clear();
    bio.clear();
    pickedImage.clear();
    cEmail.clear();
    cUsername.clear();
    cBio.clear();
  }

  //user profile
  final username = TextEditingController(),
      email = TextEditingController(),
      profilePic = TextEditingController(),
      bio = TextEditingController();
  var errMessage = "".obs;
  //
  Future pickImage() async {
    final result = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (result != null) {
      pickedImage.addAll({
        'image_path': result.path,
        'image_name': result.name,
      });
      cImage['image_name'] = pickedImage['image_name'].toString();
      cImage['image_path'] = pickedImage['image_path'].toString();
    } else {
      print('No image picked');
    }
  }

  Future createProfile() async {
    var userId = cAuth.auth.currentUser!.uid.toString();
    if (username.text.isNotEmpty && email.text.isNotEmpty) {
      await dbTeklib.child("dbTeklib/users/${userId}").set({
        "username": username.text,
        "email": email.text,
        "profile_pic": profilePic.text.isNotEmpty ? profilePic.text : "",
        "bio": bio.text.isNotEmpty ? bio.text : "nothing",
        "favorite_book": "[]",
        "favorite_genre": "",
        "book": "",
        "group_book": "",
      });
      errMessage.value = "Success";
    } else {
      errMessage.value = "Please fill all the fields";
    }
  }

  checkUser() async {
    await dbTeklib.child("dbTeklib/users").once().then(
      (value) {
        if (value.snapshot.children.isNotEmpty) {
          var Users = value.snapshot.children.where((element) =>
              element.key.toString() == cAuth.auth.currentUser!.uid);
          var isFinished = true;
          if (Users.isEmpty) {
            Get.defaultDialog(
              title: "Create Your Profile",
              content: Column(
                children: [
                  TextField(
                    controller: username,
                    textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                      label: Text("Username"),
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextField(
                    controller: email,
                    textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                      label: Text("Email"),
                      prefixIcon: Icon(Icons.email),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (isFinished) {
                        isFinished = false;
                        createProfile().then((value) => {
                              isFinished = true,
                              username.clear(),
                              email.clear(),
                              Future.delayed(Duration(seconds: 1), () {
                                Get.back();
                              })
                            });
                      } else {
                        print('loading');
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red,
                    ),
                    child: Text(" Submit"),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Obx(
                    () => Text(
                      errMessage.value,
                      style: TextStyle(
                        color: errMessage.value == "Success"
                            ? Colors.green
                            : Colors.red,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        }
      },
    );
  }

  Future changeUsername() async {
    await dbTeklib
        .child('dbTeklib/users/${cAuth.auth.currentUser!.uid}')
        .update({
      'username': cUsername.text,
    });
  }

  Future changeBio() async {
    await dbTeklib
        .child('dbTeklib/users/${cAuth.auth.currentUser!.uid}')
        .update({
      'bio': cBio.text,
    });
  }

  Future changeImage() async {
    if (pickedImage.isNotEmpty && pickedImage['image_path'] != "") {
      final imageRef =
        _storage.ref().child('imagesProfile/${cAuth.auth.currentUser!.uid}/${pickedImage['image_name']}');
      final imageTask = await imageRef.putFile(
        File(pickedImage['image_path'].toString()),
        SettableMetadata(
          contentType: 'image/${pickedImage['image_name']!.split('.').last}',
        ),
      );
      final imageUrl = await imageTask.ref.getDownloadURL();
      pickedImage['image_path'] = imageUrl.toString();
      await dbTeklib
          .child('dbTeklib/users/${cAuth.auth.currentUser!.uid}')
          .update({
        'profile_pic': pickedImage['image_path'].toString(),
      }).then((value) => {
        Get.defaultDialog(
          title: "Success",
          content: Text("Profile Picture Changed"),
          onConfirm: () {
            Get.back();
          },
        )
      });
    }else{
      Get.defaultDialog(
          title: "Failed",
          content: Text("Make sure you have picked an image"),
          onConfirm: () {
            Get.back();
          },
        );
    }
  }

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
}
