// Flutter imports:
import 'package:calender_application/common/calender_date_box.dart';
import 'package:calender_application/common/schedule_dialog.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'package:calender_application/repository/drift_repository.dart';

class WeekRow extends ConsumerWidget {
  const WeekRow(
    this.datesOfWeek, {
    required this.selectedDate,
    required this.onDateSelected,
    super.key,
  });

  final List<String> datesOfWeek;
  final DateTime? selectedDate;
  final ValueChanged<DateTime?> onDateSelected;

  String getWeekday(DateTime date) {
    final weekdays = <String>['月', '火', '水', '木', '金', '土', '日'];
    return weekdays[date.weekday];
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //テストデータ

    final id = 1;
    final title = 'テストタイトルたいとるたいとる';
    final day = DateTime.now();
    final startTime = DateTime.now();
    final endTime = DateTime.now().add(Duration(hours: 1));
    final isAllDay = false;

    final scheduleExample = Schedule(
      id: id,
      title: title,
      day: day,
      startTime: startTime,
      endTime: endTime,
      isAllDay: isAllDay,
    );

    //final repository = ref.watch(sckeduleDatabaseProvider);

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
                showDialog(
    context: context,
    builder: (BuildContext context) {
      return ScheduleDialog(schedule: scheduleExample);
    },
  );
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
