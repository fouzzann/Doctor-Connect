import 'package:cc_dr_side/screens/dr_details_collect.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}
class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
     Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx)=> DrDetailsCollect()));
  
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/app_logo-removebg-preview.png')),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 480),
                child: Text(
                  'Doctor Connect',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w800,
                      color: const Color.fromARGB(255, 117, 117, 117)),
                ),
              ),
              SizedBox(
                height: 235,
              ),
              CircularProgressIndicator(
                color: const Color.fromARGB(255, 10, 134, 122),
              )
            ],
          ),
        ),
      ),
    );
  }
}
