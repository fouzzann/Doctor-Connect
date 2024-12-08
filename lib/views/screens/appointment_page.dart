import 'package:cc_dr_side/controllers/doctore_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppointmentContent extends StatelessWidget {
  const AppointmentContent({super.key});

  @override
  Widget build(BuildContext context) {
    final DoctorController doctorController = Get.put(DoctorController());

    doctorController.fetchDoctorData();

    return Scaffold(
      body: Obx(() {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.blue,
                    backgroundImage: doctorController.doctorImage.isNotEmpty
                        ? NetworkImage(doctorController.doctorImage.value)
                        : const AssetImage('assets/default_avatar.jpg')
                            as ImageProvider,
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Hey Dr',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        doctorController.doctorName.value,
                        style: const TextStyle(
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
              selectedIndex: 0,
              onTabTapped: (index) {},
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                children: [
                  const Text(
                    'Upcoming Appointments',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}

class TabBarWidget extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTabTapped;

  const TabBarWidget({
    super.key,
    required this.selectedIndex,
    required this.onTabTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildTabItem(context, 0, "Upcoming"),
        _buildTabItem(context, 1, "Completed"),
        _buildTabItem(context, 2, "Canceled"),
      ],
    );
  }

  Widget _buildTabItem(BuildContext context, int index, String label) {
    final isSelected = index == selectedIndex;
    return GestureDetector(
      onTap: () => onTabTapped(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              color: isSelected ? Colors.blue : Colors.grey,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          if (isSelected)
            Container(
              margin: const EdgeInsets.only(top: 4),
              height: 2,
              width: 60,
              color: Colors.blue,
            ),
        ],
      ),
    );
  }
}
