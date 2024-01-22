// import 'package:flutter/material.dart';
// import 'dart:io';
// import 'package:image_picker/image_picker.dart';
// import 'package:get/get.dart';
// import 'package:perpustakaan_teknokrat/app/controller/firebase_controller.dart';

// import '../controllers/devtest_controller.dart';
// class DevtestView extends StatefulWidget {
//   const DevtestView({Key? key});

//   @override
//   _DevtestViewState createState() => _DevtestViewState();
// }

// class _DevtestViewState extends State<DevtestView> {
//   final controller = Get.put(FirestoreController());
//   XFile? pickedFile;

//   Future<void> pickImage() async {
//     final result = await ImagePicker().pickImage(source: ImageSource.gallery);
//     if (result != null) {
//       setState(() {
//         pickedFile = result;
//       });
//     } else {
//       throw Exception('No image picked');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         body: Column(
//           children: [
//             SizedBox(height: 50,),
//             TextField(
//               decoration: InputDecoration(
//                 hintText: "Book Name",
//               ),
//             ),
//             SizedBox(height: 20,),
//             TextField(
//               decoration: InputDecoration(
//                 hintText: "Book Name",
//               ),
//             ),
//             SizedBox(height: 20,),
//             TextField(
//               decoration: InputDecoration(
//                 hintText: "Book Name",
//               ),
//             ),
//             SizedBox(height: 20,),
//             TextField(
//               decoration: InputDecoration(
//                 hintText: "Book Name",
//               ),
//             ),
//             SizedBox(height: 20,),
//             TextField(
//               decoration: InputDecoration(
//                 hintText: "Book Name",
//               ),
//             ),
//             SizedBox(height: 20,),
//             TextField(
//               decoration: InputDecoration(
//                 hintText: "Book Name",
//               ),
//             ),
//             SizedBox(height: 20,),
//             TextField(
//               decoration: InputDecoration(
//                 hintText: "Book Name",
//               ),
//             ),
//             if (pickedFile != null) ...[
//               Image.file(File(pickedFile!.path), scale: 10),
//               Text("Image Name: ${pickedFile!.name}"),
//               Text("Image Details: ${pickedFile!.path}"),
//               ElevatedButton(
//                 onPressed: () {
//                   if (pickedFile != null) {
//                     File imageFile = File(pickedFile!.path);
//                     controller.uploadImage(imageFile, pickedFile!.name);
//                   }
//                 },
//                 child: Text("Upload Image"),
//               ),
//             ],
//           ],
//         ),
//       ),
//     );
//   }
// }