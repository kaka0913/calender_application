import 'package:calender_application/common/sckedule_tile.dart';
import 'package:calender_application/repository/drift_repository.dart';
import 'package:flutter/material.dart';

class ScheduleDialog extends StatelessWidget {
  const ScheduleDialog({
    required this.schedule,
    Key? key}) : super(key: key);

    final Schedule schedule;

  @override
  Widget build(BuildContext context) {
    final id = 1;
    final title = 'テストタイトルたいとるたいとる';
    final day = DateTime.now();
    final startTime = DateTime.now();
    final endTime = DateTime.now().add(Duration(hours: 1));
    final isAllDay = false;

    final schedule = Schedule(
      id: id,
      title: title,
      day: day,
      startTime: startTime,
      endTime: endTime,
      isAllDay: isAllDay,
    );

    return Padding(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * 0.2,
      ),
      child: AlertDialog(
        title: Column(
          children: [
            Row(
              children: [
                Text(
                  '${day.year}/${day.month}/${day.day}',
                  style: const TextStyle(fontSize: 18),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 60),
                  child: ElevatedButton(
                    onPressed: () {
                      //フォームを表示
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
            )
          ],
        ),
        content: ScheduleTile(schedule: schedule),
      ),
    );
  }
}