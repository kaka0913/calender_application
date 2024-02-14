// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_hooks/flutter_hooks.dart';

// Project imports:
import 'package:calender_application/common/calender_week_row.dart';
import 'package:calender_application/model/calender_model.dart';

class Calendar extends HookWidget {
  const Calendar({
    required this.date,
    super.key,
  });

  final DateTime date;

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();
    final selectedDate = useState<DateTime?>(today);
    final calendarData = CalendarBuilder().build(date);

    return Column(
      children: [
        WeekRow(
          const ['月', '火', '水', '木', '金', '土', '日'],
          selectedDate: null,
          onDateSelected: (date) => selectedDate.value = date,
        ),
        ...calendarData.map(
          (week) => WeekRow(
            week.map((date) => date?.toString() ?? '').toList(),
            selectedDate: selectedDate.value,
            onDateSelected: (date) => selectedDate.value = date,
          ),
        ),
      ],
    );
  }
}
