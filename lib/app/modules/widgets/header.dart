import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:perpustakaan_teknokrat/app/controller/auth_controller.dart';
import 'package:perpustakaan_teknokrat/app/controller/firebase_controller.dart';
import 'package:perpustakaan_teknokrat/app/modules/home/views/home_view.dart';
import 'package:perpustakaan_teknokrat/app/routes/app_pages.dart';

class header extends StatefulWidget {
  const header({super.key});

  @override
  State<header> createState() => _headerState();
}

class _headerState extends State<header> {
  final cAuth = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      child: Container(
        padding: EdgeInsets.only(
            left: 15, right: 15, top: MediaQuery.of(context).padding.top),
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
    );
  }
}
