// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

// Project imports:
import 'package:calender_application/common/calender_widget.dart';
import 'package:calender_application/view/calender_controller.dart';

class HomePage extends HookWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final setDate = useState<DateTime>(DateTime.now());

    Future<void> onNextTap() async {
      await DatePicker.showDatePicker(
        context,
        minTime: DateTime(2000),
        maxTime: DateTime(2100),
        onConfirm: (date) {
          setDate.value = DateTime(date.year, date.month);
        },
        currentTime: DateTime.now(),
        locale: LocaleType.jp,
      );
    }

    void toCurrentMonth() {
      setDate.value = DateTime.now();
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          'カレンダー',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SizedBox.expand(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              CalendarController(
                currentMonth: '${setDate.value.year}年 ${setDate.value.month}月',
                onNextTap: onNextTap,
                toCurrentMonth: toCurrentMonth,
              ),
              Expanded(
                child: PageView.builder(
                  itemCount: 100,
                  controller:
                      PageController(initialPage: setDate.value.month - 1),
                  onPageChanged: (value) {
                    setDate.value = DateTime(setDate.value.year, value + 1);
                  },
                  itemBuilder: (context, index) {
                    return Calendar(
                      date: DateTime(setDate.value.year, index + 1),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
