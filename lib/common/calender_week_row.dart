// Flutter imports:
import 'package:calender_application/common/schedule_carousel.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'package:calender_application/common/calender_date_box.dart';

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
              showDialog<void>(
                context: context,
                builder: (BuildContext context) {
                  return PageView.builder(
                    controller: PageController(
                      viewportFraction: 0.9,
                      initialPage: 1, //初期表示ページ
                    ),
                    itemCount: 3,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.white,
                        ),
                        margin: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 100,
                        ),
                        child: const ScheduleCarousel(),
                      );
                    },
                  );
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
