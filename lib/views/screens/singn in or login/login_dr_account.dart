import 'dart:developer';
import 'package:cc_dr_side/services/authentication/dr_service.dart';
import 'package:cc_dr_side/views/screens/home_page.dart';
import 'package:cc_dr_side/services/authentication/authentication_service.dart';
import 'package:cc_dr_side/views/screens/is_accepted_by_the_admin.dart';
import 'package:cc_dr_side/views/utils/costum_widgets/costum_alert.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginDrAccount extends StatefulWidget {
  const LoginDrAccount({super.key});

  @override
  State<LoginDrAccount> createState() => _LoginDrAccountState();
}

class _LoginDrAccountState extends State<LoginDrAccount> {
  final Authentication authentication = Authentication();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF4A78FF),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Get.back(),
                    icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                  ),
                  const Expanded(
                    child: Text(
                      'Hey Doctor',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 40),
                ],
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  children: [
                    Expanded(
                      flex: 4,
                      child: Container(
                        padding: const EdgeInsets.all(32),
                        child: Image.asset(
                          'assets/Screenshot_2024-11-20_120720-removebg-preview.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Column(
                          children: [
                            Text(
                              'Welcome to DoctorConnect',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium
                                  ?.copyWith(
                                    color: const Color(0xFF4A78FF),
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Join our trusted network. Register your profile, manage appointments, and connect with patients.',
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                    color: Colors.grey[600],
                                    height: 1.5,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () async {
                              try {
                                final user =
                                    await authentication.loginWithGoogle();
                                if (user != null) {
                                  final bool isDrExist = await authentication
                                      .checkDrExist(user.email!);
                                  log(isDrExist.toString());
                                  if (isDrExist) {
                                    final bool isAccepted =
                                        await DoctorService()
                                            .CheckDrAccepted(user.email!);
                                    if (isAccepted) {
                                      Get.offAll(() => HomePage());
                                    } else {
                                      Get.offAll(() => IsAcceptedByTheAdmin());
                                    }
                                  } else {
                                    await FirebaseAuth.instance.signOut();
                                    await GoogleSignIn().signOut();
                                    showErrorDialog(context);
                                  }
                                }
                              } catch (e) {
                                showErrorDialog(context,
                                    message:
                                        'An error occurred. Please try again.');
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.black87,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 32, vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                                side: BorderSide(color: Colors.grey.shade300),
                              ),
                              elevation: 0,
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.asset(
                                  'assets/google.png',
                                  width: 24,
                                  height: 24,
                                ),
                                const SizedBox(width: 12),
                                const Text(
                                  'Continue with Google',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
