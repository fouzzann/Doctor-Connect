import 'package:cc_dr_side/views/screens/login_or_register_doctor.dart';
import 'package:cc_dr_side/views/screens/profile%20page/privecy_and_policy.dart';
import 'package:cc_dr_side/services/authentication/authentication_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  final Authentication authentication = Authentication();
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      body: Column(
        children: [
          Container(
            height: 300,
            width: 3000,
            decoration: BoxDecoration(
              color: const Color(0xFF4A78FF),
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(100),
                bottomLeft: Radius.circular(100),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 90,
                  backgroundColor: Colors.white,
                  child: ClipOval(
                    child: Image.asset(
                      'assets/app logo.jpg 2.jpg',
                      fit: BoxFit.cover,
                      height: 190,
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                const Text(
                  'Donex fiance',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
             
              ],
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: [
                ListTile(
                  leading: const Icon(Icons.person, color: Color(0xFF4A78FF)),
                  title: const Text("Account"),
                  onTap: () {},
                ),
                ListTile(
                  leading: const Icon(Icons.shield, color: Color(0xFF4A78FF)),
                  title: const Text("Privacy and Policy"),
                  onTap: () {
                    Get.to(() => PrivacyPolicyPage());
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.padding_rounded,
                      color: Color(0xFF4A78FF)),
                  title: const Text("Terms and Conditions"),
                  onTap: () {},
                ),
                ListTile(
                  leading: const Icon(Icons.help, color: Color(0xFF4A78FF)),
                  title: const Text("Help & Support"),
                  onTap: () {},
                ),
                ListTile(
                  leading: const Icon(Icons.logout, color: Colors.red),
                  title: const Text(
                    "Logout",
                    style: TextStyle(color: Colors.red),
                  ),
                  onTap: () {
                    showDialog(
                      
                      context: context,
                      builder: (context) => AlertDialog(
                        backgroundColor: Colors.white,
                        title: Text(
                          'Logout',
                          style: TextStyle(
                            color: Color(0xFF4A78FF),
                          ),
                        ),
                        content: Text(
                            'Are you sure you want to Logout from Docter Connect'),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Get.back();
                              },
                              child: Text(
                                'Cancel',
                                style: TextStyle(
                                  color: Color(0xFF4A78FF),
                                ),
                              )),
                          TextButton(
                              onPressed: () {
                                authentication.googleSignOut();
                                Get.offAll(() => LoginOrRegisterDoctor());
                              },
                              child: Text(
                                'Confirm',
                                style: TextStyle(color: Colors.red),
                              ))
                        ],
                      ),
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 90),
                  child: Column(
                    children: [
                      Text(
                        'Version 1.0.0',
                        style: TextStyle(fontSize: 17, color: Colors.grey),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
