  import 'package:cc_dr_side/views/screens/upcoming_screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

Widget buildProfileActions() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildActionButton(
            icon: Icons.calendar_today,
            label: 'Appointments',
            onTap: () {
              Get.to(()=>UpcomingScreens(), 
              transition: Transition.rightToLeftWithFade);
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