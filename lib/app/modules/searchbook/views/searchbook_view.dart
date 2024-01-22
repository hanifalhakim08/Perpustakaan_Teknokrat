import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:perpustakaan_teknokrat/app/routes/app_pages.dart';
import '../../widgets/bottomNav.dart';
import '../controllers/searchbook_controller.dart';

class SearchbookView extends GetView<SearchbookController> {
  const SearchbookView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return searchbookScreen();
  }
}

class searchbookScreen extends StatefulWidget {
  const searchbookScreen({super.key});

  @override
  State<searchbookScreen> createState() => _searchbookScreenState();
}

class _searchbookScreenState extends State<searchbookScreen> {
  final cSearchController = Get.put(SearchbookController());
  Color randomColor() {
    Color color;
    do {
      color = Color(Random().nextInt(0xFFFFFFFF));
    } while (color.value == 0xFF000000);
    return color;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        endDrawer: Drawer(
          backgroundColor: Colors.white,
          width: MediaQuery.of(context).size.width * 0.7,
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).padding.top + 75),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width - 20,
                      height: 40,
                      child: TextField(
                        onChanged: (value) {
                          setState(() {
                            cSearchController.cSearch.value.text = value;
                          });
                        },
                        controller: cSearchController.cSearch.value,
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
                    SizedBox(
                      height: 15,
                    ),
                    Expanded(
                      child: StreamBuilder(
                        stream: cSearchController.dbTeklib
                            .child('dbTeklib/books')
                            .onValue,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            var originalBooks =
                                snapshot.data!.snapshot.children;
                            var books = originalBooks.where((element) {
                              var bookName = element
                                  .child('book_name')
                                  .value
                                  .toString()
                                  .toLowerCase();
                              var genre = element
                                  .child('genre')
                                  .value
                                  .toString()
                                  .toLowerCase();
                              var author = element
                                  .child('author')
                                  .value
                                  .toString()
                                  .toLowerCase();

                              return bookName.contains(cSearchController
                                      .cSearch.value.text
                                      .toString()
                                      .toLowerCase()) ||
                                  genre.contains(cSearchController
                                      .cSearch.value.text
                                      .toString()
                                      .toLowerCase()) ||
                                  author.contains(cSearchController
                                      .cSearch.value.text
                                      .toString()
                                      .toLowerCase());
                            });
                            if (MediaQuery.of(context).size.width < 330) {
                              return ListView(
                                padding: EdgeInsets.only(
                                    bottom: 70, left: 10, right: 10),
                                children: [
                                  Wrap(
                                    alignment: WrapAlignment.spaceEvenly,
                                    direction: Axis.horizontal,
                                    spacing: 10,
                                    runSpacing: 10,
                                    children: List.generate(
                                      books.length,
                                      (index) {
                                        return Container(
                                          width: 130,
                                          child: Column(
                                            children: [
                                              Container(
                                                height: 190,
                                                width: 130,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  image: DecorationImage(
                                                      image: NetworkImage(books
                                                          .elementAt(index)
                                                          .child("image_cover")
                                                          .value
                                                          .toString()),
                                                      fit: BoxFit.cover),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.grey,
                                                      blurRadius: 1,
                                                      offset: Offset(0, 1),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                books
                                                    .elementAt(index)
                                                    .child("book_name")
                                                    .value
                                                    .toString(),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              );
                            } else {
                              return ListView(
                                padding: EdgeInsets.only(bottom: 60),
                                children: List.generate(
                                  books.length,
                                  (index) {
                                    return InkWell(
                                      onTap: () async {
                                        var Counts =
                                            books.elementAt(index).child('review_counts').value;
                                        Counts = (Counts as int) + 1;

                                        await cSearchController.dbTeklib
                                            .child(
                                                'dbTeklib/books/${books.elementAt(index).key.toString()}')
                                            .update({
                                          "review_counts": Counts
                                        }).then((value) {
                                          Get.toNamed(
                                            Routes.VIEWBOOK,
                                            parameters: Map.from({
                                              "bookId": books.elementAt(index).key.toString(),
                                              "book_name": books.elementAt(index)
                                                  .child('book_name')
                                                  .value
                                                  .toString(),
                                              "author": books.elementAt(index)
                                                  .child('author')
                                                  .value
                                                  .toString(),
                                              "image_cover": books.elementAt(index)
                                                  .child('image_cover')
                                                  .value
                                                  .toString(),
                                              "release_date": books.elementAt(index)
                                                  .child('release_date')
                                                  .value
                                                  .toString(),
                                              "genre": books.elementAt(index)
                                                  .child('genre')
                                                  .value
                                                  .toString(),
                                              "desc": books.elementAt(index)
                                                  .child('desc')
                                                  .value
                                                  .toString(),
                                              "description": books.elementAt(index)
                                                  .child('description')
                                                  .value
                                                  .toString(),
                                              "sinopsis": books.elementAt(index)
                                                  .child('sinopsis')
                                                  .value
                                                  .toString(),
                                              'rating': books.elementAt(index)
                                                  .child('rating')
                                                  .value
                                                  .toString(),
                                              "review_counts": books.elementAt(index)
                                                  .child('review_counts')
                                                  .value
                                                  .toString(),
                                              "like_counts": books.elementAt(index)
                                                  .child('like_counts')
                                                  .value
                                                  .toString(),
                                              "borrow_counts": books.elementAt(index)
                                                  .child('borrow_counts')
                                                  .value
                                                  .toString(),
                                              "pdf": books.elementAt(index)
                                                  .child('pdf')
                                                  .value
                                                  .toString()
                                            }),
                                          );
                                        });

                                      },
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        padding: EdgeInsets.only(
                                            left: 10, right: 10),
                                        height: 240,
                                        child: Stack(
                                          children: [
                                            Positioned(
                                              top: 10,
                                              left: 0,
                                              child: Container(
                                                height: 220,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width -
                                                    20,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.grey,
                                                      blurRadius: 1,
                                                      offset: Offset(0, 1),
                                                    ),
                                                  ],
                                                ),
                                                child: Row(
                                                  children: [
                                                    SizedBox(
                                                      width: 170,
                                                    ),
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          SizedBox(
                                                            height: 10,
                                                          ),
                                                          Text(
                                                              "${books.elementAt(index).child("book_name").value.toString()}",
                                                              maxLines: 2,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 17,
                                                              )),
                                                          SizedBox(
                                                            height: 10,
                                                          ),
                                                          Text(
                                                              "Author : ${books.elementAt(index).child("author").value.toString()}"),
                                                          Text(
                                                              "Genre : ${books.elementAt(index).child("genre").value.toString()}"),
                                                          Text(
                                                              "Likes : (${books.elementAt(index).child("like_counts").value.toString()})"),
                                                          Text(
                                                              "Reviews : (${books.elementAt(index).child("review_counts").value.toString()})"),
                                                          SizedBox(
                                                            height: 10,
                                                          ),
                                                          Text(
                                                            "Sinopsis : ${books.elementAt(index).child("sinopsis").value.toString()}",
                                                            maxLines: 4,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              top: 0,
                                              left: 10,
                                              child: Container(
                                                height: 220,
                                                width: 150,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  image: DecorationImage(
                                                      image: NetworkImage(books
                                                          .elementAt(index)
                                                          .child("image_cover")
                                                          .value
                                                          .toString()),
                                                      fit: BoxFit.cover),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.grey,
                                                      blurRadius: 1,
                                                      offset: Offset(0, 1),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              );
                            }
                          }
                          return Center(
                            child: Text("No Data Or Loading ..."),
                          );
                        },
                      ),
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
                      Text(
                        "TEKLIB",
                        style: TextStyle(
                            letterSpacing: 2,
                            color: const Color.fromARGB(255, 255, 0, 0),
                            fontWeight: FontWeight.bold),
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
              bottomNav(),
            ],
          ),
        ),
      ),
    );
  }
}
