import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:perpustakaan_teknokrat/app/modules/widgets/bottomNav.dart';
import 'package:perpustakaan_teknokrat/app/modules/widgets/header.dart';

import '../controllers/favorite_controller.dart';

class FavoriteView extends GetView<FavoriteController> {
  const FavoriteView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return favoriteScreen();
  }
}

class favoriteScreen extends StatefulWidget {
  const favoriteScreen({super.key});

  @override
  State<favoriteScreen> createState() => _favoriteScreenState();
}

class _favoriteScreenState extends State<favoriteScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
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
              Padding(
                padding: EdgeInsets.only(
                    top: (MediaQuery.of(context).padding.top + 40),
                    bottom: 60,
                    left: 15,
                    right: 15),
                child: ListView(
                  scrollDirection: Axis.vertical,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 40,
                      padding: EdgeInsets.only(left: 10, right: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 5,
                          ),
                          Container(
                            child: Text(
                              "Books Genres",
                              style: TextStyle(
                                  color: const Color.fromARGB(255, 255, 0, 0),
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Expanded(
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: List.generate(
                                10,
                                (index) => Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  alignment: Alignment.center,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10,
                                        bottom: 10,
                                        left: 20,
                                        right: 20),
                                    child: InkWell(
                                      child: Text(
                                          "Genre",  
                                        style: TextStyle(
                                            color: (index == 1) ? Colors.red  :Color.fromARGB(255, 50, 50, 50),
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Wrap(
                      alignment: WrapAlignment.spaceEvenly,
                      direction: Axis.horizontal,
                      children: List.generate(
                        50,
                        (index) => Container(
                          height: 200,
                          width: 150,
                          child: Stack(
                            children: [
                              Positioned(
                                top: 10,
                                left: 10,
                                child: Container(
                                  width: 140,
                                  height: 185,
                                  decoration: BoxDecoration(
                                      color: const Color.fromARGB(255, 156, 156, 156),
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                              ),
                              Positioned(
                                top: 0,
                                left: 0,
                                child: Container(
                                  width: 140,
                                  height: 185,
                                  decoration: BoxDecoration(
                                      color: Colors.amber,
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                              ),
                              Positioned(
                                bottom: 5,
                                right: 5,
                                child: Icon(
                                  Icons.bookmark,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
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
                        "${Get.parameters['page']}",
                        style: TextStyle(
                            letterSpacing: 2,
                            color: const Color.fromARGB(255, 255, 0, 0),
                            fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          Container(
                            child: Icon(
                              Icons.search,
                              color: const Color.fromARGB(255, 255, 0, 0),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          InkWell(
                            onTap: () {
                              scaffoldKey.currentState!.openEndDrawer();
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
