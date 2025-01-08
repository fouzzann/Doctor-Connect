import 'package:flutter/material.dart';

class DayGridWidget extends StatelessWidget {
  const DayGridWidget({
    Key? key,
    required this.weekDays,
    required this.selectedDays,
  }) : super(key: key);

  final List<String> weekDays;
  final Set<int> selectedDays;

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
            bool isSelected = selectedDays.contains(index);
            return GestureDetector(
              onTap: () {
                if (isSelected) {
                  selectedDays.remove(index);
                } else {
                  selectedDays.add(index);
                }
              },
              child: AnimatedContainer(
                duration: Duration(milliseconds: 700),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.blue.shade50 : Colors.grey[50],
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isSelected ? Color(0xFF4A78FF) : Colors.transparent,
                    width: 2,
                  ),
                ),
                child: Stack(
                  children: [
                    if (isSelected)
                      Positioned(
                        top: 8,
                        right: 8,
                        child: Container(
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Color(0xFF4A78FF),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(Icons.check, color: Colors.white, size: 12),
                        ),
                      ),
                    Center(
                      child: Text(
                        weekDays[index],
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                          color: isSelected ? Color(0xFF4A78FF) : Colors.black87,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          childCount: weekDays.length,
        ),
      ),
    );
  }
}
