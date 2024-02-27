// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'package:calender_application/common/schedule_carousel.dart';
import 'package:calender_application/repository/provider/has_sckedule_provider.dart';
import 'package:calender_application/repository/provider/selected_day_provider.dart';

class DateBox extends ConsumerWidget {
  const DateBox({
    required this.date,
    required this.weekday,
    required this.isSevenDays, //七曜表示の場合はtrue
    super.key,
  });

  final DateTime? date;
  final int weekday;
  final bool isSevenDays;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final today = DateTime.now();
    final selectedDateNotifier = ref.watch(selectedDateProvider.notifier);
    final showingMonth = ref.watch(showingDateTimeProvider).month;
    final isToday = date?.day == today.day &&
        date?.month == today.month &&
        date?.year == today.year;
    final scheduleExistence = ref.watch(scheduleExistenceProvider(date!));
    final hasAppointment = scheduleExistence.when(
      data: (exists) => exists,
      loading: () => false,
      error: (_, __) => false,
    );

    return GestureDetector(
      onTap: () {
        selectedDateNotifier.updateDate(date!).then((updatedDate) {
          showDialog<void>(
            context: context,
            builder: (BuildContext context) {
              return PageView.builder(
                controller: PageController(
                  viewportFraction: 0.9,
                  initialPage: 50,
                ),
                itemCount: 101,
                itemBuilder: (BuildContext context, int index) {
                  final selectedDate =
                      updatedDate.add(Duration(days: index - 50));
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white,
                    ),
                    margin: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 100,
                    ),
                    child: ScheduleCarousel(selectedDate: selectedDate),
                  );
                },
              );
            },
          );
        });
      },
      child: AspectRatio(
        aspectRatio: 1,
        child: Container(
          decoration: BoxDecoration(
            color: isToday
                ? const Color.fromARGB(255, 108, 179, 237)
                : Colors.transparent,
            shape: BoxShape.circle,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                date!.day.toString(),
                style: TextStyle(
                  color: showingMonth != date!.month
                      ? Colors.grey
                      : weekday == 6
                          ? Colors.blue
                          : weekday == 7
                              ? Colors.red
                              : Colors.black,
                ),
              ),
              if (hasAppointment)
                Container(
                  width: 7,
                  height: 7,
                  decoration: BoxDecoration(
                    color: showingMonth != date!.month
                      ?const Color.fromARGB(255, 167, 163, 163) : Colors.black,
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
