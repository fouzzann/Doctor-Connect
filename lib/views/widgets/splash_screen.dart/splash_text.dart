import 'package:flutter/material.dart';

class SplashText extends StatelessWidget {
  final Animation<double> fadeAnimation;
  const SplashText({super.key, required this.fadeAnimation});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Opacity(
          opacity: fadeAnimation.value,
          child: const Text(
            'Doctor Connect',
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 1.5,
            ),
          ),
        ),
        const SizedBox(height: 15),
        Opacity(
          opacity: fadeAnimation.value,
          child: const Text(
            'Healthcare at Your Fingertips',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white70,
              letterSpacing: 0.5,
            ),
          ),
        ),
      ],
    );
  }
}
