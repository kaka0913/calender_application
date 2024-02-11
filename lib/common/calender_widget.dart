// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:calender_application/model/calender_model.dart';

class Calendar extends StatelessWidget {
  const Calendar({
    required this.date,
    super.key,
  });

  final DateTime date;

  @override
  Widget build(BuildContext context) {
    final calendarData = CalendarBuilder().build(date);

    return Column(
      children: [
        const _WeekRow(['月', '火', '水', '木', '金', '土', '日']),
        ...calendarData.map(
          (week) => _WeekRow(
            week.map((date) => date?.toString() ?? '').toList(),
          ),
        ),
      ],
    );
  }
}

class _WeekRow extends StatelessWidget {
  const _WeekRow(this.datesOfWeek);

  final List<String> datesOfWeek;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        datesOfWeek.length,
        (index) => Expanded(
          child: _DateBox(
            datesOfWeek[index],
            weekday: index + 1,
          ),
        ),
      ).toList(),
    );
  }
}

class _DateBox extends StatelessWidget {
  const _DateBox(
    this.label, {
    required this.weekday,
  });

  final String label;
  final int weekday;

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();
    final isToday = today.day == int.tryParse(label);

    return GestureDetector(
      onTap: () {
        // ボタンが押されたときの処理をここに書く
      },
      child: AspectRatio(
        aspectRatio: 1,
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
    );
  }
}
