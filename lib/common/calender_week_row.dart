// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'package:calender_application/common/calender_date_box.dart';

class WeekRow extends ConsumerWidget {
  const WeekRow(
    this.date, {
    super.key,
  });

  final List<DateTime>? date;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: List.generate(
        date!.length,
        (index) {
          return Expanded(
            child: DateBox(
              weekday: index + 1,
              date: date!.isEmpty ? null : date?[index],
              isSevenDays: date!.isEmpty,
            ),
          );
        },
      ).toList(),
    );
  }
}
