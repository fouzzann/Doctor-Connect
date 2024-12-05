import 'dart:developer';
import 'package:cc_dr_side/views/screens/is_accepted_by_the_admin.dart';
import 'package:cc_dr_side/views/utils/costum_widgets/costum_alert.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cc_dr_side/model/dr_model.dart';
import 'package:cc_dr_side/services/authentication/authentication_service.dart';

class CreateDrAccount extends StatefulWidget {
  const CreateDrAccount({
    super.key,
    required this.doctor,
    required this.certificateImage,
  });

  final Doctor doctor;
  final String certificateImage;

  @override
  State<CreateDrAccount> createState() => _CreateDrAccountState();
}

class _CreateDrAccountState extends State<CreateDrAccount> {
  final Authentication authentication = Authentication();
  bool isLoading = false;

  Future<void> _handleGoogleSignIn() async {
    setState(() => isLoading = true);

    try {
      log("Doctor data: ${widget.doctor.toString()}");
      final user = await authentication.loginWithGoogle();

      if (user != null) {
        final bool isDrExist = await authentication.checkDrExist(user.email!);
        log(isDrExist.toString());
        if (isDrExist) {
          showErrorDialog(context,
              message:
                  'You have already an account please try to login your existing account');
          await authentication.googleSignOut();
        } else {
          final fullDoctorData = Doctor(
            image: widget.doctor.image,
            fullName: widget.doctor.fullName,
            age: widget.doctor.age,
            email: user.email!,
            gender: widget.doctor.gender,
            uid: user.uid,
            category: widget.doctor.category,
            hospitalName: widget.doctor.hospitalName,
            location: widget.doctor.location,
            isAccepted: false,
            consultationFee: widget.doctor.consultationFee,
            yearsOfExperience: widget.doctor.yearsOfExperience,
            certificateImage: widget.certificateImage,
            availableDays: widget.doctor.availableDays,
          );

          await authentication.dataSubmition(fullDoctorData);

          Get.offAll(() => IsAcceptedByTheAdmin());
        }
      } else {
        log('User is null');
        showErrorDialog(context, message: 'Sign in failed. Please try again.');
      }
    } catch (e) {
      log('Login failed: $e');
      showErrorDialog(context, message: 'An error occurred during sign in.');
    } finally {
      setState(() => isLoading = false);
    }
  }

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
                      'Create Account',
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
                              'Almost There!',
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
                          if (isLoading)
                            const CircularProgressIndicator(
                              color: Color(0xFF4A78FF),
                            )
                          else
                            ElevatedButton(
                              onPressed: _handleGoogleSignIn,
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
