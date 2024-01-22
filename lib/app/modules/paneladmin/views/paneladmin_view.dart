import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:perpustakaan_teknokrat/app/controller/auth_controller.dart';
import 'package:perpustakaan_teknokrat/app/controller/firebase_controller.dart';
import 'package:perpustakaan_teknokrat/app/modules/manageBooks/controllers/manage_books_controller.dart';
import 'package:perpustakaan_teknokrat/app/modules/widgets/bottomNav.dart';
import 'package:perpustakaan_teknokrat/app/routes/app_pages.dart';

import '../controllers/paneladmin_controller.dart';

class PaneladminView extends GetView<PaneladminController> {
  const PaneladminView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return PaneladminScreen();
  }
}

class PaneladminScreen extends StatefulWidget {
  const PaneladminScreen({super.key});

  @override
  State<PaneladminScreen> createState() => _PaneladminScreenState();
}

class _PaneladminScreenState extends State<PaneladminScreen> {
  final Fbase = Get.put(FirestoreController());
  final cAuth = Get.put(AuthController());
  final cManageBooks = Get.put(ManageBooksController());
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
              Container(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top + 60,
                  left: 15,
                  right: 15,
                  bottom: 40,
                ),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: ListView(
                  children: [
                    Center(
                      child: Wrap(
                        alignment: WrapAlignment.start,
                        direction: Axis.horizontal,
                        spacing: 10,
                        runSpacing: 10,
                        children: [
                          InkWell(
                            onTap: () {
                              cManageBooks.FetchBooks().then((value) => {
                                    Get.toNamed(
                                      Routes.MANAGE_BOOKS,
                                      parameters: {
                                        "page": "Manage Books",
                                      },
                                    )
                                  });
                            },
                            child: Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Icon(
                                Icons.menu_book,
                                size: 40,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Get.toNamed(
                                Routes.MANAGEUSERS,
                                parameters: {
                                  "page": "Manage Users",
                                },
                              );
                            },
                            child: Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Icon(
                                Icons.person,
                                size: 40,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Icon(
                              Icons.file_present_rounded,
                              size: 40,
                              color: Colors.white,
                            ),
                          ),
                          Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ],
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
