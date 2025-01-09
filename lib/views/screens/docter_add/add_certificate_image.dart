import 'dart:developer';
import 'package:cc_dr_side/views/screens/singn%20in%20or%20login/create_dr_account.dart';
import 'package:cc_dr_side/views/widgets/doctor_add/add_cetificate_image/certificate_image_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cc_dr_side/controllers/auth_controller.dart';
import 'package:cc_dr_side/functions/upload_image_s3bucket.dart';
import 'package:cc_dr_side/model/dr_model.dart';
import 'package:cc_dr_side/views/utils/costum_widgets/custom_error_message.dart';

class AddCertificateImage extends StatefulWidget {
  const AddCertificateImage({super.key, required this.doctor});
  final Doctor doctor;

  @override
  State<AddCertificateImage> createState() => _AddCertificateImageState();
}

class _AddCertificateImageState extends State<AddCertificateImage> {
  final AuthController authController = Get.put(AuthController());
  bool isLoading = false;

  Future<void> _handleUpload() async {
    if (authController.certificateImage.value == null) {
      customErrorMessage(context, 'Please add certificate image');
      return;
    }
    setState(() {
      isLoading = true;
    });
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
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back_ios),
        ),
        backgroundColor: const Color(0xFFF5F5F5),
        title: const Text(
          'Add Certificate',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          CertificateImagePicker(authController: authController),
          Positioned(
            bottom: 50,
            left: 16,
            right: 16,
            child: ElevatedButton(
              onPressed: _handleUpload,
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                backgroundColor: const Color(0xFF4A78FF),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              child: isLoading
                  ? const CircularProgressIndicator(
                      color: Colors.white,
                    )
                  : const Text(
                      "Sign in",
                      style: TextStyle(color: Colors.white),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
