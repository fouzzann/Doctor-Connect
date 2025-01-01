import 'package:cc_dr_side/views/widgets/dr_details_page/detailed_Information.dart';
import 'package:cc_dr_side/views/widgets/dr_details_page/profile_Image_and_basic_Info.dart';
import 'package:flutter/material.dart';
import 'package:cc_dr_side/model/dr_model.dart';
import 'package:get/get.dart';

class AccountDetailsPage extends StatelessWidget {
  final Doctor doctor;
  final Color primaryColor = const Color(0xFF4A78FF);

  const AccountDetailsPage({
    Key? key,
    required this.doctor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
        ),
        title: const Text(
          'Doctor Details',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [ProfileImageAndBasicInfo(doctor: doctor)],
              ),
            ),
            const SizedBox(height: 16),
            DetailedInformation(doctor: doctor),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
