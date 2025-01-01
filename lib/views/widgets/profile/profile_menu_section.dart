import 'package:cc_dr_side/controllers/doctore_controller.dart';
import 'package:cc_dr_side/model/dr_model.dart';
import 'package:cc_dr_side/services/authentication/authentication_service.dart';
import 'package:cc_dr_side/views/screens/login_or_register_doctor.dart';
import 'package:cc_dr_side/views/screens/profile%20page/account_details_page.dart';
import 'package:cc_dr_side/views/screens/profile%20page/privecy_and_policy.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

Widget buildProfileMenuSection(BuildContext context) {
  final Authentication authentication = Authentication(); // Initialize Authentication service
  final DoctorController doctorController = Get.put(DoctorController());
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16),
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
    child: Column(
      children: [
        _buildMenuItem(
          icon: Icons.person_outline,
          title: 'Account Details',
          onTap: () {
                       final Doctor doctor = Doctor(
                  image: doctorController.doctorImage.value, 
                  fullName: doctorController.doctorName.value,
                  age: doctorController.age.value,
                  email: FirebaseAuth.instance.currentUser!.email.toString(),
                  gender: doctorController.Drgender.value, 
                  uid: 'uid',
                  category: doctorController.doctorCategory.value,
                  hospitalName: doctorController.hospitalName.value,
                  location: doctorController.location.value, 
                  isAccepted: true,
                  consultationFee: doctorController.consultationFee.value.toString(), 
                  yearsOfExperience: doctorController.yearsOfExperience.value,
                  certificateImage: doctorController.certificateImage.value,
                  availableDays: []);
              Get.to(
                  () => AccountDetailsPage(
                        doctor: doctor,
                      ),
                  transition: Transition.rightToLeftWithFade);
          },
        ),
        _buildDivider(),
        _buildMenuItem(
          icon: Icons.shield_outlined,
          title: 'Privacy Policy',
          onTap: () => Get.to(() => PrivacyPolicyPage()),
        ),
        _buildDivider(),
        _buildMenuItem(
          icon: Icons.help_outline,
          title: 'Help & Support',
          onTap: () {
            // TODO: Implement help support
          },
        ),
        _buildDivider(),
        _buildMenuItem(
          icon: Icons.logout,
          title: 'Logout',
          textColor: Colors.red,
          onTap: () => _showLogoutDialog(context, authentication), // Pass authentication here
        ),
        _buildDivider(),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            'Doctor Connect v1.0.0',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 12,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    ).animate().fadeIn(duration: 500.ms).moveY(begin: 50, end: 0),
  );
}

Widget _buildMenuItem({
  required IconData icon,
  required String title,
  required VoidCallback onTap,
  Color? textColor,
}) {
  return ListTile(
    leading: Icon(
      icon,
      color: textColor ?? Color(0xFF4A78FF),
    ),
    title: Text(
      title,
      style: TextStyle(
        color: textColor ?? Colors.black87,
        fontWeight: FontWeight.w500,
      ),
    ),
    trailing: Icon(
      Icons.chevron_right,
      color: Colors.grey,
    ),
    onTap: onTap,
  );
}

Widget _buildDivider() {
  return Divider(
    height: 1,
    color: Colors.grey.shade200, 
    indent: 16,
    endIndent: 16,
  );
}

void _showLogoutDialog(BuildContext context, Authentication authentication) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      title: Text(
        'Logout',
        style: TextStyle(color: Color(0xFF4A78FF)),
      ),
      content: Text(
        'Are you sure you want to logout from Doctor Connect?',
      ),
      actions: [
        TextButton(
          onPressed: () => Get.back(),
          child: Text(
            'Cancel',
            style: TextStyle(color: Color(0xFF4A78FF)),
          ),
        ),
        TextButton(
          onPressed: () {
            authentication.googleSignOut();
            Get.offAll(() => LoginOrRegisterDoctor());
          },
          child: Text(
            'Confirm',
            style: TextStyle(color: Colors.red),
          ),
        ),
      ],
    ),
  );
}
