// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'package:calender_application/repository/provider/selected_day_provider.dart';

class CalendarController extends ConsumerWidget {
  const CalendarController({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showingDateTime = ref.watch(showingDateTimeProvider);
    final showDateNotifier = ref.watch(showingDateTimeProvider.notifier);
    final deviceWidth = MediaQuery.of(context).size.width;

    return ColoredBox(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.only(
          top: deviceWidth * 0.02,
          bottom: deviceWidth * 0.02,
        ),
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(left: deviceWidth * 0.02),
              child: Row(
                children: [
                  Center(
                    child: Material(
                      child: InkWell(
                        onTap: () {
                          showDateNotifier.updateDate(DateTime.now());
                        },
                        child: Container(
                          height: 35,
                          width: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: Colors.grey,
                            ),
                          ),
                          child: const Center(
                            child: Text(
                              '今日',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${showingDateTime.year}年${
                            showingDateTime.month.toString().padLeft(2, '0')}月',
                          style: const TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            DatePicker.showDatePicker(
                              context,
                              minTime: DateTime(2000),
                              maxTime: DateTime(2100),
                              onConfirm: (date) {
                                showDateNotifier.updateDate(
                                    DateTime(date.year, date.month, date.day),);
                              },
                              currentTime: showingDateTime,
                              locale: LocaleType.jp,
                            );
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(8),
                            child: Icon(Icons.arrow_drop_down),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
