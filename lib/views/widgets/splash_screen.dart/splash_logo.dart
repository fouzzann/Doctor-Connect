import 'package:flutter/material.dart';

class SplashLogo extends StatelessWidget {
  final Animation<double> scaleAnimation;
  const SplashLogo({super.key, required this.scaleAnimation});

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: scaleAnimation.value,
      child: Container(
        width: 180,
        height: 180,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 20,
              spreadRadius: 5,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Image.asset(
          'assets/app_logo-removebg-preview.png',
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
