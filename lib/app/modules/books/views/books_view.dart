
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:perpustakaan_teknokrat/app/modules/widgets/bottomNav.dart';
import 'package:perpustakaan_teknokrat/app/routes/app_pages.dart';
import '../controllers/books_controller.dart';

class BooksView extends GetView<BooksController> {
  const BooksView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return booksScreen();
  }
}

class booksScreen extends StatefulWidget {
  const booksScreen({super.key});

  @override
  State<booksScreen> createState() => _booksScreenState();
}

class _booksScreenState extends State<booksScreen> {
  final cBooks = Get.put(BooksController());
  var isFilterOpen = false;
  var Selectedgenre;
 




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
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: StreamBuilder(
                      stream: cBooks.dbTeklib.child('dbTeklib/books').onValue,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          var originalBooks = snapshot.data!.snapshot.children;
                          // var books = originalBooks.where((element) => element
                          //     .child('book_name')
                          //     .value
                          //     .toString()
                          //     .toLowerCase()
                          //     .contains(
                          //         cBooks.cSearch.value.text.toLowerCase()));
                          var query;
                          if (Get.parameters['page'] != "Books") {
                            query = Get.parameters['query']
                                .toString()
                                .toLowerCase();
                          } else {
                            query = Get.parameters['query']
                                .toString()
                                .toLowerCase();
                          }
                          if(Selectedgenre != null){
                            query = Selectedgenre.toString().toLowerCase();
                          }
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

                            return bookName.contains(query) ||
                                genre.contains(query) ||
                                author.contains(query);
                          });
                          return ListView(
                            padding: EdgeInsets.only(
                                bottom: 70,
                                left: 10,
                                right: 10,
                                top: MediaQuery.of(context).padding.top + 80),
                            children: [
                              FutureBuilder(
                                future: cBooks.dbTeklib
                                    .child("dbTeklib/genres")
                                    .once(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    var genres = snapshot.data!.snapshot;
                                    return Visibility(
                                      visible: isFilterOpen,
                                      child: Column(
                                        children: [
                                          DropdownButtonFormField(
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(),
                                            ),
                                            borderRadius: BorderRadius.circular(20),
                                            isExpanded: true,
                                            hint: Text(
                                              "Select Genre",
                                            ),
                                            value: Selectedgenre,
                                            items: genres.children.map((genre) {
                                              return DropdownMenuItem(
                                                value: genre.key.toString(),
                                                child: Text(genre.key.toString()),
                                              );
                                            }).toList(),
                                            onChanged: (value) {
                                              setState(() {
                                                Selectedgenre = value.toString();
                                              });
                                            },
                                          ),
                                          SizedBox(height: 20,),
                                        ],
                                      ),
                                    );
                                  }
                                  return Container();
                                },
                              ),
                              Wrap(
                                alignment: WrapAlignment.spaceEvenly,
                                direction: Axis.horizontal,
                                spacing: 10,
                                runSpacing: 10,
                                children: List.generate(
                                  books.length,
                                  (index) {
                                    return InkWell(
                                      onTap: () async {
                                        var Counts =
                                            books.elementAt(index).child('review_counts').value;
                                        Counts = (Counts as int) + 1;

                                        await cBooks.dbTeklib
                                            .child(
                                                'dbTeklib/books/${books.elementAt(index).key.toString()}')
                                            .update({
                                          "review_counts": Counts
                                        }).then((value) {
                                          Get.toNamed(
                                            Routes.VIEWBOOK,
                                            parameters: Map.from({
                                              "page": "Books",
                                              "query": "",
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
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          );
                        }
                        return Center(
                          child: Text("No Data Or Loading ..."),
                        );
                      },
                    ),
                  ),
                ],
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
                      bottomLeft: Radius.circular(17),
                      bottomRight: Radius.circular(17),
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
                      if (Get.parameters.containsKey("from"))
                        InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: Icon(
                            Icons.arrow_back_ios_new_rounded,
                            color: Colors.red,
                          ),
                        )
                      else
                        Text(
                          "TEKLIB",
                          style: TextStyle(
                              letterSpacing: 2,
                              color: const Color.fromARGB(255, 255, 0, 0),
                              fontWeight: FontWeight.bold),
                        ),
                      Text(
                        (Get.parameters.containsKey("from"))
                            ? "${Get.parameters['title'].toString()}"
                            : "${Get.parameters['page']}",
                        style: TextStyle(
                            letterSpacing: 2,
                            color: const Color.fromARGB(255, 255, 0, 0),
                            fontWeight: FontWeight.bold),
                      ),
                      if (Get.parameters.containsKey("from"))
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
                        )
                      else
                        Row(
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  isFilterOpen = !isFilterOpen;
                                  Selectedgenre = null;
                                });
                              },
                              child: Container(
                                child: Icon(
                                  (isFilterOpen == true) ? Icons.filter_alt_off :
                                  Icons.filter_alt_rounded,
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
              if (Get.parameters['page'] == "Books" &&
                  Get.parameters['from'] != "insideViewBook")
                bottomNav(),
            ],
          ),
        ),
      ),
    );
  }
}
