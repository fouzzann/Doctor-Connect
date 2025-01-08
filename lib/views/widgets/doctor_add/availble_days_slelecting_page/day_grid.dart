import 'package:cc_dr_side/views/widgets/doctor_add/availble_days_slelecting_page/select_item.dart';
import 'package:flutter/material.dart';

class DaysGrid extends StatelessWidget {
  final List<String> weekDays;
  final Set<int> selectedDays;
  final Function(int) onDaySelected;

  const DaysGrid({
    Key? key,
    required this.weekDays,
    required this.selectedDays,
    required this.onDaySelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 24),
      sliver: SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 1.4,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return DaySelectionItem(
              day: weekDays[index],
              isSelected: selectedDays.contains(index),
              onTap: () => onDaySelected(index),
            );
          },
          childCount: weekDays.length,
        ),
      ),
    );
  }
}
