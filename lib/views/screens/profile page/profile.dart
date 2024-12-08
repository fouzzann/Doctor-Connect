import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'package:cc_dr_side/controllers/doctore_controller.dart';
import 'package:cc_dr_side/services/authentication/authentication_service.dart';
import 'package:cc_dr_side/views/screens/login_or_register_doctor.dart';
import 'package:cc_dr_side/views/screens/profile%20page/privecy_and_policy.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  final DoctorController doctorController = Get.put(DoctorController());
  final Authentication authentication = Authentication();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          _buildAppBar(),
          SliverToBoxAdapter(
            child: Column(
              children: [
                _buildProfileHeader(context),
                const SizedBox(height: 20),
                _buildProfileActions(),
                const SizedBox(height: 20),
                _buildProfileMenuSection(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  SliverAppBar _buildAppBar() {
    return SliverAppBar(
      expandedHeight: 100,
      floating: false,
      pinned: true,
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: false,
      title: Text(
        'Profile',
        style: TextStyle(
          color: Colors.black87,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.settings, color: Colors.black54),
          onPressed: () {
       
          },
        ),
      ],
    );
  }

  Widget _buildProfileHeader(BuildContext context) {
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
                // TODO: Implement profile editing
              },
            ),
          ],
        ),
      ).animate().fadeIn(duration: 500.ms).moveY(begin: 50, end: 0),
    );
  }

  Widget _buildProfileActions() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildActionButton(
            icon: Icons.calendar_today,
            label: 'Appointments',
            onTap: () {
              // TODO: Navigate to appointments
            },
          ),
          _buildActionButton(
            icon: Icons.medical_services,
            label: 'Services',
            onTap: () {
              // TODO: Navigate to services
            },
          ),
          _buildActionButton(
            icon: Icons.settings,
            label: 'Settings',
            onTap: () {
              // TODO: Navigate to settings
            },
          ),
        ],
      ).animate().fadeIn(duration: 500.ms).moveY(begin: 50, end: 0),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, color: Color(0xFF4A78FF), size: 28),
            SizedBox(height: 5),
            Text(
              label,
              style: TextStyle(
                color: Colors.black54,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileMenuSection(BuildContext context) {
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
              // TODO: Navigate to account details
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
            onTap: () => _showLogoutDialog(context),
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

  void _showLogoutDialog(BuildContext context) {
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
}