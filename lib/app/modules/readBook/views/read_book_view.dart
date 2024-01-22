import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import 'package:get/get.dart';
import '../controllers/read_book_controller.dart';

class ReadBookView extends GetView<ReadBookController> {
  const ReadBookView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ReadBookScreen();
  }
}

class ReadBookScreen extends StatefulWidget {
  const ReadBookScreen({super.key});

  @override
  State<ReadBookScreen> createState() => _ReadBookScreenState();
}

class _ReadBookScreenState extends State<ReadBookScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading:InkWell(
            onTap: (){
              Navigator.pop(context);
            },
            child:  Icon(Icons.arrow_back_ios,color: Colors.red,),
          ),
          title: Text(
            "Baca Buku",
            style: TextStyle(
              color : Colors.red,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
        ),
        body: SfPdfViewer.network(Get.parameters['pdf'].toString()),
      ),
    );
  }
}