import 'package:cc_dr_side/screens/appointment_page.dart';
import 'package:cc_dr_side/screens/messages_page.dart';
import 'package:cc_dr_side/screens/profile.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  int _tabIndex = 0;

  //Bottom Navigation Bar
  final List<Widget> _pages = [
    AppointmentPage(),
    MessagePage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: _selectedIndex == 0 
            ? _buildAppointmentContent() 
            : _pages[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: const Color(0xFF4A78FF),
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Appointment',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'Messages',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  // Build the appointment page content with tabs
  Widget _buildAppointmentContent() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
               CircleAvatar(
                radius: 25,
                backgroundColor: Colors.blue,
                backgroundImage: AssetImage('assets/app logo.jpg 2.jpg'),
              ),
               SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Hey Dr',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    'Fariz',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 54),
        // Tab Bar
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildTab('Upcoming', 0),
              _buildTab('Completed', 1),
              _buildTab('Canceled', 2),
            ],
          ),
        ),
        const SizedBox(height: 20),
        // Patient List
        Expanded(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            children: [
              Text(
                _tabIndex == 0
                    ? 'Upcoming Appointments'
                    : _tabIndex == 1
                        ? 'Completed Appointments'
                        : 'Canceled Appointments',
                style: const TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTab(String text, int index) {
    bool isSelected = _tabIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _tabIndex = index),
      child: Column(
        children: [
          Text(
            text,
            style: TextStyle(
              color: isSelected ? Color(0xFF4A78FF) : Colors.grey,
              fontSize: 16,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            height: 3,
            width: 100,
            color: isSelected ?Color(0xFF4A78FF): Colors.transparent,
          ),
        ],
      ),
    );
  }
}
