import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:perpustakaan_teknokrat/app/controller/auth_controller.dart';
import 'package:perpustakaan_teknokrat/app/routes/app_pages.dart';

import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return registerScreen();
  }
}

class registerScreen extends StatefulWidget {
  const registerScreen({super.key});

  @override
  State<registerScreen> createState() => _registerScreenState();
}

class _registerScreenState extends State<registerScreen> {
  final cAuth = Get.find<AuthController>();
  final cReg = Get.put(RegisterController());

  @override
  Widget build(BuildContext context) {
    final SIZE = MediaQuery.of(context).size;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          width: SIZE.width,
          height: SIZE.height,
          child: Column(
            children: [
              Container(
                width: SIZE.width,
                child: Image(
                  image: AssetImage('assets/images/vectorauth2.png'),
                ),
              ),
              Expanded(
                child: Stack(
                  children: [
                    Positioned(
                      bottom: 0,
                      child: Container(
                        width: SIZE.width,
                        child: Image(
                          image: AssetImage('assets/images/vectorauth.png'),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(25),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "REGISTER",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.orange[900],
                                  letterSpacing: 1,
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Get.offAllNamed(Routes.LOGIN);
                                },
                                child: Text(
                                  "Login Here",
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Color.fromARGB(255, 0, 128, 255)),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: SIZE.width,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.grey, width: 1),
                            ),
                            child: TextField(
                              controller: cReg.cEmail,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Email",
                                contentPadding:
                                    EdgeInsets.only(left: 10, right: 10),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: SIZE.width,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.grey, width: 1),
                            ),
                            child: TextField(
                              controller: cReg.cUser,
                                decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Username",
                              contentPadding:
                                  EdgeInsets.only(left: 10, right: 10),
                            )),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: SIZE.width,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.grey, width: 1),
                            ),
                            child: TextField(
                              controller: cReg.cPass,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Create Password",
                                contentPadding:
                                    EdgeInsets.only(left: 10, right: 10),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              InkWell(
                                onTap: () {

                                  if(cReg.cPass.text.length < 6){
                                    Get.defaultDialog(
                                      title: "Password Weak",
                                      middleText: "Your password must be at least 6 characters, try again",
                                    );
                                  }else{
                                    cAuth.signup(cReg.cEmail.text, cReg.cUser.text, cReg.cPass.text);
                                  }
                                },
                                child: Container(
                                  height: 40,
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.only(
                                      left: 20, right: 20, top: 10, bottom: 10),
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 218, 0, 0),
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black,
                                        blurRadius: 1,
                                        offset: Offset(0, 0),
                                      ),
                                    ],
                                  ),
                                  child: Text("Register",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                        letterSpacing: 0.5,
                                      )),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
