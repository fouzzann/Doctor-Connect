import 'package:cc_dr_side/controllers/doctore_controller.dart';
import 'package:cc_dr_side/model/dr_model.dart';
import 'package:cc_dr_side/views/screens/dr_edit_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

Widget buildProfileHeader(BuildContext context) {
  final DoctorController doctorController = Get.put(DoctorController());
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 15,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        children: [
          Obx(() {
            final imageUrl = doctorController.doctorImage.value;
            return Hero(
              tag: 'profile_image',
              child: imageUrl.isNotEmpty
                  ? CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.grey[200],
                      backgroundImage: NetworkImage(imageUrl),
                      onBackgroundImageError: (_, __) {},
                    )
                  : CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.grey[200],
                      child: Icon(Icons.person, color: Colors.grey),
                    ),
            );
          }),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(() => Text(
                      "Dr. ${doctorController.doctorName.value}",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    )),
                SizedBox(height: 8),
                Text(
                  doctorController.doctorCategory.value,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(Icons.edit, color: Color(0xFF4A78FF)),
            onPressed: () {
              final Doctor doctor = Doctor(
                  image: doctorController.doctorImage.value, 
                  fullName: doctorController.doctorName.value,
                  age: doctorController.age.value,
                  email: FirebaseAuth.instance.currentUser!.email.toString(),
                  gender: '',
                  uid: 'uid',
                  category: doctorController.doctorCategory.value,
                  hospitalName: doctorController.hospitalName.value,
                  location: '',
                  isAccepted: true,
                  consultationFee: '',
                  yearsOfExperience: doctorController.yearsOfExperience.value,
                  certificateImage: doctorController.certificateImage.value,
                  availableDays: []);
              Get.to(
                  () => DrEditScreen(
                        doctor: doctor,
                      ),
                  transition: Transition.rightToLeftWithFade);
            },
          ),
        ],
      ),
    ).animate().fadeIn(duration: 500.ms).moveY(begin: 50, end: 0),
  );
}
