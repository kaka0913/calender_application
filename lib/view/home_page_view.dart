// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:calender_application/common/calender_controller.dart';
import 'package:calender_application/common/calender_widget.dart';
import 'package:calender_application/repository/provider/selected_day_provider.dart';

final previousPageProvider = StateProvider<int>((ref) => 50);

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showingDateTime = ref.watch(showingDateTimeProvider);
    final dateTimeNotifier = ref.watch(showingDateTimeProvider.notifier);

    final controller = PageController(initialPage: 50);
    final previousPage = ref.watch(previousPageProvider);
    final pageNotifier = ref.watch(previousPageProvider.notifier);

    controller.addListener(() {
      if (controller.page!.round() > previousPage) {
        dateTimeNotifier.toNextMonth();
        pageNotifier.state++;
      } else if (controller.page!.round() < previousPage) {
        dateTimeNotifier.toPreviousMonth();
        pageNotifier.state--;
      }
    });

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Center(
          child: Text(
            'カレンダー',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
      ),
      body: SizedBox.expand(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const CalendarController(),
              Expanded(
                child: PageView.builder(
                  itemCount: 101,
                  controller: controller,
                  itemBuilder: (context, index) {
                    return Calendar(
                      date: DateTime(
                        showingDateTime.year,
                        showingDateTime.month,
                      ),
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
