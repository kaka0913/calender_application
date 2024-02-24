// Flutter imports:
import 'package:calender_application/repository/provider/selected_day_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
class CalendarController extends ConsumerWidget {
  const CalendarController(
    {
    super.key,
  });


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showingDateTime = ref.watch(showingDateTimeProvider);
    final showDateNotifier = ref.watch(showingDateTimeProvider.notifier);

    return Row(
      children: [
        InkWell(
          onTap: (){
            showDateNotifier.updateDate(DateTime.now());
          },
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Colors.grey,
              ),
            ),
            child: const Text(
              '今日',
              style: TextStyle(
                fontSize: 15,
                color: Colors.black,
              ),
            ),
          ),
        ),
        const SizedBox(width: 60),
        Center(
          child: Text(
            '${showingDateTime.year}年 ${
                    showingDateTime.month}月',
            style: const TextStyle(
              fontSize: 20,
            ),
          ),
        ),
        InkWell(
          onTap: () {
            DatePicker.showDatePicker(
              context,
              minTime: DateTime(2000),
              maxTime: DateTime(2100),
              onConfirm: (date) {
                showDateNotifier.updateDate(DateTime(date.year, date.month));
              },
              currentTime: DateTime.now(),
              locale: LocaleType.jp,
            );
          },
          child: const Padding(
            padding: EdgeInsets.all(8),
            child: Icon(Icons.arrow_drop_down),
          ),
        ),
      ],
    );
  }
}
