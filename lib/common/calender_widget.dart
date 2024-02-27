// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:calender_application/common/calender_week_row.dart';
import 'package:calender_application/model/calender_model.dart';
import 'package:calender_application/repository/provider/selected_day_provider.dart';

class Calendar extends HookConsumerWidget {
  const Calendar({
    required this.date,
    super.key,
  });

  final DateTime date;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final calendarData = CalendarBuilder().build(date);
    final showingDateTime = ref.watch(showingDateTimeProvider);
    final weekdayString = ['月', '火', '水', '木', '金', '土', '日'];

    return Column(
      children: [
        Row(
          children: List.generate(
            7,
            (index) {
              return Expanded(
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        weekdayString[index],
                        style: TextStyle(
                          color: index == 5
                              ? Colors.blue
                              : index == 6
                                  ? Colors.red
                                  : Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ).toList(),
        ),
        ...calendarData.map(
          (week) {
            final isStartOfWeek = week.first == null;
            final isEndOfWeek = week.last == null;
            // weekの最初の部分にnullが何個あるかをカウント
            final nullCountStart = week.takeWhile((day) => day == null).length;
            // weekの最後の部分にnullが何個あるかをカウント
            final nullCountEnd =
                week.reversed.takeWhile((day) => day == null).length;

            return WeekRow(
              week
                  .asMap()
                  .map<int, DateTime>((index, day) {
                    DateTime date;
                    if (day != null) {
                      date = DateTime(
                        showingDateTime.year,
                        showingDateTime.month,
                        day,
                      );
                    } else {
                      if (isStartOfWeek && index < nullCountStart) {
                        final previousMonth = showingDateTime.month - 1;
                        final previousMonthYear = previousMonth == 12
                            ? showingDateTime.year - 1
                            : showingDateTime.year;
                        final previousMonthDays =
                            DateTime(previousMonthYear, previousMonth + 1, 0)
                                .day;
                        date = DateTime(
                          previousMonthYear,
                          previousMonth,
                          previousMonthDays - nullCountStart + index + 1,
                        );
                      } else if (isEndOfWeek && index >= 7 - nullCountEnd) {
                        final nextMonth = showingDateTime.month + 1;
                        date = DateTime(
                          showingDateTime.year,
                          nextMonth,
                          index + 1 - (7 - nullCountEnd),
                        );
                      } else {
                        date = DateTime.now();
                      }
                    }
                    return MapEntry(index, date);
                  })
                  .values
                  .toList(),
            );
          },
        ),
      ],
    );
  }
}
