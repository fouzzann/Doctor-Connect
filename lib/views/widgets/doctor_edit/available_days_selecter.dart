import 'package:flutter/material.dart';

class AvailableDaysSelector extends StatelessWidget {
  final List<String> selectedDays;
  final Function(List<String>) onDaysChanged;
  final Color primaryColor;

  const AvailableDaysSelector({
    Key? key,
    required this.selectedDays,
    required this.onDaysChanged,
    required this.primaryColor,
  }) : super(key: key);

  static const List<String> weekDays = [
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
    'Sun'
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Select Your Available Days',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: weekDays.map((day) {
            final isSelected = selectedDays.contains(day);
            return FilterChip(
              label: Text(
                day,
                style: TextStyle(
                  color: isSelected ? Colors.white : primaryColor,
                ),
              ),
              selected: isSelected,
              onSelected: (selected) {
                final newSelectedDays = List<String>.from(selectedDays);
                if (selected) {
                  newSelectedDays.add(day);
                } else {
                  newSelectedDays.remove(day);
                }
                onDaysChanged(newSelectedDays);
              },
              selectedColor: primaryColor,
              checkmarkColor: Colors.white,
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(color: primaryColor),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}