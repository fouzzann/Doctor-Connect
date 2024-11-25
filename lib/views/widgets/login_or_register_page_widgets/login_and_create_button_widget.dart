import 'package:cc_dr_side/views/screens/dr_details_collect.dart';
import 'package:cc_dr_side/views/screens/singn%20in%20or%20login/login_dr_account.dart';
import 'package:cc_dr_side/views/widgets/login_or_register_page_widgets/neumorphic_auth_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginAndCreateButtonWidget extends StatelessWidget {
  const LoginAndCreateButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        NeumorphicAuthButton(
            title: 'Login to Account',
            icon: Icons.login_rounded,
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF6C63FF), Color(0xFF584FE0)],
            ),
            onTap: () {
              Get.to(
                () => const LoginDrAccount(),
                transition: Transition.rightToLeftWithFade,
              );
            }),
        const SizedBox(height: 16),

        // Register Button
        NeumorphicAuthButton(
          title: 'Create Account',
          icon: Icons.person_add_rounded,
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF4CAF50), Color(0xFF388E3C)],
          ),
          onTap: () => Get.to(
            () => DrDetailsCollect(),
            transition: Transition.rightToLeftWithFade,
          ),
        ),
      ],
    );
  }
}
