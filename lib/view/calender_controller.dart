// Flutter imports:
import 'package:flutter/material.dart';

class CalendarController extends StatelessWidget {
  const CalendarController({
    required this.currentMonth,
    required this.toCurrentMonth,
    required this.onNextTap,
    super.key,
  });

  final String currentMonth;
  final VoidCallback toCurrentMonth;
  final VoidCallback onNextTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: toCurrentMonth,
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Colors.grey,
              ),
            ),
            child: const Text(
              '今日',
              style: TextStyle(
                fontSize: 15,
                color: Colors.black,
              ),
            ),
          ),
        ),
        const SizedBox(width: 60),
        Center(
          child: Text(
            currentMonth,
            style: const TextStyle(
              fontSize: 20,
            ),
          ),
        ),
        InkWell(
          onTap: onNextTap,
          child: const Padding(
            padding: EdgeInsets.all(8),
            child: Icon(Icons.arrow_drop_down),
          ),
        ),
      ],
    );
  }
}
