import 'dart:math';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:perpustakaan_teknokrat/app/modules/widgets/bottomNav.dart';
import 'package:perpustakaan_teknokrat/app/routes/app_pages.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return profileScreen();
  }
}

class profileScreen extends StatefulWidget {
  const profileScreen({super.key});

  @override
  State<profileScreen> createState() => _profileScreenState();
}

class _profileScreenState extends State<profileScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final cProfile = Get.put(ProfileController());
  var ActiveTab = "collection";
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
    cProfile.checkUser();
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
        body: Stack(
          children: [
            StreamBuilder(
              stream: ProfileController()
                  .dbTeklib
                  .child(
                      'dbTeklib/users/${cProfile.cAuth.auth.currentUser!.uid}')
                  .onValue,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Container();
                }
                var ProfileData = snapshot.data!.snapshot;
                var favBooks = ProfileData.child('favorite_book/book_id')
                    .value
                    .toString()
                    .replaceAll('[', '')
                    .replaceAll(']', '')
                    .replaceAll(' ', '')
                    .split(',');
                print(favBooks);
                List matchedBooks = [];
                return Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: ListView(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.only(
                            top: 80, bottom: 20, left: 20, right: 20),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 214, 14, 0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 1,
                              offset: Offset(0, 0.5),
                            )
                          ],
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20)),
                        ),
                        child: Center(
                          child: Container(
                            width: 130,
                            height: 130,
                            decoration: BoxDecoration(
                            color: Colors.white,
                                borderRadius: BorderRadius.circular(65),
                            ),
                            alignment: Alignment.center,
                            child: Container(
                              width: 120,
                              height: 120,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(60),
                                color: Colors.white,
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                        "${ProfileData.child('profile_pic').value}")),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width - 20,
                        child: Text(
                          "${ProfileData.child('username').value}",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              width: 70,
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    ActiveTab = "collection";
                                    cProfile.clearController();
                                  });
                                },
                                child: Icon(
                                  Icons.library_books_sharp,
                                  color: ActiveTab == "collection"
                                      ? Colors.red
                                      : Colors.black,
                                ),
                              ),
                            ),
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "${ProfileData.child('email').value}",
                                ),
                                Text(
                                  "${ProfileData.child('bio').value}",
                                ),
                              ],
                            )),
                            Container(
                              width: 70,
                              child: InkWell(
                                onTap: () {
                                  cProfile.clearController();
                                  setState(() {
                                    ActiveTab = "profileSetting";
                                  });
                                },
                                child: Icon(
                                  Icons.settings,
                                  color: ActiveTab == "profileSetting"
                                      ? Colors.red
                                      : Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      if (ActiveTab == "collection")
                        Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                blurRadius: 1,
                                offset: Offset(0, -0.5),
                              )
                            ],
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20)),
                          ),
                          child: Column(
                            children: [
                              SizedBox(height: 10),
                              Text(
                                "Favorite Genre",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 10),
                              if (ProfileData.hasChild('favorite_genre') &&
                                  ProfileData.child('favorite_genre').value !=
                                      "")
                                Container(
                                  width: MediaQuery.of(context).size.width - 40,
                                  height: 40,
                                  child: ListView.separated(
                                    scrollDirection: Axis.horizontal,
                                    separatorBuilder: (context, index) =>
                                        SizedBox(
                                      width: 10,
                                    ),
                                    itemCount: 10,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        height: 40,
                                        padding: EdgeInsets.only(
                                            left: 20, right: 20),
                                        decoration: BoxDecoration(
                                            color: randomColor(),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey,
                                                blurRadius: 1,
                                                offset: Offset(0, 0.5),
                                              )
                                            ],
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        alignment: Alignment.center,
                                        child: Text("genre"),
                                      );
                                    },
                                  ),
                                )
                              else
                                Text("No data"),
                              SizedBox(height: 20),
                              Text(
                                "Your Favorite Book",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Divider(),
                              SizedBox(height: 10),
                              if (ProfileData.hasChild('favorite_book') &&
                                  ProfileData.child('favorite_book').value !=
                                      "")
                                FutureBuilder(
                                  future: ProfileController()
                                      .dbTeklib
                                      .child('dbTeklib/books')
                                      .once(),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return Text("Please wait");
                                    } else if (snapshot.hasError) {
                                      return Text('Error: ${snapshot.error}');
                                    } else if (!snapshot.hasData) {
                                      return Text('No data available');
                                    } else {
                                      if (snapshot
                                          .data!.snapshot.children.isNotEmpty) {
                                        var books =
                                            snapshot.data!.snapshot.children;
                                        // print(books);
                                        books.forEach((book) {
                                          if (favBooks.contains(book.key)) {
                                            matchedBooks.add(book);
                                          }
                                        });
                                      }

                                      return Container(
                                        width:
                                            MediaQuery.of(context).size.width -
                                                40,
                                        padding: EdgeInsets.only(bottom: 70),
                                        child: Wrap(
                                          alignment: WrapAlignment.spaceBetween,
                                          runSpacing: 20,
                                          direction: Axis.horizontal,
                                          children: [
                                            if (matchedBooks.isNotEmpty)
                                              for (var book in matchedBooks)
                                                InkWell(
                                                  onTap: () async{
                                                      var Counts = book.child('review_counts').value;
                                                      Counts = Counts += 1;
                                                      
                                                      await cProfile
                                                          .dbTeklib
                                                          .child(
                                                              'dbTeklib/books/${book.key.toString()}')
                                                          .update({"review_counts": Counts}).then((value) {
                                                      
                                                      Get.toNamed(Routes.VIEWBOOK,
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
                                                      });
                                                    },
                                                  child: Container(
                                                    height: 220,
                                                    width: 150,
                                                    decoration: BoxDecoration(
                                                      color: randomColor(),
                                                      image: DecorationImage(
                                                        fit: BoxFit.cover,
                                                        image: NetworkImage(
                                                            "${book.child('image_cover').value}"),
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Colors.grey,
                                                          blurRadius: 1,
                                                          offset: Offset(0, 0.5),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                )
                                            else
                                              Container(
                                                alignment: Alignment.center,
                                                height: 250,
                                                child: Text("no data"),
                                              ),
                                          ],
                                        ),
                                      );
                                    }
                                  },
                                )
                            ],
                          ),
                        )
                      else
                        Container(
                          width: MediaQuery.of(context).size.width - 20,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                blurRadius: 1,
                                offset: Offset(0, -0.5),
                              )
                            ],
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 10),
                              Center(
                                child: Text(
                                  "Profile Setting",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      (cProfile.pickedImage.isNotEmpty)
                                          ? "${cProfile.pickedImage['image_name']}"
                                          : 'Chose new profile picture',
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      cProfile
                                          .pickImage()
                                          .then((value) => setState(() {}));
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          right: 11, left: 11),
                                      child: Icon(
                                        Icons.image,
                                        color: Colors.blue,
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      cProfile
                                          .changeImage()
                                          .then((value) => {setState(() {
                                            cProfile.clearController();
                                          })});
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          right: 11, left: 11),
                                      child: Icon(
                                        Icons.save,
                                        color: Colors.blue,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 20),
                              TextField(
                                controller: cProfile.cUsername,
                                decoration: InputDecoration(
                                  label: Text("change username"),
                                  border: OutlineInputBorder(),
                                  suffixIcon: InkWell(
                                    onTap: () {
                                      cProfile
                                          .changeUsername()
                                          .then((value) => {
                                                setState(() {
                                                  cProfile.clearController();
                                                }),
                                              });
                                    },
                                    child: Icon(
                                      Icons.save,
                                      color: Colors.blue,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),
                              TextField(
                                controller: cProfile.cBio,
                                decoration: InputDecoration(
                                  label: Text("change bio"),
                                  border: OutlineInputBorder(),
                                  suffixIcon: InkWell(
                                    onTap: () {
                                      cProfile.changeBio().then((value) => {
                                            setState(() {
                                              cProfile.clearController();
                                            }),
                                          });
                                    },
                                    child: Icon(
                                      Icons.save,
                                      color: Colors.blue,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),
                              Text(
                                "Reset Password",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 10),
                              TextField(
                                controller: cProfile.cEmail,
                                decoration: InputDecoration(
                                  label: Text("insert email"),
                                  border: OutlineInputBorder(),
                                  suffixIcon: InkWell(
                                    onTap: () {
                                      cProfile.cAuth
                                          .resetPassword(cProfile.cEmail.text);
                                      cProfile.clearController();
                                    },
                                    child: Icon(
                                      Icons.send,
                                      color: Colors.blue,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 60),
                            ],
                          ),
                        ),
                    ],
                  ),
                );
              },
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
                        cProfile.cAuth.logout();
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
    );
  }
}
