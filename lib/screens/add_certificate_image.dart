

import 'package:cc_dr_side/authentication/login.dart';
import 'package:cc_dr_side/model/dr_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddCertificateImage extends StatefulWidget {
  AddCertificateImage({super.key, required this.doctor});
  final Doctor doctor;

  @override
  State<AddCertificateImage> createState() => _AddCertificateImageState();
}

class _AddCertificateImageState extends State<AddCertificateImage> {
  // Doctor ?doctor;
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(Icons.arrow_back_ios)),
        backgroundColor: Color(0xFFF5F5F5),
        title: Text(
          'Add Certificate',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 95),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 350,
                    width: 350,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: Colors.white,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.add_a_photo_rounded,
                          size: 100,
                          color: Color(0xFF4A78FF),
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Tap to add image',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 50,
            left: 16,
            right: 16,
            child: ElevatedButton(
              onPressed: () {
                //   log("add failed${widget.doctor.toString()}");
                //  doctor = widget.doctor;
                Get.to(() => LoginPage(
                      doctor: widget.doctor,
                    ));
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                backgroundColor: Color(0xFF4A78FF),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              child: Text(
                "Sign in ",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
