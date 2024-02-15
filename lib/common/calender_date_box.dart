import 'package:flutter/material.dart';

class DateBox extends StatelessWidget {
  const DateBox(
    this.label, {
    required this.weekday,
    required this.isSelected,
    required this.onDateSelected,
    super.key,
  });

  final String label;
  final int weekday;
  final bool isSelected;
  final VoidCallback onDateSelected;

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();
    final isToday = today.day == int.tryParse(label);
    final isWeekdayLabel = ['月', '火', '水', '木', '金', '土', '日'].contains(label);
    final isDate = int.tryParse(label) != null;

    return GestureDetector(
      onTap: onDateSelected,
      child: AspectRatio(
        aspectRatio: 1,
        child: Container(
          decoration: BoxDecoration(
            color: isSelected && isDate && !isWeekdayLabel
                ? const Color.fromARGB(255, 108, 179, 237)
                : Colors.transparent,
            shape: BoxShape.circle,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                label,
                style: TextStyle(
                  color: weekday == 6
                      ? Colors.blue
                      : weekday == 7
                          ? Colors.red
                          : Colors.black,
                ),
              ),
              if (isToday)
                Container(
                  width: 7,
                  height: 7,
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    shape: BoxShape.circle,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
