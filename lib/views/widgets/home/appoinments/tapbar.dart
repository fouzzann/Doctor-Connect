import 'package:cc_dr_side/views/screens/completed_appointmets_screen.dart';
import 'package:cc_dr_side/views/screens/upcoming_screens.dart';
import 'package:flutter/material.dart';

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

Widget buildTabContent(int selectedIndex) {
  switch (selectedIndex) {
    case 0:
      return UpcomingScreens();
    case 1:
      return CompletedAppointment(); 
    default:
      return const Center(child: Text('Select a tab'));
  }
}
