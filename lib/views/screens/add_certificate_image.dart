import 'dart:developer';

import 'package:cc_dr_side/views/screens/singn%20in%20or%20login/create_dr_account.dart';
import 'package:cc_dr_side/controllers/auth_controller.dart';
import 'package:cc_dr_side/functions/upload_image_s3bucket.dart';
import 'package:cc_dr_side/model/dr_model.dart';
import 'package:cc_dr_side/views/utils/costum_widgets/custom_error_message.dart';
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
    final AuthController authController = Get.put(AuthController());

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
                  GestureDetector(
                    onTap: () {
                      authController.PicCertificateImage();
                    },
                    child: Obx(
                      () {
                        return Container(
                            height: 350,
                            width: 350,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                              color: Colors.white,
                            ),
                            child: authController.certificateImage.value == null
                                ? Column(
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
                                  )
                                : Center(
                                    child: Image.file(
                                    authController.certificateImage.value!,
                                    fit: BoxFit.fill,
                                  )));
                      },
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
              onPressed: () async {
                if (authController.certificateImage.value == null) {
                  customErrorMessage(context, 'Please add certificate image');
                } else {
                  final certificate =
                      await uploadImage(authController.certificateImage.value!);
                  if (certificate != null) {
                    Get.to(
                      () => CreateDrAccount(
                        doctor: widget.doctor,
                        certificateImage: certificate,
                      ),
                      transition: Transition.rightToLeftWithFade,
                    );
                  } else {
                    log('Image upload failed');
                  }
                }
                //   log("add failed${widget.doctor.toString()}");
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
