import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:perpustakaan_teknokrat/app/controller/auth_controller.dart';
import 'package:perpustakaan_teknokrat/app/routes/app_pages.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return loginScreen();
  }
}

class loginScreen extends StatefulWidget {
  const loginScreen({super.key});

  @override
  State<loginScreen> createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen> {
  final cAuth = Get.find<AuthController>();
  final cLog = Get.put(LoginController());
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
                                "LOGIN",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.orange[900],
                                  letterSpacing: 1,
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Get.offAllNamed(Routes.RESETPASSWORD);
                                },
                                child: Text(
                                  "Forgot Password?",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Color.fromARGB(255, 0, 54, 154)
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15,
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
                              controller: cLog.cEmail,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Email",
                                contentPadding: EdgeInsets.only(left: 10, right: 10),
                              )
                            ),
                          ),
                          SizedBox(
                            height: 20,
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
                              controller: cLog.cPass,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Password",
                                contentPadding:
                                    EdgeInsets.only(left: 10, right: 10),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start  ,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Don't Have An Account?",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Color.fromARGB(255, 0, 0, 0)
                                    ),
                                  ),
                                  InkWell(
                                    onTap: (){
                                      Get.offAllNamed(Routes.REGISTER);
                                    },
                                    child: Text(
                                      "Register Here",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Color.fromARGB(255, 0, 128, 255)
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              
                              SizedBox(width: 15,),
                              InkWell(
                                onTap: () {
                                  cAuth.login(cLog.cEmail.text, cLog.cPass.text);
                                },
                                child: Container(
                                height: 40,
                                alignment: Alignment.center,
                                padding: EdgeInsets.only(left:20, right: 20, top: 10, bottom: 10),
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 218, 0, 0),
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black,
                                      blurRadius: 1,  
                                      offset: Offset(0,0),
                                    ),
                                  ],
                                ),
                                child: Text("Login",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    letterSpacing: 0.5,
                                  )
                                ),
                              ),
                              )
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
