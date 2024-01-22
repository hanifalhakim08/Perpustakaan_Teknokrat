import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:perpustakaan_teknokrat/app/controller/auth_controller.dart';
import 'package:perpustakaan_teknokrat/app/modules/paneladmin/views/paneladmin_view.dart';
import 'package:perpustakaan_teknokrat/app/routes/app_pages.dart';
import 'package:perpustakaan_teknokrat/utils/loading.dart';
import '../controllers/manage_books_controller.dart';

class ManageBooksView extends GetView<ManageBooksController> {
  const ManageBooksView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return manageBooksScreen();
  }
}

class manageBooksScreen extends StatefulWidget {
  const manageBooksScreen({super.key});

  @override
  State<manageBooksScreen> createState() => _manageBooksScreenState();
}

class _manageBooksScreenState extends State<manageBooksScreen> {
  final cManageBooks = Get.put(ManageBooksController());
  final cAuth = Get.put(AuthController());
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  String table = 'Table Books';

  var addBookStat = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: scaffoldKey,
      endDrawer: Drawer(
        backgroundColor: Colors.white,
        width: MediaQuery.of(context).size.width * 0.7,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top + 50,
                  left: 15,
                  right: 15,
                  bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  DropdownButton(
                    value: table,
                    icon: Icon(Icons.refresh),
                    iconSize: 24,
                    isExpanded: true,
                    elevation: 1,
                    style: TextStyle(color: Colors.blue),
                    onChanged: (String? newValue) {
                      setState(() {
                        table = newValue as String;
                        cManageBooks.cSearch.value.clear();
                      });
                      if (table == 'Table Books') {
                      } else if (table == 'Table Genre') {}
                    },
                    items: <String>['Table Books', 'Table Genre']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Row(children: [
                          Text(value),
                        ]),
                      );
                    }).toList(),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  if (table == 'Table Books') ...[
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 40,
                            child: TextField(
                              onChanged: (value) {
                                setState(() {
                                  cManageBooks.cSearch.value.text = value;
                                });
                              },
                              controller: cManageBooks.cSearch.value,
                              decoration: InputDecoration(
                                hintText: "Search",
                                prefixIcon: Icon(Icons.search),
                                contentPadding: EdgeInsets.zero,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        InkWell(
                          onTap: () {
                            cManageBooks.clearController();
                            Get.to(() => AddBook());
                          },
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.red,
                            ),
                            child: Icon(
                              Icons.add_circle_outline,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "All Books",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    )
                  ] else ...[
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 40,
                            child: TextField(
                              onChanged: (value) {
                                setState(() {
                                  cManageBooks.cSearch.value.text = value;
                                });
                              },
                              controller: cManageBooks.cSearch.value,
                              decoration: InputDecoration(
                                hintText: "Search",
                                prefixIcon: Icon(Icons.search),
                                contentPadding: EdgeInsets.zero,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        InkWell(
                          onTap: () {
                            setState(
                              () {
                                Get.to(() => AddGenre());
                              },
                            );
                          },
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.red,
                            ),
                            child: Icon(
                              Icons.add_circle_outline,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "All Genres",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                  if (table == 'Table Books')
                    StreamBuilder(
                      stream:
                          cManageBooks.dbTeklib.child('dbTeklib/books').onValue,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          var originalBooks = snapshot.data!.snapshot.children;
                          var books = originalBooks.where((element) => element
                              .child('book_name')
                              .value
                              .toString()
                              .toLowerCase()
                              .contains(cManageBooks.cSearch.value.text
                                  .toLowerCase()
                                  .toString()));
                          return Expanded(
                            child: ListView(
                              padding: EdgeInsets.all(0),
                              scrollDirection: Axis.vertical,
                              children: [
                                for (var keysbuku in books)
                                  Column(
                                    children: [
                                      Divider(),
                                      ListTile(
                                        onTap: () {
                                          Get.to(
                                            () => bookDetails(),
                                          );
                                          cManageBooks.bookId =
                                              keysbuku.key.toString();
                                          cManageBooks.cPdf.text = Uri.parse(
                                                  keysbuku
                                                      .child('pdf')
                                                      .value
                                                      .toString())
                                              .pathSegments
                                              .last
                                              .split('/')
                                              .last;
                                          cManageBooks.pickedPdf.addAll({});
                                          cManageBooks.flag =
                                              "${keysbuku.child('pdf').value.toString()}";
                                          cManageBooks.cImage.text = keysbuku
                                              .child("image_cover")
                                              .value
                                              .toString();
                                          cManageBooks.cBookName.text = keysbuku
                                              .child("book_name")
                                              .value
                                              .toString();
                                          cManageBooks.cAuthorName.text =
                                              keysbuku
                                                  .child("author")
                                                  .value
                                                  .toString();
                                          cManageBooks.cReleaseDate.text =
                                              keysbuku
                                                  .child("release_date")
                                                  .value
                                                  .toString();
                                          cManageBooks.cGenre.text = keysbuku
                                              .child("genre")
                                              .value
                                              .toString();
                                          cManageBooks.toUpdateGenre =
                                              cManageBooks.cGenre.text;
                                          cManageBooks.cDesc.text = keysbuku
                                              .child("desc")
                                              .value
                                              .toString();
                                          cManageBooks.cSinopsis.text = keysbuku
                                              .child("sinopsis")
                                              .value
                                              .toString();
                                          cManageBooks.isPopular.value =
                                              keysbuku
                                                          .child("isPopular")
                                                          .value
                                                          .toString() ==
                                                      "true"
                                                  ? true
                                                  : false;
                                        },
                                        title: Text(
                                          '${keysbuku.child("book_name").key.toString().replaceAll("_", " ") + ' : ' + keysbuku.child("book_name").value.toString()}',
                                        ),
                                        subtitle: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              '${keysbuku.child("author").key.toString().replaceAll("_", " ") + ' : ' + keysbuku.child("author").value.toString()}',
                                            ),
                                            Text(
                                              '${keysbuku.child("genre").key.toString().replaceAll("_", " ") + ' : ' + keysbuku.child("genre").value.toString()}',
                                            ),
                                            Text(
                                              '${keysbuku.child("release_date").key.toString().replaceAll("_", " ") + ' : ' + keysbuku.child("release_date").value.toString()}',
                                            ),
                                          ],
                                        ),
                                        trailing: Icon(Icons.arrow_forward_ios),
                                      ),
                                      Divider(),
                                    ],
                                  )
                              ],
                            ),
                          );
                        }
                        return CircularProgressIndicator();
                      },
                    ),
                  if (table == 'Table Genre')
                    StreamBuilder(
                      stream: cManageBooks.dbTeklib
                          .child('dbTeklib/genres')
                          .onValue,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          var originalGenres = snapshot.data!.snapshot.children;
                          var genres = originalGenres.where((element) => element
                              .key
                              .toString()
                              .toLowerCase()
                              .contains(cManageBooks.cSearch.value.text
                                  .toLowerCase()
                                  .toString()));
                          return Expanded(
                            child: ListView(
                              padding: EdgeInsets.all(0),
                              scrollDirection: Axis.vertical,
                              children: [
                                for (var genre in genres)
                                  Column(
                                    children: [
                                      Divider(),
                                      ListTile(
                                        onTap: () {
                                          Get.to(() => genreDetails(),
                                              arguments: genre);
                                        },
                                        title: Text(
                                          '${genre.key.toString().replaceAll("_", " ")}',
                                        ),
                                        subtitle: Text(
                                          "Books Counts : ${genre.child('books_counts').value.toString()}",
                                        ),
                                        trailing: Icon(Icons.arrow_forward_ios),
                                      ),
                                      Divider(),
                                    ],
                                  ),
                              ],
                            ),
                          );
                        }
                        return CircularProgressIndicator();
                      },
                    ),
                ],
              ),
            ),
            Positioned(
              top: 0,
              child: Container(
                padding: EdgeInsets.only(
                    left: 15,
                    right: 15,
                    top: MediaQuery.of(context).padding.top),
                height: (MediaQuery.of(context).padding.top + 60),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 1,
                      offset: Offset(0, 0.5),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Get.offAllNamed(Routes.PANELADMIN, parameters: {
                          "page": "Panel Admin",
                        });
                        setState(() {});
                      },
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.red,
                      ),
                    ),
                    Text(
                      "${Get.parameters['page']}",
                      style: TextStyle(
                          letterSpacing: 2,
                          color: const Color.fromARGB(255, 255, 0, 0),
                          fontWeight: FontWeight.bold),
                    ),
                    InkWell(
                      onTap: () {
                        // scaffoldKey.currentState!.openEndDrawer();
                        cAuth.logout();
                      },
                      child: Container(
                        child: Icon(
                          Icons.menu,
                          color: Color.fromARGB(255, 255, 0, 0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//add book
class AddBook extends StatefulWidget {
  const AddBook({super.key});

  @override
  State<AddBook> createState() => _AddBookState();
}

class _AddBookState extends State<AddBook> {
  final cManageBooks = Get.put(ManageBooksController());
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text(
              "Add Book",
              style: TextStyle(
                color: Colors.red,
                fontSize: 15,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
            ),
            centerTitle: true,
            leading: InkWell(
              onTap: () {
                cManageBooks.clearController();
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back_ios, color: Colors.red),
            )),
        resizeToAvoidBottomInset: false,
        body: Container(
          padding: EdgeInsets.all(10),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 1,
                offset: Offset(0, -0.5),
              )
            ],
          ),
          child: ListView(
            padding: EdgeInsets.all(0),
            children: [
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: cManageBooks.cImage,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: cManageBooks.cImage.text == ""
                            ? "Chose an image"
                            : cManageBooks.cImage.text,
                      ),
                      readOnly: true,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      cManageBooks
                          .pickImage()
                          .then((value) => {setState(() {})});
                    },
                    child: Container(
                      width: 40,
                      child: Icon(
                        Icons.image,
                        size: 30,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: cManageBooks.cPdf,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: cManageBooks.cPdf.text == ""
                            ? "Chose Book File Pdf"
                            : cManageBooks.cPdf.text,
                      ),
                      readOnly: true,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      cManageBooks.pickPdf().then((value) => {setState(() {})});
                    },
                    child: Container(
                      width: 40,
                      child: Icon(
                        Icons.file_open_sharp,
                        size: 30,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: cManageBooks.cBookName,
                decoration: InputDecoration(
                  hintText: "Book Name",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: cManageBooks.cAuthorName,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Author Name",
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: cManageBooks.cReleaseDate,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Release Date",
                      ),
                      readOnly: true,
                    ),
                  ),
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
              SizedBox(
                height: 20,
              ),
              Container(
                width: 300,
                height: 60,
                child: StreamBuilder(
                  stream:
                      cManageBooks.dbTeklib.child("dbTeklib/genres").onValue,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      var genres = <String>[];
                      snapshot.data!.snapshot.children.forEach(
                        (e) {
                          genres.add(e.key.toString().replaceAll("_", " "));
                        },
                      );
                      return DropdownButtonFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        isExpanded: true,
                        hint: Text(
                          "Select Genre",
                        ),
                        value: cManageBooks.cGenre.text.isNotEmpty
                            ? cManageBooks.cGenre.text
                            : null,
                        items: genres.map((genre) {
                          return DropdownMenuItem(
                            value: genre,
                            child: Text(genre),
                          );
                        }).toList(),
                        onChanged: (value) {
                          cManageBooks.cGenre.text = value.toString();
                        },
                      );
                    }
                    return Loading();
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: cManageBooks.cDesc,
                decoration: InputDecoration(
                  hintText: "Description",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: cManageBooks.cSinopsis,
                decoration: InputDecoration(
                  hintText: "Sinopsis",
                  border: OutlineInputBorder(),
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
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      visualDensity:
                          VisualDensity(horizontal: -4.0, vertical: -4.0),
                      value: cManageBooks.isPopular.value,
                      onChanged: (value) {
                        cManageBooks.isPopular.value = value!;
                      },
                      activeColor: Colors.red,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Obx(
                () => ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.red),
                  ),
                  onPressed: () {
                    if (cManageBooks.isFinished.value) {
                      cManageBooks.addBook().then((value) => {setState(() {})});
                    } else {
                      print("still loading");
                    }
                  },
                  child: (cManageBooks.isFinished.value)
                      ? Text("Upload Book")
                      : CircularProgressIndicator(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//Update Book (inside this page)
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
                        Container(
                            width: MediaQuery.of(context).size.width - 20,
                            child: StreamBuilder(
                                stream: cManageBooks.dbTeklib
                                    .child('dbTeklib/genres')
                                    .onValue,
                                builder: (context, snapshot) {
                                  if (!snapshot.hasData) {
                                    return Text("Loading  or no data ...");
                                  }
                                  var genres = snapshot.data!.snapshot.children;
                                  return DropdownButtonFormField(
                                    disabledHint: Text("asda"),
                                    decoration: InputDecoration(
                                      enabled: isEdit,
                                      border: OutlineInputBorder(),
                                    ),
                                    isExpanded: true,
                                    value: cManageBooks.cGenre.text.isNotEmpty
                                        ? cManageBooks.cGenre.text
                                        : null,
                                    items: genres.map((genre) {
                                      return DropdownMenuItem(
                                        value: genre.key,
                                        child: Text(genre.key
                                            .toString()
                                            .replaceAll("_", " ")),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      cManageBooks.cGenre.text =
                                          value.toString();
                                    },
                                  );
                                })),
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

//add genre
class AddGenre extends StatefulWidget {
  const AddGenre({super.key});

  @override
  State<AddGenre> createState() => _AddGenreState();
}

class _AddGenreState extends State<AddGenre> {
  final cManageBooks = Get.put(ManageBooksController());
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text(
              "Add Genre",
              style: TextStyle(
                color: Colors.red,
                fontSize: 15,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
            ),
            centerTitle: true,
            leading: InkWell(
              onTap: () {
                cManageBooks.clearController();
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back_ios, color: Colors.red),
            )),
        resizeToAvoidBottomInset: false,
        body: Container(
          padding: EdgeInsets.all(10),
          height: MediaQuery.of(context).size.height -
              (MediaQuery.of(context).padding.top + 120),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 1,
                  offset: Offset(0, -0.5),
                )
              ]),
          child: ListView(
            children: [
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: cManageBooks.cGenre,
                decoration: InputDecoration(
                  hintText: "Genre Name",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: cManageBooks.cDesc,
                decoration: InputDecoration(
                  hintText: "Description",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.red),
                ),
                onPressed: () {
                  setState(() {
                    cManageBooks.addGenre();
                    Get.back();
                  });
                },
                child: Text("Add Genre"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//update genre
class genreDetails extends StatefulWidget {
  const genreDetails({super.key});

  @override
  State<genreDetails> createState() => genreDetailsState();
}

class genreDetailsState extends State<genreDetails> {
  final cManageBooks = Get.put(ManageBooksController());
  Color randomColor() {
    Color color;
    do {
      color = Color(Random().nextInt(0xFFFFFFFF));
    } while (color.value == 0xFF000000);
    return color;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_ios, color: Colors.red),
          ),
          title: Text(
            "Details",
            style: TextStyle(
                color: Colors.red,
                fontSize: 15,
                letterSpacing: 1,
                fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.only(bottom: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                color: randomColor(),
                alignment: Alignment.center,
                child: Text("${Get.arguments.key.toString()}",
                    style: TextStyle(
                      fontSize: 20,
                    )),
                height: 100,
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                    "Deskripsi : ${Get.arguments.child('desc').value.toString()}"),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Text("All Books With This Genre",
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              Divider(
                thickness: 2,
              ),
              StreamBuilder(
                stream: cManageBooks.dbTeklib.child("dbTeklib/books").onValue,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var data = snapshot.data!.snapshot;
                    return FutureBuilder(
                      future: cManageBooks.dbTeklib
                          .child(
                              'dbTeklib/genres/${Get.arguments.key.toString()}')
                          .child('books')
                          .once(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          var signs = snapshot.data!.snapshot.value
                              .toString()
                              .replaceAll('[', '')
                              .replaceAll(" ", '')
                              .replaceAll(']', '')
                              .split(',');
                          var books = data.children.where(
                              (book) => signs.contains(book.key.toString()));
                          return Expanded(
                            child: ListView(
                                padding: EdgeInsets.all(10),
                                children: List.generate(
                                    books.length,
                                    (index) => ListTile(
                                          titleAlignment:
                                              ListTileTitleAlignment.center,
                                          title: Text(books
                                              .elementAt(index)
                                              .child('book_name')
                                              .value
                                              .toString()),
                                          subtitle: Text(books
                                              .elementAt(index)
                                              .child('author')
                                              .value
                                              .toString()),
                                        ))),
                          );
                        } else {
                          return Text("No Data");
                        }
                      },
                    );
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
