import 'package:flutter/material.dart';
import 'package:get/get.dart';

class detailUser extends StatefulWidget {
  const detailUser({super.key});

  @override
  State<detailUser> createState() => _detailUserState();
}

class _detailUserState extends State<detailUser> {
  var user;
  @override
  void initState() {
    super.initState();
    user = Get.arguments['user'];
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15)),
          ),
          centerTitle: true,
          leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: Icon(
              Icons.arrow_back_ios_new,
              color: Colors.red,
            ),
          ),
          title: Text(
            "Detail User",
            style: TextStyle(
                color: Colors.red,
                fontSize: 15,
                letterSpacing: 1,
                fontWeight: FontWeight.bold),
          ),
        ),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 130,
                    width: 130,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 1,
                          offset: Offset(0, 0.5),
                        ),
                      ],
                    ),
                    child: Container(
                      width: 110,
                      height: 110,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                            user.child('profile_pic').value.toString(),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Text("Username : ${user.child('username').value.toString()}"),
                  Text("Email : ${user.child('username').value.toString()}"),
                  Text("Bio : ${user.child('username').value.toString()}"),
                  Text("Username : ${user.child('username').value.toString()}"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
