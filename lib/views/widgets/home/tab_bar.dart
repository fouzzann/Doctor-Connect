import 'package:flutter/material.dart';

class TabBarWidget extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTabTapped;

  const TabBarWidget({
    required this.selectedIndex,
    required this.onTabTapped,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildTab('Upcoming', 0),
          _buildTab('Completed', 1),
          _buildTab('Canceled', 2),
        ],
      ),
    );
  }

  Widget _buildTab(String text, int index) {
    bool isSelected = selectedIndex == index;
    return GestureDetector(
      onTap: () => onTabTapped(index),
      child: Column(
        children: [
          Text(
            text,
            style: TextStyle(
              color: isSelected ? const Color(0xFF4A78FF) : Colors.grey,
              fontSize: 16,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            height: 3,
            width: 100,
            color: isSelected ? const Color(0xFF4A78FF) : Colors.transparent,
          ),
        ],
      ),
    );
  }
}
