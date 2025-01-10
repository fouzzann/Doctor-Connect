import 'dart:developer';
import 'package:cc_dr_side/views/widgets/signin_or_login/create_account/create_account_contant.dart';
import 'package:cc_dr_side/views/widgets/signin_or_login/create_account/create_account_header.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cc_dr_side/model/dr_model.dart';
import 'package:cc_dr_side/services/authentication/authentication_service.dart';
import 'package:cc_dr_side/views/screens/is_accepted_by_the_admin/is_accepted_by_the_admin.dart';
import 'package:cc_dr_side/views/utils/costum_widgets/costum_alert.dart';

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
      log("Doctor data: \${widget.doctor.toString()}");
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
            contact: widget.doctor.contact,
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
            const CreateAccountHeader(),
            Expanded(
              child: CreateAccountContent(
                isLoading: isLoading,
                onGoogleSignIn: _handleGoogleSignIn,
              ),
            ),
          ],
        ),
      ),
    );
  }
}