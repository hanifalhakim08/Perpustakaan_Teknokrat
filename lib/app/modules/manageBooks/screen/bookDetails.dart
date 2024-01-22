import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/manage_books_controller.dart';

class bookDetails extends StatefulWidget {
  const bookDetails({super.key});

  @override
  State<bookDetails> createState() => _bookDetailsState();
}

class _bookDetailsState extends State<bookDetails> {
  final cManageBooks = Get.put(ManageBooksController());
  bool isEdit = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            "Details",
            style: TextStyle(
                color: Colors.red, fontSize: 15, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          leading: InkWell(
            onTap: () {
              cManageBooks.clearController();
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_ios, color: Colors.red),
          ),
          actions: [
            Row(
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      isEdit = !isEdit;
                    });
                  },
                  child: Icon(Icons.edit, color: Colors.red),
                ),
                SizedBox(
                  width: 15,
                ),
                InkWell(
                  onTap: () {
                    Get.defaultDialog(
                      title: "Delete Book",
                      middleText: "Are you sure you want to delete this book?",
                      onConfirm: () {
                        cManageBooks.deleteBook(cManageBooks.bookId);
                        Get.back();
                      },
                      textConfirm: "Yes",
                      textCancel: "No",
                    ).then((value) => Get.back());
                  },
                  child: Icon(Icons.delete, color: Colors.red),
                ),
                SizedBox(
                  width: 5,
                ),
              ],
            ),
          ],
        ),
        resizeToAvoidBottomInset: false,
        body: Container(
          height: MediaQuery.of(context).size.height +
              MediaQuery.of(context).padding.top,
          width: MediaQuery.of(context).size.width,
          child: ListView(
            padding: EdgeInsets.all(0),
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      children: [
                        Container(
                          width: 150,
                          height: 220,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: (cManageBooks.pickedFile.isNotEmpty)
                                  ? FileImage(File(cManageBooks
                                      .pickedFile['image_path']
                                      .toString()))
                                  : NetworkImage(cManageBooks.cImage.text)
                                      as ImageProvider,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                blurRadius: 1,
                                offset: Offset(0, 0.5),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        if (isEdit)
                          InkWell(
                              onTap: () {
                                cManageBooks
                                    .pickImage()
                                    .then((value) => {setState(() {})});
                              },
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.refresh, color: Colors.red),
                                    Text(
                                      "Change Image",
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  ]))
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(15),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width - 20,
                          child: Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: cManageBooks.cPdf,
                                  enabled: isEdit,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                    label: Text("Book File Pdf"),
                                  ),
                                  readOnly: true,
                                ),
                              ),
                              if (isEdit == true)
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      cManageBooks.pickPdf();
                                    });
                                  },
                                  child: Container(
                                    width: 40,
                                    child: Icon(
                                      Icons.file_open_rounded,
                                      size: 30,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextField(
                          controller: cManageBooks.cBookName,
                          enabled: isEdit,
                          decoration: InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            label: Text("Book Name"),
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextField(
                          controller: cManageBooks.cAuthorName,
                          enabled: isEdit,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            label: Text("Author"),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width - 20,
                          child: Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: cManageBooks.cReleaseDate,
                                  enabled: isEdit,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                    label: Text("Release Date"),
                                  ),
                                  readOnly: true,
                                ),
                              ),
                              if (isEdit == true)
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      cManageBooks.openDatePicker(context);
                                    });
                                  },
                                  child: Container(
                                    width: 40,
                                    child: Icon(
                                      Icons.calendar_today,
                                      size: 30,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextField(
                          controller: cManageBooks.cGenre,
                          enabled: isEdit,
                          decoration: InputDecoration(
                            label: Text("Genre"),
                            border: OutlineInputBorder(),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextField(
                          controller: cManageBooks.cDesc,
                          enabled: isEdit,
                          decoration: InputDecoration(
                            label: Text("Decription"),
                            border: OutlineInputBorder(),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextField(
                          controller: cManageBooks.cSinopsis,
                          enabled: isEdit,
                          decoration: InputDecoration(
                            label: Text("Sinopsys"),
                            border: OutlineInputBorder(),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Set As Popular"),
                            Obx(
                              () => Checkbox(
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                                visualDensity: VisualDensity(
                                    horizontal: -4.0, vertical: -4.0),
                                value: cManageBooks.isPopular.value,
                                onChanged: (value) {
                                  isEdit
                                      ? cManageBooks.isPopular.value = value!
                                      : null;
                                },
                                activeColor: Colors.red,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        if (isEdit)
                          ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.red),
                            ),
                            child: Text("Save Edit"),
                            onPressed: () {
                              cManageBooks.UpdateBook().then((value) => {
                                    cManageBooks.clearController(),
                                    Navigator.pop(context),
                                  });
                            },
                          ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}