// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:calender_application/common/sckedule_tile.dart';
import 'package:calender_application/repository/drift_repository.dart';
import 'package:calender_application/view/schedule_add_view.dart';

class ScheduleCarousel extends StatelessWidget {
  const ScheduleCarousel({super.key,});

  @override
  Widget build(BuildContext context) {
    const id = 1053;
    const title = 'テストタイトルたいとるたいとる';
    final day = DateTime.now();
    final startTime = DateTime.now();
    final endTime = DateTime.now().add(const Duration(hours: 1));
    const isAllDay = false;

    final schedule = Schedule(
      id: id,
      title: title,
      startTime: startTime,
      endTime: endTime,
      isAllDay: isAllDay,
    );

    return Padding(
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
                '${day.year}/${day.month}/${day.day}',
                style: const TextStyle(fontSize: 18),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 140),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (context) => const ScheduleAddForm(),
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
          ScheduleTile(schedule: schedule),
        ],
      ),
    );
  }
}
