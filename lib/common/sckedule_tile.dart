// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:calender_application/repository/drift_repository.dart';
import 'package:calender_application/view/schedule_edit_view.dart';

class ScheduleTile extends StatelessWidget {
  const ScheduleTile({required this.schedule, super.key});

  final Schedule schedule;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute<Widget>(
            builder: (context) => ScheduleEditForm(schedule: schedule),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8),
        child: Column(
          children: [
            Row(
              children: <Widget>[
                if (schedule.isAllDay)
                  const Column(
                    children: [
                      Center(
                        child: Text(
                          '終日',
                          style: TextStyle(fontSize: 10),
                        ),
                      ),
                    ],
                  )
                else
                  Column(
                    children: [
                      Text(
                        '${schedule.startTime.hour.toString().padLeft(2,'0')}:${
                          schedule.startTime.minute.toString().padLeft(2,'0')}',
                        style: const TextStyle(fontSize: 10),
                      ),
                      Text(
                        '${schedule.endTime.hour.toString().padLeft(2, '0')}:${
                          schedule.endTime.minute.toString().padLeft(2, '0')}',
                        style: const TextStyle(fontSize: 10),
                      ),
                    ],
                  ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: Container(
                    width: 4,
                    height: 50,
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    'タイトル: ${schedule.title}',
                    style: const TextStyle(fontSize: 15),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ],
            ),
            const Divider(
              color: Color.fromARGB(255, 214, 206, 206),
              height: 20,
              thickness: 1,
              indent: 1,
              endIndent: 1,
            ),
          ],
        ),
      ),
    );
  }
}
