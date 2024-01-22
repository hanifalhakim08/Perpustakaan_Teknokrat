import 'dart:math';

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:get/get.dart';
import 'package:perpustakaan_teknokrat/app/controller/auth_controller.dart';
import 'package:perpustakaan_teknokrat/app/controller/firebase_controller.dart';
import 'package:perpustakaan_teknokrat/app/modules/widgets/bottomNav.dart';
import 'package:marquee/marquee.dart';
import 'package:perpustakaan_teknokrat/app/routes/app_pages.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return homeScreen();
  }
}

class homeScreen extends StatefulWidget {
  const homeScreen({super.key});

  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  final Fbase = Get.put(FirestoreController());
  final cAuth = Get.put(AuthController());
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

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
                color: Color.fromRGBO(245, 245, 245, 1),
                child: ListView(
                  scrollDirection: Axis.vertical,
                  padding: EdgeInsets.only(
                      top: (MediaQuery.of(context).padding.top + 60),
                      bottom: 70),
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      height: 30,
                      margin: EdgeInsets.only(left: 15, right: 15),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 0, right: 15),
                            alignment: Alignment.center,
                            height: 20,
                            width: MediaQuery.of(context).size.width * 0.43,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Marquee(
                              text: "Universitas Teknokrat Inodnesia",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                              scrollAxis: Axis.horizontal,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              textDirection: TextDirection.rtl,
                              blankSpace: 20.0,
                              velocity: 50.0,
                              showFadingOnlyWhenScrolling: true,
                              fadingEdgeStartFraction: 0.1,
                              fadingEdgeEndFraction: 0.1,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 0, right: 0),
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width * 0.43,
                            height: 20,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Marquee(
                              text: "Universitas Teknokrat Inodnesia",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                              scrollAxis: Axis.horizontal,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              blankSpace: 20.0,
                              velocity: 50.0,
                              showFadingOnlyWhenScrolling: true,
                              fadingEdgeStartFraction: 0.1,
                              fadingEdgeEndFraction: 0.1,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 15, right: 15),
                      child: Container(
                        clipBehavior: Clip.antiAlias,
                        height: 125,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 0.5,
                              offset: Offset(0, 0.2),
                            ),
                          ],
                        ),
                        child: CarouselSlider(
                          options: CarouselOptions(
                            autoPlay: true,
                            autoPlayInterval: Duration(seconds: 3),
                            pauseAutoPlayOnTouch: true,
                            enableInfiniteScroll: true,
                            viewportFraction: 1.0,
                          ),
                          items: [
                            Image.network(
                              fit: BoxFit.cover,
                              "https://spada.teknokrat.ac.id/pluginfile.php/1/theme_moove/sliderimage1/1693906439/Banner-WEB-UTI-2023.jpg",
                            ),
                            Image.network(
                                fit: BoxFit.cover,
                                "https://spada.teknokrat.ac.id/pluginfile.php/1/theme_moove/sliderimage2/1693906439/Web-header-UTI-23.jpg"),
                            Image.network(
                                fit: BoxFit.cover,
                                "https://spada.teknokrat.ac.id/pluginfile.php/1/theme_moove/sliderimage3/1693906439/banner10.png"),
                            Image.network(
                                fit: BoxFit.cover,
                                "https://spada.teknokrat.ac.id/pluginfile.php/1/theme_moove/sliderimage4/1693906439/banner11.png"),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.only(left: 5, right: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Popular Books",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {},
                                    child: Text(
                                      "View All",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            StreamBuilder(
                              stream: Fbase.dbTeklib
                                  .child("dbTeklib/books")
                                  .onValue,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  var books = snapshot.data!.snapshot;
                                  var popularBooks = books.children
                                      .where((book) =>
                                          book
                                              .child('isPopular')
                                              .value
                                              .toString() ==
                                          'true')
                                      .toList();
                                  var toShow = popularBooks.take(10).toList();
                                  popularBooks.clear();
                                  return Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 255,
                                    child: ListView(
                                      scrollDirection: Axis.horizontal,
                                      children: [
                                        for (var book in toShow)
                                          Row(
                                            children: [
                                              Column(
                                                children: [
                                                  InkWell(
                                                    onTap: () async {
                                                      var Counts;
                                                      Fbase.dbTeklib
                                                          .child(
                                                              "dbTeklib/books/${book.key.toString()}/review_counts")
                                                          .once()
                                                          .then(
                                                        (value) async {
                                                          Counts = value
                                                              .snapshot.value;
                                                          await Fbase.dbTeklib
                                                              .child(
                                                                  "dbTeklib/books/${book.key.toString()}/review_counts")
                                                              .set(Counts + 1);
                                                          Counts = 0;
                                                        },
                                                      );

                                                      Get.toNamed(
                                                        Routes.VIEWBOOK,
                                                        parameters: Map.from({
                                                          "bookId": book.key
                                                              .toString(),
                                                          "book_name": book
                                                              .child(
                                                                  'book_name')
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
                                                              .toString()
                                                        }),
                                                      );
                                                    },
                                                    child: Container(
                                                      height: 220,
                                                      width: 150,
                                                      alignment:
                                                          Alignment.center,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: Colors.grey,
                                                            blurRadius: 1,
                                                            offset:
                                                                Offset(0, 0.5),
                                                          )
                                                        ],
                                                        image: DecorationImage(
                                                          fit: BoxFit.cover,
                                                          image: NetworkImage(
                                                            book
                                                                .child(
                                                                    'image_cover')
                                                                .value
                                                                .toString(),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                      margin: EdgeInsets.only(
                                                          top: 5),
                                                      width: 150.0,
                                                      height: 30,
                                                      child: Text(
                                                        book
                                                            .child('book_name')
                                                            .value
                                                            .toString(),
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ))
                                                ],
                                              ),
                                              SizedBox(
                                                width: 15,
                                              )
                                            ],
                                          ),
                                      ],
                                    ),
                                  );
                                }
                                return Text("Loading");
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.only(left: 5, right: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Popular Genres",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      // Get.offAllNamed(Routes.DEVTEST);
                                    },
                                    child: Text(
                                      "View All",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            StreamBuilder(
                              stream: Fbase.dbTeklib
                                  .child("dbTeklib/genres")
                                  .onValue,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  var genres = snapshot.data!.snapshot;
                                  var popularGenres = genres.children.toList();
                                  popularGenres =
                                      popularGenres.take(10).toList();
                                  return Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 70,
                                    child: ListView(
                                      scrollDirection: Axis.horizontal,
                                      padding: EdgeInsets.all(0),
                                      children: [
                                        for (var genre in popularGenres)
                                          InkWell(
                                            onTap: () {
                                              Get.toNamed(Routes.BOOKS,
                                                  parameters: {
                                                    "query":
                                                        genre.key.toString(),
                                                    "from": "homeview",
                                                    "title":
                                                        genre.key.toString(),
                                                  });
                                            },
                                            child: ConstrainedBox(
                                              constraints: BoxConstraints(
                                                minWidth: 150,
                                              ),
                                              child: Container(
                                                margin:
                                                    EdgeInsets.only(right: 15),
                                                height: 70,
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  color: randomColor(),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.grey,
                                                      blurRadius: 1,
                                                      offset: Offset(0, 0.5),
                                                    ),
                                                  ],
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 15, right: 15),
                                                  child: Text(
                                                    "${genre.key.toString()}",
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  );
                                }
                                return Text("Loading");
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.only(left: 5, right: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "UpComing Books",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  InkWell(
                                    child: Text(
                                      "View All",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 150,
                              child: ListView.builder(
                                itemCount: 15,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return Container(
                                    margin: EdgeInsets.only(right: 15),
                                    width: 220,
                                    height: 150,
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 5, right: 10, bottom: 10, top: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Books",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    Get.offAllNamed(Routes.BOOKS, parameters: {
                                      // "page": "Panel Admin",
                                      "page": "Books",
                                      "query": "",
                                    });
                                  },
                                  child: Text(
                                    "View All ",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 255,
                            child: StreamBuilder(
                              stream: Fbase.dbTeklib
                                  .child("dbTeklib/books")
                                  .onValue,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  var books = snapshot.data!.snapshot.children
                                      .take(10)
                                      .toList();
                                  return ListView(
                                    scrollDirection: Axis.horizontal,
                                    children: [
                                      for (var book in books)
                                        Row(
                                          children: [
                                            Column(
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    var Counts;
                                                    Fbase.dbTeklib
                                                        .child(
                                                            "dbTeklib/books/${book.key.toString()}/review_counts")
                                                        .once()
                                                        .then(
                                                          (value) => {
                                                            Counts = value
                                                                .snapshot.value,
                                                            Fbase.dbTeklib
                                                                .child(
                                                                    "dbTeklib/books/${book.key.toString()}/review_counts")
                                                                .set(
                                                                    Counts + 1),
                                                            Counts = 0,
                                                          },
                                                        );
                                                    Get.toNamed(
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
                                                    height: 220,
                                                    width: 150,
                                                    alignment: Alignment.center,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Colors.grey,
                                                          blurRadius: 1,
                                                          offset:
                                                              Offset(0, 0.5),
                                                        )
                                                      ],
                                                      image: DecorationImage(
                                                        fit: BoxFit.cover,
                                                        image: NetworkImage(
                                                          book
                                                              .child(
                                                                  'image_cover')
                                                              .value
                                                              .toString(),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  margin:
                                                      EdgeInsets.only(top: 5),
                                                  width: 150.0,
                                                  height: 30,
                                                  child: Text(
                                                    book
                                                        .child('book_name')
                                                        .value
                                                        .toString(),
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              width: 15,
                                            ),
                                          ],
                                        ),
                                    ],
                                  );
                                }
                                return Text("Loading");
                              },
                            ),
                          ),
                        ],
                      ),
                    )
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
                        "${Get.parameters['page'] != null ? Get.parameters['page'] : ''}",
                        style: TextStyle(
                            letterSpacing: 2,
                            color: const Color.fromARGB(255, 255, 0, 0),
                            fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              Get.offAllNamed(Routes.SEARCHBOOK,parameters: {
                                "page" : "Search Book"
                              });
                            },
                            child: Container(
                              child: Icon(
                                Icons.search,
                                color: const Color.fromARGB(255, 255, 0, 0),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
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
