// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

// Project imports:
import 'package:calender_application/common/sckedule_tile.dart';
import 'package:calender_application/repository/drift_repository.dart';
import 'package:calender_application/repository/provider/page_change_provider.dart';
import 'package:calender_application/view/schedule_add_view.dart';

class CustomPageView extends StatelessWidget {
  const CustomPageView({
    required this.updatedDate,
    super.key,
  });

  final DateTime updatedDate;

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;

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
          final selectedDate = updatedDate.add(Duration(days: index - 50));
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
  }
}

class ScheduleCarousel extends HookConsumerWidget {
  const ScheduleCarousel({
    required this.selectedDate,
    super.key,
  });

  final DateTime selectedDate;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repository = ref.watch(driftDbProvider);
    initializeDateFormatting('ja_JP');
    final page = ref.watch(pageChangeProvider);
    var sckeduleList = repository.getSchedules(selectedDate);

    useEffect(
      () {
        sckeduleList = repository.getSchedules(selectedDate);
        return null;
      },
      [page],
    );

    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * 0.03,
        left: MediaQuery.of(context).size.width * 0.03,
        right: MediaQuery.of(context).size.width * 0.03,
        bottom: MediaQuery.of(context).size.height * 0.01,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Row(
                children: [
                  Text(
                    DateFormat('yyyy/MM/dd （', 'ja_JP').format(selectedDate),
                    style: const TextStyle(fontSize: 18),
                  ),
                  Text(
                    DateFormat('E', 'ja_JP').format(selectedDate),
                    style: TextStyle(
                      fontSize: 18,
                      color: selectedDate.weekday == DateTime.saturday
                          ? Colors.blue
                          : selectedDate.weekday == DateTime.sunday
                              ? Colors.red
                              : Colors.black,
                    ),
                  ),
                  const Text(
                    '）',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (context) =>
                          ScheduleAddForm(selectedDate: selectedDate),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.blue,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                ),
                child: const Icon(
                  Icons.add,
                ),
              ),
            ],
          ),
          const Divider(
            color: Color.fromARGB(255, 214, 206, 206),
            height: 10,
            thickness: 1,
            indent: 1,
            endIndent: 1,
          ),
          FutureBuilder<List<Schedule>>(
            future: sckeduleList,
            builder: (
              BuildContext context,
              AsyncSnapshot<List<Schedule>> snapshot,
            ) {
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (snapshot.data == null || snapshot.data!.isEmpty) {
                // データがnullまたは空の場合
                return const Expanded(
                  child: Center(
                    child: Text('予定がありません。'),
                  ),
                );
              } else {
                // データが存在する場合
                return Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return ScheduleTile(schedule: snapshot.data![index]);
                    },
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
