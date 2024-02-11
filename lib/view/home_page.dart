// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

// Project imports:
import 'package:calender_application/common/calender_widget.dart';

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

    void toNextMonth() {
      setDate.value = DateTime(setDate.value.year, setDate.value.month + 1);
    }

    void toPreviousMonth() {
      setDate.value = DateTime(setDate.value.year, setDate.value.month - 1);
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
              Calendar(date: setDate.value),
            ],
          ),
        ),
      ),
    );
  }
}

class CalendarController extends StatelessWidget {
  const CalendarController({
    required this.currentMonth,
    required this.toCurrentMonth,
    required this.onNextTap,
    super.key,
  });

  final String currentMonth;
  final VoidCallback toCurrentMonth;
  final VoidCallback onNextTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: toCurrentMonth,
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
            currentMonth,
            style: const TextStyle(
              fontSize: 20,
            ),
          ),
        ),
        InkWell(
          onTap: onNextTap,
          child: const Padding(
            padding: EdgeInsets.all(8),
            child: Icon(Icons.arrow_drop_down),
          ),
        ),
      ],
    );
  }
}
