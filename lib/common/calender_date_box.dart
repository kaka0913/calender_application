// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:calender_application/common/schedule_carousel.dart';
import 'package:calender_application/repository/drift_repository.dart';
import 'package:calender_application/repository/provider/page_change_provider.dart';
import 'package:calender_application/repository/provider/selected_day_provider.dart';

class DateBox extends HookConsumerWidget {
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
    final repository = ref.watch(driftDbProvider);
    var scheduleExistence = repository.hasAppointmentOnDate(date!);

    final deviceWidth = MediaQuery.of(context).size.width;
    final pageChange = ref.watch(pageChangeProvider);

    useEffect(
      () {
        scheduleExistence = repository.hasAppointmentOnDate(date!);
        return null;
      },
      [pageChange],
    );

    return GestureDetector(
      onTap: () {
        selectedDateNotifier.updateDate(date!).then((updatedDate) {
          showDialog<void>(
            context: context,
            builder: (BuildContext context) {
              return CustomPageView(
                updatedDate: updatedDate,
              );
            },
          );
        });
      },
      child: AspectRatio(
        aspectRatio: 1,
        child: SingleChildScrollView(
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
              FutureBuilder<bool>(
                future: scheduleExistence,
                builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                  if (snapshot.hasData && snapshot.data!) {
                    return Padding(
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
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
