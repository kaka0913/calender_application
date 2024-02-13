// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_hooks/flutter_hooks.dart';

// Project imports:
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

class WeekRow extends StatelessWidget {
  const WeekRow(
    this.datesOfWeek, {
    required this.selectedDate,
    required this.onDateSelected,
    super.key,
  });

  final List<String> datesOfWeek;
  final DateTime? selectedDate;
  final ValueChanged<DateTime?> onDateSelected;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        datesOfWeek.length,
        (index) => Expanded(
          child: DateBox(
            datesOfWeek[index],
            weekday: index + 1,
            isSelected: selectedDate?.day == int.tryParse(datesOfWeek[index]),
            onDateSelected: () {
              final selectedDay = int.parse(datesOfWeek[index]);
              if (selectedDate?.day == selectedDay) {
                onDateSelected(null);
              } else {
                onDateSelected(
                  DateTime(
                    selectedDate?.year ?? 0,
                    selectedDate?.month ?? 0,
                    selectedDay,
                  ),
                );
              }
            },
          ),
        ),
      ).toList(),
    );
  }
}

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
