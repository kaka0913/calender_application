// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomCupertinoDateTimePicker extends StatelessWidget {
  const CustomCupertinoDateTimePicker({
    required this.onDateTimeChanged,
    required this.initialDateTime,
    this.minimumDateTime,
    super.key,
  });
  final ValueChanged<DateTime> onDateTimeChanged;
  final DateTime initialDateTime;
  final DateTime? minimumDateTime;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 260,
      color: Colors.white,
      child: Column(
        children: [
          SizedBox(
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                CupertinoButton(
                  child: const Text(
                    'キャンセル',
                    style: TextStyle(color: Colors.cyan),
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                CupertinoButton(
                  child: const Text(
                    '完了',
                    style: TextStyle(color: Colors.cyan),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
          SizedBox(
            height: 200,
            child: CupertinoDatePicker(
              use24hFormat: true,
              minuteInterval: 15,
              initialDateTime: minimumDateTime != null &&
              initialDateTime.isBefore(minimumDateTime!)
                  ? minimumDateTime
                  : initialDateTime,
              onDateTimeChanged: onDateTimeChanged,
              minimumDate: minimumDateTime,
            ),
          ),
        ],
      ),
    );
  }
}
