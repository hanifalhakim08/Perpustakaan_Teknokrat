import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:perpustakaan_teknokrat/app/modules/widgets/bottomNav.dart';
import 'package:perpustakaan_teknokrat/app/modules/widgets/header.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';
import 'package:perpustakaan_teknokrat/app/controller/firebase_controller.dart';
import '../controllers/addbook_controller.dart';

class AddbookView extends GetView<AddbookController> {
  const AddbookView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return addbookScreen();
  }
}

class addbookScreen extends StatefulWidget {
  const addbookScreen({super.key});

  @override
  State<addbookScreen> createState() => _addbookScreenState();
}

class _addbookScreenState extends State<addbookScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final FBase = Get.put(FirestoreController());
  final cAddBook = Get.put(AddbookController());

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: Scaffold(
      //   resizeToAvoidBottomInset: false,
      //   key: scaffoldKey,
      //   endDrawer: Drawer(
      //     backgroundColor: Colors.white,
      //     width: MediaQuery.of(context).size.width * 0.7,
      //   ),
      //   body: Container(
      //     width: MediaQuery.of(context).size.width,
      //     height: MediaQuery.of(context).size.height,
      //     child: Stack(
      //       children: [
      //         ListView(
      //           children: [
      //             Padding(
      //               padding: EdgeInsets.only(
      //                   top: MediaQuery.of(context).padding.top + 30),
      //               child: Column(
      //                 children: [
      //                   Obx(
      //                     () =>
      //                         cAddBook.pickedFile['image_path'].toString() == ""
      //                             ? InkWell(
      //                                 onTap: () {
      //                                   setState(() {
      //                                     cAddBook.pickImage();
      //                                   });
      //                                 },
      //                                 child: Text("Pick Image"),
      //                               )
      //                             : Row(
      //                                 children: [
      //                                   Obx(
      //                                     () => InkWell(
      //                                       onTap: () {
      //                                         setState(() {
      //                                           cAddBook.pickImage();
      //                                         });
      //                                       },
      //                                       child: Image.file(
      //                                         File(
      //                                           cAddBook
      //                                               .pickedFile['image_path']
      //                                               .toString(),
      //                                         ),
      //                                         scale: 15,
      //                                       ),
      //                                     ),
      //                                   ),
      //                                   SizedBox(
      //                                     height: 20,
      //                                   ),
      //                                   Obx(
      //                                     () => Text(
      //                                       "Image Name: ${cAddBook.pickedFile['image_name'].toString()}",
      //                                     ),
      //                                   ),
      //                                 ],
      //                               ),
      //                   ),
      //                   TextField(
      //                     controller: cAddBook.cBookName,
      //                     decoration: InputDecoration(
      //                       hintText: "Book Name",
      //                     ),
      //                   ),
      //                   SizedBox(
      //                     height: 20,
      //                   ),
      //                   TextField(
      //                     controller: cAddBook.cAuthorName,
      //                     decoration: InputDecoration(
      //                       hintText: "Author Name",
      //                     ),
      //                   ),
      //                   SizedBox(
      //                     height: 20,
      //                   ),
      //                   TextField(
      //                     controller: cAddBook.cReleaseDate,
      //                     decoration: InputDecoration(
      //                       hintText: cAddBook.cReleaseDate.text == ""
      //                           ? "Release Date"
      //                           : "${cAddBook.pickedDate.value.substring(0, 10)}",
      //                     ),
      //                     readOnly: true,
      //                   ),
      //                   InkWell(
      //                     onTap: () {
      //                       setState(() {
      //                         cAddBook.openDatePicker(context);
      //                       });
      //                     },
      //                     child: Text("Pick Date"),
      //                   ),
      //                   SizedBox(
      //                     height: 20,
      //                   ),
      //                   TextField(
      //                     controller: cAddBook.cGenre,
      //                     decoration: InputDecoration(
      //                       hintText: "Genre",
      //                     ),
      //                   ),
      //                   SizedBox(
      //                     height: 20,
      //                   ),
      //                   TextField(
      //                     controller: cAddBook.cDesc,
      //                     decoration: InputDecoration(
      //                       hintText: "Description",
      //                     ),
      //                   ),
      //                   SizedBox(
      //                     height: 20,
      //                   ),
      //                   TextField(
      //                     controller: cAddBook.cSinopsis,
      //                     decoration: InputDecoration(
      //                       hintText: "Sinopsis",
      //                     ),
      //                   ),
      //                   SizedBox(
      //                     height: 20,
      //                   ),
      //                   ElevatedButton(
      //                     onPressed: () {
      //                       setState(() {
      //                         cAddBook.uploadBook();
      //                         // cAddBook.uploadBook();
      //                       });
      //                     },
      //                     child: Text("Upload Book"),
      //                   ),
      //                 ],
      //               ),
      //             ),
      //           ],
      //         ),
      //         Positioned(
      //           top: 0,
      //           child: Container(
      //             padding: EdgeInsets.only(
      //                 left: 15,
      //                 right: 15,
      //                 top: MediaQuery.of(context).padding.top),
      //             height: (MediaQuery.of(context).padding.top + 60),
      //             width: MediaQuery.of(context).size.width,
      //             decoration: BoxDecoration(
      //               color: Colors.white,
      //               borderRadius: BorderRadius.only(
      //                 bottomLeft: Radius.circular(15),
      //                 bottomRight: Radius.circular(15),
      //               ),
      //               boxShadow: [
      //                 BoxShadow(
      //                   color: Colors.grey,
      //                   blurRadius: 1,
      //                   offset: Offset(0, 0.5),
      //                 ),
      //               ],
      //             ),
      //             child: Row(
      //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //               children: [
      //                 Text(
      //                   "TEKLIB",
      //                   style: TextStyle(
      //                       letterSpacing: 2,
      //                       color: const Color.fromARGB(255, 255, 0, 0),
      //                       fontWeight: FontWeight.bold),
      //                 ),
      //                 Text(
      //                   "${Get.parameters['page']}",
      //                   style: TextStyle(
      //                       letterSpacing: 2,
      //                       color: const Color.fromARGB(255, 255, 0, 0),
      //                       fontWeight: FontWeight.bold),
      //                 ),
      //                 Row(
      //                   children: [
      //                     Container(
      //                       child: Icon(
      //                         Icons.search,
      //                         color: const Color.fromARGB(255, 255, 0, 0),
      //                       ),
      //                     ),
      //                     SizedBox(
      //                       width: 10,
      //                     ),
      //                     InkWell(
      //                       onTap: () {
      //                         scaffoldKey.currentState!.openEndDrawer();
      //                       },
      //                       child: Container(
      //                         child: Icon(
      //                           Icons.menu,
      //                           color: Color.fromARGB(255, 255, 0, 0),
      //                         ),
      //                       ),
      //                     ),
      //                   ],
      //                 ),
      //               ],
      //             ),
      //           ),
      //         ),
      //         bottomNav(),
      //       ],
      //     ),
      //   ),
      // ),
    );
  }
}
