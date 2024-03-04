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
    final deviceWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        selectedDateNotifier.updateDate(date!).then((updatedDate) {
          showDialog<void>(
            context: context,
            builder: (BuildContext context) {
              return Container(
                margin: EdgeInsets.only(
                  top: deviceWidth * 0.43,
                  bottom: deviceWidth * 0.04,
                ),
                child: PageView.builder(
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
                        horizontal: 10,
                      ),
                      child: ScheduleCarousel(selectedDate: selectedDate),
                    );
                  },
                ),
              );
            },
          );
        });
      },
      child: AspectRatio(
        aspectRatio: 1,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: isToday ? Colors.blue : Colors.transparent,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  date!.day.toString(),
                  style: TextStyle(
                    color: today.day == date!.day &&
                            today.month == date!.month &&
                            today.year == date!.year
                        ? Colors.white
                        : showingMonth != date!.month
                            ? Colors.grey
                            : weekday == 6
                                ? Colors.blue
                                : weekday == 7
                                    ? Colors.red
                                    : Colors.black,
                  ),
                ),
              ),
            ),
            if (hasAppointment)
              Padding(
                padding: EdgeInsets.only(top: deviceWidth * 0.002),
                child: Container(
                  width: 7,
                  height: 7,
                  decoration: BoxDecoration(
                    color: showingMonth != date!.month
                        ? const Color.fromARGB(255, 167, 163, 163)
                        : Colors.black,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
