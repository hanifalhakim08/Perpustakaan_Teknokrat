import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:perpustakaan_teknokrat/app/controller/auth_controller.dart';
import 'package:perpustakaan_teknokrat/app/routes/app_pages.dart';
import 'package:random_string/random_string.dart';

import '../controllers/resetpassword_controller.dart';

class ResetpasswordView extends GetView<ResetpasswordController> {
  const ResetpasswordView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return resetPasswordScreen();
  }
}

class resetPasswordScreen extends StatefulWidget {
  const resetPasswordScreen({super.key});

  @override
  State<resetPasswordScreen> createState() => _resetPasswordScreenState();
}

class _resetPasswordScreenState extends State<resetPasswordScreen> {
  final cAuth = Get.find<AuthController>();
  final cReset = Get.put(ResetpasswordController());
  String Capca = "";

  String randCaptcha(){
    Capca = randomAlpha(6);
    return Capca;
  }

  @override
  void initState() {
    super.initState();
    randCaptcha();
  }

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
                                "RESET PASWORD",
                                style: TextStyle(
                                  fontSize: 16,
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
                              controller: cReset.cEmail,
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                            width: SIZE.width * 0.5,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.grey, width: 1),
                            ),
                            child: TextField(
                              controller: cReset.cCaptcha,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Re-Enter Code",
                                contentPadding:
                                    EdgeInsets.only(left: 10, right: 10),
                              ),
                            ),
                          ),
                          Container(
                            width: SIZE.width * 0.3,
                            height: 50,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 241, 241, 241),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.grey, width: 1),
                            ),
                            child: Text('${Capca}',
                            style: TextStyle(
                              letterSpacing: 2
                            ),
                            ),
                          ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start  ,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              SizedBox(width: 15,),
                              InkWell(
                                onTap: (){
                                  if(cReset.cCaptcha.text != Capca){
                                    Get.defaultDialog(
                                      title: "Captcha",
                                      middleText: "Captcha not match",
                                    );
                                  }else{
                                    cAuth.resetPassword(cReset.cEmail.text);
                                  }
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
                                  child: Text("Reset",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      letterSpacing: 0.5,
                                    )
                                  ),
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
