import 'dart:developer';

import 'package:cc_dr_side/model/dr_model.dart';
import 'package:cc_dr_side/screens/home_page.dart';
import 'package:cc_dr_side/services/authentication/authentication_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateDrAccount extends StatefulWidget {
  const CreateDrAccount({super.key, required this.doctor, required this.certificateImage, });
  final Doctor doctor;
  final String certificateImage;
  

  @override
  State<CreateDrAccount> createState() => _CreateDrAccountState();
}

class _CreateDrAccountState extends State<CreateDrAccount> {
  Authentication authentication = Authentication();

  @override
  Widget build(BuildContext context) {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        Get.offAll(() => HomePage());
      }
    });

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
                        log("null check${widget.doctor.toString()}");
                        try {
                          final user = await authentication.loginWithGoogle();
                          if (user != null) {
                            final fullDoctorData = Doctor(
                                image: widget.doctor.image,
                                fullName: widget.doctor.fullName,
                                age: widget.doctor.age,
                                email: user.email!,
                                gender: widget.doctor.gender,
                                uid: user.uid,
                                category: widget.doctor.category,
                                hospitalName: widget.doctor.hospitalName,
                                location: '',
                                isAccepted: false,
                                consultationFee: widget.doctor.consultationFee,
                                yearsOfExperience:
                                    widget.doctor.yearsOfExperience,
                                certificateImage:widget.certificateImage,
                                availableDays: widget.doctor.availableDays);
                            authentication.dataSubmition(fullDoctorData);
                          } else {
                            log('user is null');
                          }
                        } catch (e) {
                          log('login faild ${e}');
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
