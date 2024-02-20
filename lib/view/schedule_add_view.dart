// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_cupertino_date_picker_fork/flutter_cupertino_date_picker_fork.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

// Project imports:
import 'package:calender_application/repository/notifier/buttun_state_notifier.dart';

class ScheduleAddForm extends ConsumerStatefulWidget {
  const ScheduleAddForm({super.key});

  @override
  ScheduleFormState createState() => ScheduleFormState();
}

class ScheduleFormState extends ConsumerState<ScheduleAddForm> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  bool _allDay = false;
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now().add(const Duration(hours: 1));

  @override
  Widget build(BuildContext context) {
    final bottonState = ref.watch(buttonStateProvider);
    ref.watch(buttonStateProvider.notifier)
        .updateButtonState(_titleController, _contentController);

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
              onPressed: (bottonState == true)
                  ? () {
                      Navigator.pop(context);
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                shape: const RoundedRectangleBorder(),
              ),
              child: Text(
                '保存',
                style: TextStyle(
                  color: (bottonState == true) ? Colors.black : Colors.grey,
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
                        '開始                            ${_allDay 
                        ? DateFormat('        yyyy-MM-dd').format(startDate) 
                        : DateFormat('yyyy-MM-dd hh:mm').format(startDate)}',
                      ),
                      onTap: () {
                        //機能的には満たせているが、見た目が微妙
                        if (_allDay) {
                          //開始 終日の場合、年月日にみ選択
                          DatePicker.showDatePicker(
                            context,
                            minDateTime: DateTime.now()
                                .subtract(const Duration(days: 365)),
                            maxDateTime:
                                DateTime.now().add(const Duration(days: 365)),
                            initialDateTime: startDate,
                            locale: DateTimePickerLocale.jp,
                            pickerMode: DateTimePickerMode.datetime,
                            dateFormat: 'yyyy年  MM月  dd日 ',
                            onConfirm: (date, selectedIndex) {
                              setState(() {
                                startDate = date;
                              });
                            },
                          );
                        } else {
                          //開始 月日時分
                          DatePicker.showDatePicker(
                            context,
                            minDateTime: DateTime.now()
                                .subtract(const Duration(days: 365)),
                            maxDateTime:
                                DateTime.now().add(const Duration(days: 365)),
                            initialDateTime: startDate,
                            locale: DateTimePickerLocale.jp,
                            pickerMode: DateTimePickerMode.datetime,
                            dateFormat: 'MM月  dd日 HH:mm',
                            minuteDivider: 15, // 15分刻みに設定
                            onConfirm: (date, selectedIndex) {
                              setState(() {
                                startDate = date;
                              });
                            },
                          );
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
                        '終了                            ${_allDay ? DateFormat('        yyyy-MM-dd').format(endDate) : DateFormat('yyyy-MM-dd hh:mm').format(endDate)}',
                      ),
                      onTap: () {
                        //機能的には満たせているが、見た目が微妙
                        if (_allDay) {
                          //終了 終日の場合、年月日にみ選択
                          DatePicker.showDatePicker(
                            context,
                            minDateTime: DateTime.now()
                                .subtract(const Duration(days: 365)),
                            maxDateTime:
                                DateTime.now().add(const Duration(days: 365)),
                            initialDateTime: endDate,
                            locale: DateTimePickerLocale.jp,
                            pickerMode: DateTimePickerMode.datetime,
                            dateFormat: 'yyyy年  MM月  dd日 ',
                            onConfirm: (date, selectedIndex) {
                              setState(() {
                                endDate = date;
                              });
                            },
                          );
                        } else {
                          //終了 月日時分
                          DatePicker.showDatePicker(
                            context,
                            minDateTime: DateTime.now()
                                .subtract(const Duration(days: 365)),
                            maxDateTime:
                                DateTime.now().add(const Duration(days: 365)),
                            initialDateTime: endDate,
                            locale: DateTimePickerLocale.jp,
                            pickerMode: DateTimePickerMode.datetime,
                            dateFormat: 'MM月dd日 HH:mm',
                            minuteDivider: 15, // 15分刻みに設定
                            onConfirm: (date, selectedIndex) {
                              setState(() {
                                endDate = date;
                              });
                            },
                          );
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
