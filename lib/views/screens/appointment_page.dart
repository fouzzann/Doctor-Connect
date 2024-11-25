import 'package:cc_dr_side/views/widgets/home/tab_bar.dart';
import 'package:flutter/material.dart';


class AppointmentContent extends StatefulWidget {
  const AppointmentContent({super.key});

  @override
  State<AppointmentContent> createState() => _AppointmentContentState();
}

class _AppointmentContentState extends State<AppointmentContent> {
  int _tabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              const CircleAvatar(
                radius: 25,
                backgroundColor: Colors.blue,
                backgroundImage: AssetImage('assets/app logo.jpg 2.jpg'),
              ),
              const SizedBox(width: 12),
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
        TabBarWidget(
          selectedIndex: _tabIndex,
          onTabTapped: (index) {
            setState(() {
              _tabIndex = index;
            });
          },
        ),
        const SizedBox(height: 20),
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
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
