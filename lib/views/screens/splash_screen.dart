import 'dart:developer';
import 'package:cc_dr_side/services/authentication/dr_service.dart';
import 'package:cc_dr_side/views/screens/home_page.dart';
import 'package:cc_dr_side/views/screens/is_accepted_by_the_admin/is_accepted_by_the_admin.dart';
import 'package:cc_dr_side/views/screens/login_or_register_doctor.dart';
import 'package:cc_dr_side/views/widgets/splash_screen.dart/loading_indicater.dart';
import 'package:cc_dr_side/views/widgets/splash_screen.dart/splash_logo.dart';
import 'package:cc_dr_side/views/widgets/splash_screen.dart/splash_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutBack,
      ),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.4, 1.0, curve: Curves.easeIn),
      ),
    );

    _controller.forward();

    Future.delayed(const Duration(seconds: 4), () async {
      if (_auth.currentUser != null) {
        final bool isAccepted = await DoctorService().CheckDrAccepted(_auth.currentUser!.email.toString());
        log(isAccepted.toString());
        if (isAccepted) {
          Get.offAll(() => HomePage());
        } else {
          Get.offAll(() => IsAcceptedByTheAdmin());
        }
      } else {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (ctx) => LoginOrRegisterDoctor()),
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF4A78FF), Color(0xFF4A78FF), Colors.white],
          ),
        ),
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SplashLogo(scaleAnimation: _scaleAnimation),
                const SizedBox(height: 40),
                SplashText(fadeAnimation: _fadeAnimation),
                const SizedBox(height: 50),
                LoadingIndicator(fadeAnimation: _fadeAnimation),
                const SizedBox(height: 20),
                Opacity(
                  opacity: _fadeAnimation.value,
                  child: const Text(
                    'Please wait...',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
