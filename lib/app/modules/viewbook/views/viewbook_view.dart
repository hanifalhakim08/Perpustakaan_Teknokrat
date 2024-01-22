import 'dart:math';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:perpustakaan_teknokrat/app/modules/manageBooks/controllers/manage_books_controller.dart';
import 'package:perpustakaan_teknokrat/app/routes/app_pages.dart';

import '../../../controller/auth_controller.dart';
import '../controllers/viewbook_controller.dart';

class ViewbookView extends GetView<ViewbookController> {
  const ViewbookView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return viewBookScreen();
  }
}

class viewBookScreen extends StatefulWidget {
  const viewBookScreen({super.key});

  @override
  State<viewBookScreen> createState() => _viewBookScreenState();
}

class _viewBookScreenState extends State<viewBookScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final cAuth = Get.find<AuthController>();
  final cManageBooks = Get.put(ManageBooksController());
  var similar;
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
    similar = Get.parameters['genre'].toString();
    cManageBooks.dbTeklib
        .child(
            'dbTeklib/users/${cAuth.auth.currentUser!.uid}/favorite_book/book_id')
        .once()
        .then((event) {
      if (event.snapshot.value != null) {
        var fav = event.snapshot.value
            .toString()
            .replaceAll(']', '')
            .replaceAll('[', '')
            .replaceAll(' ', '')
            .split(',')
            .where((element) => element == Get.parameters['bookId']);
        if (fav.isNotEmpty) {
          cManageBooks.isFav.value = true;
          print(fav);
        } else {
          cManageBooks.isFav.value = false;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height +
              MediaQuery.of(context).padding.top,
          child: Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height +
                    MediaQuery.of(context).padding.top,
                padding: EdgeInsets.fromLTRB(
                    20, MediaQuery.of(context).padding.top + 60, 20, 20),
                color: Color.fromARGB(255, 243, 243, 243),
                child: ListView(
                  padding: EdgeInsets.only(top: 20, bottom: 60),
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 160,
                          height: 230,
                          child: Stack(
                            children: [
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: Container(
                                  width: 150,
                                  height: 220,
                                  decoration: BoxDecoration(
                                    color: randomColor(),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 0,
                                left: 0,
                                child: Container(
                                  width: 150,
                                  height: 220,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                          "${Get.parameters['image_cover']}",
                                        )),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "${Get.parameters['book_name']}",
                                softWrap: true,
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text("Author : ${Get.parameters['author']}"),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                  "Release Date : ${Get.parameters['release_date']}"),
                              SizedBox(
                                height: 10,
                              ),
                              Text("Description : ${Get.parameters['desc']}"),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width - 40,
                      child: Wrap(
                        alignment: WrapAlignment.start,
                        direction: Axis.horizontal,
                        runSpacing: 10,
                        spacing: 10,
                        children: [
                          Text(
                            "Review (${Get.parameters['review_counts']})",
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          InkWell(
                            onTap: () {
                              cManageBooks.likeBook(
                                cAuth.auth.currentUser!.uid,
                                Get.parameters['bookId'].toString(),
                              );
                            },
                            child: StreamBuilder(
                              stream: cManageBooks.dbTeklib
                                  .child(
                                      'dbTeklib/books/${Get.parameters['bookId']}')
                                  .onValue,
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return CircularProgressIndicator();
                                }
                                if (snapshot.hasError) {
                                  return Text('Error: ${snapshot.error}');
                                }
                                if (snapshot.hasData) {
                                  var isUserLiked = snapshot.data!.snapshot
                                      .child("likes")
                                      .hasChild(cAuth.auth.currentUser!.uid);
                                  var likeCounts = snapshot.data!.snapshot
                                      .child("like_counts")
                                      .value;
                                  return RichText(
                                      textAlign: TextAlign.center,
                                      text: TextSpan(children: [
                                        WidgetSpan(
                                          child: Text(
                                            "Like ($likeCounts)",
                                            style: TextStyle(
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                        WidgetSpan(
                                            child: Icon(
                                          isUserLiked
                                              ? Icons.thumb_up
                                              : Icons.thumb_up_alt_outlined,
                                          size: 16,
                                        ))
                                      ]));
                                }
                                return SizedBox();
                              },
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "Borrow (${Get.parameters['borrow_counts']})",
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width - 40,
                      child: Text(
                        "Genre | ${Get.parameters['genre']}",
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width - 40,
                      child: Text(
                        "Synopsis : ${Get.parameters['sinopsis']} ",
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.green,
                          ),
                          child: Text(
                            "Available",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.blue,
                          ),
                          child: InkWell(
                            onTap: () {
                              Get.toNamed(Routes.READ_BOOK,
                                  parameters: Map.from({
                                    "pdf": Get.parameters['pdf'],
                                  }));
                            },
                            child: Text(
                              "Borrow",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.orange,
                          ),
                          child: Text(
                            "Add Bookmark",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Similar Books",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        InkWell(
                          onTap: () {
                            Get.toNamed(Routes.BOOKS, parameters: {
                              "query": similar,
                              "from" : "insideViewBook",
                              "title": "Similar Books"
                            });
                          },
                          child: Text(
                            "View All",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blue),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 150,
                      child: FutureBuilder(
                        future: cManageBooks.dbTeklib
                            .child(
                                'dbTeklib/genres/${Get.parameters['genre']}/books')
                            .once(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          }
                          if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          }
                          if (snapshot.hasData) {
                            var books = snapshot.data!.snapshot.value
                                .toString()
                                .substring(
                                    1,
                                    snapshot.data!.snapshot.value
                                            .toString()
                                            .length -
                                        1)
                                .split(",")
                                .map((item) => item.trim())
                                .toList();
                            return ListView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                for (var book in books)
                                  FutureBuilder(
                                    future: cManageBooks.dbTeklib
                                        .child('dbTeklib/books/$book')
                                        .once(),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return CircularProgressIndicator();
                                      }
                                      if (snapshot.hasError) {
                                        return Text('Error: ${snapshot.error}');
                                      }
                                      var book = snapshot.data!.snapshot;
                                      if (snapshot.hasData) {
                                        return InkWell(
                                          onTap: () {
                                                    var Counts;
                                                    cManageBooks.dbTeklib
                                                        .child(
                                                            "dbTeklib/books/${book.key.toString()}/review_counts")
                                                        .once()
                                                        .then(
                                                          (value) => {
                                                            Counts = value
                                                                .snapshot.value,
                                                            cManageBooks.dbTeklib
                                                                .child(
                                                                    "dbTeklib/books/${book.key.toString()}/review_counts")
                                                                .set(
                                                                    Counts + 1),
                                                            Counts = 0,
                                                          },
                                                        );
                                                    Get.offNamed(
                                                      Routes.VIEWBOOK,
                                                      parameters: Map.from({
                                                        "bookId":
                                                            book.key.toString(),
                                                        "book_name": book
                                                            .child('book_name')
                                                            .value
                                                            .toString(),
                                                        "author": book
                                                            .child('author')
                                                            .value
                                                            .toString(),
                                                        "image_cover": book
                                                            .child(
                                                                'image_cover')
                                                            .value
                                                            .toString(),
                                                        "release_date": book
                                                            .child(
                                                                'release_date')
                                                            .value
                                                            .toString(),
                                                        "genre": book
                                                            .child('genre')
                                                            .value
                                                            .toString(),
                                                        "desc": book
                                                            .child('desc')
                                                            .value
                                                            .toString(),
                                                        "description": book
                                                            .child(
                                                                'description')
                                                            .value
                                                            .toString(),
                                                        "sinopsis": book
                                                            .child('sinopsis')
                                                            .value
                                                            .toString(),
                                                        'rating': book
                                                            .child('rating')
                                                            .value
                                                            .toString(),
                                                        "review_counts": book
                                                            .child(
                                                                'review_counts')
                                                            .value
                                                            .toString(),
                                                        "like_counts": book
                                                            .child(
                                                                'like_counts')
                                                            .value
                                                            .toString(),
                                                        "borrow_counts": book
                                                            .child(
                                                                'borrow_counts')
                                                            .value
                                                            .toString(),
                                                        "pdf": book
                                                            .child('pdf')
                                                            .value
                                                            .toString(),
                                                      }),
                                                    );
                                                  },
                                          child: Container(
                                            width: 100,
                                            height: 120,
                                            margin: EdgeInsets.only(right: 10),
                                            clipBehavior: Clip.antiAlias,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              color: randomColor(),
                                              image: DecorationImage(
                                                image: NetworkImage(
                                                  "${book.child("image_cover").value}",
                                                ),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        );
                                      }
                                      return SizedBox();
                                    },
                                  ),
                              ],
                            );
                          }
                          return SizedBox();
                        },
                      ),
                    )
                  ],
                ),
              ),
              Positioned(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.only(
                      left: 15,
                      right: 15,
                      top: MediaQuery.of(context).padding.top),
                  height: (MediaQuery.of(context).padding.top + 60),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20)),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 1,
                        offset: Offset(0, 0.5),
                      )
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.red,
                        ),
                      ),
                      Text(
                        "Book Details",
                        style: TextStyle(
                            letterSpacing: 2,
                            color: const Color.fromARGB(255, 255, 0, 0),
                            fontWeight: FontWeight.bold),
                      ),
                      InkWell(
                        onTap: () {
                          cManageBooks.bookId =
                              Get.parameters['bookId'].toString();
                          cManageBooks.addBookFav(
                              cAuth.auth.currentUser!.uid.toString());
                        },
                        child: Obx(
                          () => Icon(
                            cManageBooks.isFav.value
                                ? Icons.bookmark
                                : Icons.bookmark_border_rounded,
                            color: const Color.fromARGB(255, 255, 0, 0),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
