import 'package:cc_dr_side/views/widgets/doctor_edit/dr_edit_format_widget.dart';
import 'package:cc_dr_side/views/widgets/doctor_edit/profile_image_widget.dart';
import 'package:cc_dr_side/views/widgets/doctor_edit/upload_certificate_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../model/dr_model.dart';

class DrEditScreen extends StatefulWidget {
  const DrEditScreen({
    super.key,
    required this.doctor,
  });
  final Doctor doctor;

  @override
  State<DrEditScreen> createState() => _DrEditScreenState();
}

class _DrEditScreenState extends State<DrEditScreen> {
  final _formKey = GlobalKey<FormState>();
  final Color primaryColor = const Color(0xFF4A78FF);
  String? drImagePath;
  String? certificateImagePath;

  void updateProfileImage(String? path) {
    setState(() {
      drImagePath = path;
    });
  }

  void updateCertificateImage(String? path) {
    setState(() {
      certificateImagePath = path;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
        ),
        title: const Text(
          'Edit Profile',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProfileImageWidget(
                doctor: widget.doctor,
                onImageSelected: updateProfileImage,
              ),
              const SizedBox(height: 24),
              CertificateUploadWidget(
                doctor: widget.doctor,
                onImageSelected: updateCertificateImage,
              ),
              const SizedBox(height: 24),
              DrEditFormWidget(
                doctor: widget.doctor,
                drImagePath: drImagePath,
                certificateImagePath: certificateImagePath,
              ),
            ],
          ),
        ),
      ),
    );
  }
}


