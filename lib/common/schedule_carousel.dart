// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'package:calender_application/common/sckedule_tile.dart';
import 'package:calender_application/repository/drift_repository.dart';
import 'package:calender_application/view/schedule_add_view.dart';

class ScheduleCarousel extends ConsumerWidget {
  const ScheduleCarousel({
    required this.selectedDate,
    super.key,
  });

  final DateTime selectedDate;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repository = ref.watch(driftDbProvider);

    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * 0.03,
        left: MediaQuery.of(context).size.width * 0.03,
        right: MediaQuery.of(context).size.width * 0.03,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                '${selectedDate.year}/${selectedDate.month}/${selectedDate.day}',
                style: const TextStyle(fontSize: 18),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 140),
                child: ElevatedButton(
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
            future: repository.getSchedules(selectedDate),
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
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return ScheduleTile(schedule: snapshot.data![index]);
                  },
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
