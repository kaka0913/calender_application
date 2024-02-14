import 'package:calender_application/repository/drift_repository.dart';
import 'package:flutter/material.dart';


class ScheduleDetail extends StatelessWidget {

  const ScheduleDetail({required this.schedule, super.key});

  final Schedule schedule;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Column(
          children: [
                Text(
  '${schedule.startTime.hour.toString().padLeft(2, '0')}:${schedule.startTime.minute.toString().padLeft(2, '0')}', 
  style: const TextStyle(fontSize: 10),
),
Text(
  '${schedule.endTime.hour.toString().padLeft(2, '0')}:${schedule.endTime.minute.toString().padLeft(2, '0')}', 
  style: const TextStyle(fontSize: 10),
)
          ],         
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8, right: 8),
          child: Container(
            width:5, // 線の幅を指定
            height: 30,
            decoration: const BoxDecoration(
              color: Colors.blue, // 線の色を指定
            ),
          ),
        ),
Expanded(
  child: Text(
    'タイトル: ${schedule.title}', 
    style: const TextStyle(fontSize: 15),
    overflow: TextOverflow.ellipsis, // テキストがはみ出た場合に3点リーダーを表示
    maxLines: 1, 
  ),
),
      ],
    );
  }
}
