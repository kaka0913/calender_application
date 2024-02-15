// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Package imports:
import 'package:intl/intl.dart';

final bottumStateProvider = StateProvider<bool>((ref) => false);

class ScheduleForm extends ConsumerStatefulWidget {
  const ScheduleForm({super.key});

  @override
  ScheduleFormState createState() => ScheduleFormState();
}

class ScheduleFormState extends ConsumerState<ScheduleForm> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  bool _allDay = false;
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    // final bottonState = ref.watch(bottumStateProvider);
    // final bottonStateNotifier = ref.read(bottumStateProvider.notifier);
    //ここreadであってるのかな

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blue,
        title: Row(
          children: [
            const Icon(
              Icons.clear,
              color: Colors.white,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 100, right: 40),
              child: Text(
                '予定の追加',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: (_titleController.text.isNotEmpty && 
                          _contentController.text.isNotEmpty) 
                ? () {
                    Navigator.pop(context);
                  } : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                shape: const RoundedRectangleBorder(),
              ),
              child: Text(
                '保存',
                style: TextStyle(
                  // color:  (bottonState == true) 
                  //   ? Colors.black 
                  //   : Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
      body: ColoredBox(
        color: Colors.grey,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                  },
                  child: ColoredBox(
                    color: Colors.white,
                    child: TextField(
                      controller: _titleController,
                      decoration: const InputDecoration(
                        hintText: 'タイトルを入力してください',
                        labelStyle: TextStyle(
                          color: Colors.grey,
                        ),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: ColoredBox(
                    color: Colors.white,
                    child: SwitchListTile(
                      title: const Text('終日'),
                      value: _allDay,
                      onChanged: (bool value) {
                        setState(() {
                          _allDay = value;
                        });
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 3),
                  child: ColoredBox(
                    color: Colors.white,
                    child: ListTile(
                      title: Text(
                          '開始                            ${DateFormat(
                            'yyyy-MM-dd HH:00',).format(_startDate)}'),
                      onTap: () async {
                        final date = await showDatePicker(
                          context: context,
                          initialDate: _startDate,
                          firstDate: DateTime.now(),
                          lastDate:
                              DateTime.now().add(const Duration(days: 365)),
                        );
                        final time = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.fromDateTime(_startDate),
                        );
                        if (date != null && time != null) {
                          setState(() {
                            _startDate = DateTime(
                              date.year,
                              date.month,
                              date.day,
                              time.hour,
                              time.minute,
                            );
                          });
                        }
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 3),
                  child: ColoredBox(
                    color: Colors.white,
                    child: ListTile(
                      title: Text(
                          '終了                            ${DateFormat(
                            'yyyy-MM-dd HH:00',).format(_endDate)}',),
                      onTap: () async {
                        final date = await showDatePicker(
                          context: context,
                          initialDate: _endDate,
                          firstDate: DateTime.now(),
                          lastDate:
                              DateTime.now().add(const Duration(days: 365)),
                        );
                        final time = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.fromDateTime(_endDate),
                        );
                        if (date != null && time != null) {
                          setState(() {
                            _endDate = DateTime(
                              date.year,
                              date.month,
                              date.day,
                              time.hour,
                              time.minute,
                            );
                          });
                        }
                      },
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: ColoredBox(
                      color: Colors.white,
                      child: TextField(
                        controller: _contentController,
                        decoration: const InputDecoration(
                          hintText: 'コメントを入力してください',
                          labelStyle: TextStyle(
                            color: Colors.grey,
                          ),
                          border: OutlineInputBorder(),
                        ),
                        maxLines: 5,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: const RoundedRectangleBorder(),
                        foregroundColor: Colors.red,
                        backgroundColor: Colors.white,
                      ),
                      onPressed: () {
                        // ここに削除処理を書く
                      },
                      child: const Text('この予定を削除'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
