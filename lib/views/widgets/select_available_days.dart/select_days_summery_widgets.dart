import 'package:flutter/material.dart';

class SelectedDaysSummaryWidget extends StatelessWidget {
  final Set<int> selectedDays;
  final List<String> weekDays;

  const SelectedDaysSummaryWidget({Key? key, required this.selectedDays, required this.weekDays}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> selected = selectedDays.map((n) => weekDays[n]).toList();
    return Column(
      children: selected.map((day) => Text(day)).toList(),
    );
  }
}

class NextButtonWidget extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onPressed;

  const NextButtonWidget({Key? key, required this.isLoading, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      child: isLoading ? CircularProgressIndicator() : Text("Next"),
    );
  }
}

class CustomAppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;

  CustomAppBarWidget({Key? key}) : preferredSize = Size.fromHeight(60.0), super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text('Select Available Days'),
      backgroundColor: Colors.blue,
    );
  }
}