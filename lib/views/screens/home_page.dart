import 'package:cc_dr_side/views/screens/appointment_page.dart';
import 'package:cc_dr_side/views/screens/messages_page.dart';
import 'package:cc_dr_side/views/screens/profile%20page/profile.dart';
import 'package:cc_dr_side/views/utils/costum_widgets/bottom_navigation.dart';
import 'package:flutter/material.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
     AppointmentContent(), 
     MessagePage(), 
     ProfilePage(), 
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: _pages[_selectedIndex], 
      ),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
