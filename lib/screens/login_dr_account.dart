import 'dart:developer';

import 'package:cc_dr_side/screens/home_page.dart';
import 'package:cc_dr_side/services/authentication/authentication_service.dart';
import 'package:cc_dr_side/widgets/custom_error_message.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginDrAccount extends StatefulWidget {
  const LoginDrAccount({super.key, });


  @override
  State<LoginDrAccount> createState() => _LoginDrAccountState();
}

class _LoginDrAccountState extends State<LoginDrAccount> {
  Authentication authentication = Authentication();

  @override
  Widget build(BuildContext context) {
 
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Hey Doctor',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFF4A78FF),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
      ),
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Background container with rounded bottom
          Container(
            height: 650,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Color(0xFF4A78FF),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/Screenshot_2024-11-20_120720-removebg-preview.png',
                  height: 250,
                  alignment: Alignment.center,
                ),
                SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    'Join our trusted network. Register your profile, manage appointments, and connect with patients.',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ],
            ),
          ),

          Column(
            children: [
              Expanded(
                child: Container(),
              ),
              Container(
                padding: EdgeInsets.only(bottom: 50),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'continue with',
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(height: 15),
                    GestureDetector(
                      onTap: () async {
              final user = await  authentication.loginWithGoogle();
              if(user!= null){
            final bool isDrExist = await authentication.checkDrExist(user.email!);
            log(isDrExist.toString());
            if (isDrExist) {
              Get.offAll(()=>HomePage());
            }else{
              customErrorMessage(context, "You don't have an account Please create new account");
            }
              }
                      },
                      child: Container(
                        width: 250,
                        padding: EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(23),
                          border:
                              Border.all(color: Colors.grey.withOpacity(0.3)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/google.png',
                              width: 24,
                              height: 24,
                            ),
                            SizedBox(width: 10),
                            Text(
                              'Sign In with Google',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
