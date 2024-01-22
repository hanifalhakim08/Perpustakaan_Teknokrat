import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:perpustakaan_teknokrat/app/modules/manageusers/screens/detailuser.dart';
import 'package:perpustakaan_teknokrat/app/modules/widgets/bottomNav.dart';
import 'package:perpustakaan_teknokrat/app/routes/app_pages.dart';

import '../controllers/manageusers_controller.dart';

class ManageusersView extends GetView<ManageusersController> {
  const ManageusersView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return manageUsersScreen();
  }
}

class manageUsersScreen extends StatefulWidget {
  const manageUsersScreen({super.key});

  @override
  State<manageUsersScreen> createState() => _manageUsersScreenState();
}

class _manageUsersScreenState extends State<manageUsersScreen> {
  final cUsers = Get.put(ManageusersController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Swidth = MediaQuery.of(context).size.width;
    final Sheight = MediaQuery.of(context).size.height;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            Container(
              width: Swidth,
              height: Sheight,
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top + 70,
                  bottom: 60,
                  left: 15,
                  right: 15),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 40,
                          child: TextField(
                            onChanged: (value) {
                              setState(() {
                                cUsers.cSearch.value.text = value;
                              });
                            },
                            controller: cUsers.cSearch.value,
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
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      InkWell(
                        onTap: () {
                          Get.to(
                            () => detailUser(),
                          );
                        },
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.red),
                          child: Icon(
                            Icons.add_circle_outline_rounded,
                            color: Colors.white,
                            size: 25,
                          ),
                        ),
                      )
                    ],
                  ),
                  Expanded(
                    child: StreamBuilder(
                        stream: cUsers.dbTeklib.child('dbTeklib/users').onValue,
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return Text("no data");
                          }
                          var users = snapshot.data!.snapshot;
                          return ListView(
                            padding: EdgeInsets.only(top: 10),
                            children: [
                              for (var user in users.children)
                                ListTile(
                                  onTap: () {
                                    Get.to(
                                      () => detailUser(),
                                      arguments: {
                                        "user": user
                                      }
                                    );
                                  },
                                  leading: Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(25),
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                            user
                                                .child('profile_pic')
                                                .value
                                                .toString(),
                                          ),
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey,
                                            blurRadius: 1,
                                            offset: Offset(0, 0.5),
                                          )
                                        ]),
                                  ),
                                  title: Text(
                                    user.child('username').value.toString(),
                                  ),
                                  subtitle: Text(
                                    user.child('email').value.toString(),
                                  ),
                                  trailing: Text("View"),
                                ),
                            ],
                          );
                        }),
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
                    InkWell(
                      onTap: () {
                        Get.offAllNamed(Routes.PANELADMIN, parameters: {
                          "page": "Panel Admin",
                        });
                        setState(() {});
                      },
                      child: Icon(Icons.arrow_back_ios_new, color: Colors.red),
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
          ],
        ),
      ),
    );
  }
}
