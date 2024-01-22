import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:perpustakaan_teknokrat/app/controller/auth_controller.dart';
import 'package:perpustakaan_teknokrat/app/modules/profile/controllers/profile_controller.dart';
import 'package:perpustakaan_teknokrat/app/routes/app_pages.dart';

import '../manageBooks/controllers/manage_books_controller.dart';

class bottomNav extends StatefulWidget {
  const bottomNav({super.key});

  @override
  State<bottomNav> createState() => _bottomNavState();
}

class _bottomNavState extends State<bottomNav> {
  final cManageBooks = Get.put(ManageBooksController());
  final cAuth = Get.find<AuthController>();

  String initialPage = "home";
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      child: Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width,
        height: 60,
        padding: EdgeInsets.only(top: 10, bottom: 10),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 1,
              offset: Offset(0, -0.5),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if(cAuth.auth.currentUser!.uid == cAuth.ADMIN)
            InkWell(
              onTap: () {
                Get.offAllNamed(Routes.PANELADMIN, parameters: {
                  "page": "Panel Admin",
                });
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: (Get.parameters["page"] == "Panel Admin")
                            ? Colors.white
                            : Colors.transparent,
                      ),
                    ),
                    child: Icon(
                      Icons.add_box_outlined,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            )
            else
            InkWell(
              onTap: () {
                Get.offAllNamed(Routes.BOOKS, parameters: {
                  // "page": "Panel Admin",
                  "page": "Books",
                  "query": "",
                });
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: (Get.parameters["page"] == "Books")
                            ? Colors.white
                            : Colors.transparent,
                      ),
                    ),
                    child: Icon(
                      Icons.menu_book,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                cManageBooks.dbTeklib.child('dbTeklib/books').once().then(
                      (value) => {
                        Get.offAllNamed(
                          Routes.SEARCHBOOK,
                          parameters: {
                            "page": "Search Book",
                          },
                          arguments: value,
                        )
                      },
                    );
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: (Get.parameters["page"] == "Search Book")
                            ? Colors.white
                            : Colors.transparent,
                      ),
                    ),
                    child: Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                Get.offAllNamed(Routes.HOME, parameters: {
                  "page": "Home",
                });
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: (Get.parameters["page"] == "Home")
                            ? Colors.white
                            : Colors.transparent,
                      ),
                    ),
                    child: Icon(
                      Icons.home,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  Get.offAllNamed(Routes.BOOKSHELF, parameters: {
                    "page": "Bookshelf",
                  });
                });
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: (Get.parameters["page"] == "Bookshelf")
                            ? Colors.white
                            : Colors.transparent,
                      ),
                    ),
                    child: Icon(
                      Icons.library_books,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                Get.offAllNamed(Routes.PROFILE, parameters: {
                  "page": "Profile",
                  },);
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: (Get.parameters["page"] == "Profile")
                            ? Colors.white
                            : Colors.transparent,
                      ),
                    ),
                    child: Icon(
                      Icons.account_circle,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
