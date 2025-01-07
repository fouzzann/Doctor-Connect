import 'package:cc_dr_side/views/widgets/signin_or_login/login/login_content.dart';
import 'package:cc_dr_side/views/widgets/signin_or_login/login/login_header.dart';
import 'package:flutter/material.dart';
import 'package:cc_dr_side/services/authentication/authentication_service.dart';

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
            const LoginHeader(),
            Expanded(
              child: LoginContent(authentication: authentication),
            ),
          ],
        ),
      ),
    );
  }
}
