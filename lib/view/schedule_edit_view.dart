// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_cupertino_date_picker_fork/flutter_cupertino_date_picker_fork.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

// Project imports:
import 'package:calender_application/repository/drift_repository.dart';
import 'package:calender_application/repository/provider/buttun_state_provider.dart';

class ScheduleEditForm extends ConsumerStatefulWidget {
  const ScheduleEditForm({required this.schedule, super.key});
  final Schedule schedule;

  @override
  ScheduleFormState createState() => ScheduleFormState();
}

class ScheduleFormState extends ConsumerState<ScheduleEditForm> {
  bool _allDay = false;
  late DateTime startDate;
  late DateTime endDate;

  @override
  void initState() {
    super.initState();
    _allDay = widget.schedule.isAllDay;
    startDate = widget.schedule.startTime;
    endDate = widget.schedule.endTime;
  }

  @override
  Widget build(BuildContext context) {
    final database = ref.watch(driftDbProvider);
    final bottonState = ref.watch(buttonStateProvider);
    final bottonStateNotifier = ref.watch(buttonStateProvider.notifier)
      ..setdata(widget.schedule);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blue,
        title: Row(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.clear,
                color: Colors.white,
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 100, right: 40),
              child: Text(
                '予定の編集',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: (bottonState == true)
                  ? () async {
                      await database.updateSchedule(
                        Schedule(
                          id: widget.schedule.id,
                          title: bottonStateNotifier.titleController.text,
                          startTime: startDate,
                          endTime: endDate,
                          isAllDay: _allDay,
                          content: bottonStateNotifier.contentController.text,
                        ),
                      );
                      ref.invalidate(driftDbProvider);
                      if(mounted){
                        Navigator.pop(context);
                      }
                    }
                  : null,
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                  const Color.fromARGB(255, 216, 216, 216),
                ),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  const RoundedRectangleBorder(),
                ),
              ),
              child: Text(
                '保存',
                style: TextStyle(
                  color: (bottonState == true)
                      ? Colors.black
                      : const Color.fromARGB(255, 174, 167, 167),
                ),
              ),
            ),
          ],
        ),
      ),
      body: ColoredBox(
        color: const Color.fromARGB(255, 216, 216, 216),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    color: Colors.white,
                    child: GestureDetector(
                      onTap: () {
                        primaryFocus?.unfocus();
                      },
                      child: Theme(
                        data: Theme.of(context).copyWith(
                          hintColor: const Color.fromARGB(255, 227, 227, 227),
                        ),
                        child: TextField(
                          controller: bottonStateNotifier.titleController,
                          decoration: const InputDecoration(
                            hintText: 'タイトルを入力してください',
                            labelStyle: TextStyle(
                              color: Color.fromARGB(255, 237, 235, 235),
                            ),
                            border: InputBorder.none,
                          ),
                          onChanged: (text) {
                            if (widget.schedule.title != text || text.isEmpty) {
                              bottonStateNotifier.updateState();
                            }
                          },
                          onSubmitted: (text) {
                            bottonStateNotifier.titleController.text = text;
                            if (widget.schedule.title != text || text.isEmpty) {
                               bottonStateNotifier.updateState();
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: ColoredBox(
                    color: Colors.white,
                    child: SwitchListTile(
                      title: const Text('終日'),
                      value: _allDay,
                      onChanged: (bool value) {
                        bottonStateNotifier.updateState();
                        setState(() {
                          _allDay = value;
                        });
                      },
                      activeColor: Colors.blue,
                      inactiveThumbColor: Colors.white,
                      inactiveTrackColor: Colors.grey,
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
                        : DateFormat('yyyy-MM-dd HH:mm').format(startDate)}',
                      ),
                      onTap: () {
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
                            onChange: (_, __) =>
                              bottonStateNotifier.updateState(),
                            onConfirm: (date, _) {
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
                            onChange: (_, __) =>
                              bottonStateNotifier.updateState(),
                            onConfirm: (date, _) {
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
                        '終了                            ${_allDay 
                        ? DateFormat('        yyyy-MM-dd').format(endDate) 
                        : DateFormat('yyyy-MM-dd HH:mm').format(endDate)}',
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
                            onChange: (_, __) =>
                              bottonStateNotifier.updateState(),
                            onConfirm: (date, _) {
                              setState(() {
                                if (startDate.isAfter(date)) {
                                  endDate = startDate;
                                } else {
                                  endDate = date;
                                }
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
                            onChange: (_, __) =>
                              bottonStateNotifier.updateState(),
                            onConfirm: (date, _) {
                              setState(() {
                                if (date.isBefore(startDate)) {
                                  endDate =
                                      startDate.add(const Duration(hours: 1));
                                } else {
                                  endDate = date;
                                }
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
                    primaryFocus?.unfocus();
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 15, bottom: 10),
                    child: Container(
                      color: Colors.white,
                      padding: const EdgeInsets.only(
                        bottom: 80,
                        left: 10,
                        right: 10,
                      ),
                      child: GestureDetector(
                        onTap: () {
                          primaryFocus?.unfocus();
                        },
                        child: Theme(
                          data: Theme.of(context).copyWith(
                            hintColor: const Color.fromARGB(255, 237, 235, 235),
                          ),
                          child: TextField(
                            controller: bottonStateNotifier.contentController,
                            decoration: const InputDecoration(
                              hintText: 'コメントを入力してください',
                              border: InputBorder.none,
                              labelStyle: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                            maxLines: null,
                            onChanged: (text) {
                              if (widget.schedule.title != text 
                               || text.isEmpty){
                                bottonStateNotifier.updateState();
                              }
                            },
                            onSubmitted: (text) {
                              bottonStateNotifier.contentController.text = text;
                              if (widget.schedule.content != text 
                               || text.isEmpty) {
                                  bottonStateNotifier.updateState();
                              }
                            },
                            textInputAction: TextInputAction.done,
                          ),
                        ),
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
                        showCupertinoDialog<void>(
                          context: context,
                          builder: (BuildContext context) {
                            return CupertinoAlertDialog(
                              title: const Text(
                                '予定の削除',
                                style: TextStyle(color: Colors.black),
                              ),
                              content: const Text(
                                '本当にこの日の予定を削除しますか？',
                                style: TextStyle(color: Colors.black),
                              ),
                              actions: <Widget>[
                                CupertinoDialogAction(
                                  child: const Text(
                                    'キャンセル',
                                    style: TextStyle(color: Colors.blue),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                CupertinoDialogAction(
                                  child: const Text(
                                    '削除',
                                    style: TextStyle(color: Colors.blue),
                                  ),
                                  onPressed: () async {
                                    await database
                                        .deleteSchedule(widget.schedule.id);
                                    ref.invalidate(driftDbProvider);
                                    if (mounted) {
                                      Navigator.of(context).pop(); // ダイアログ
                                      Navigator.of(context).pop(); // 予定詳細画面
                                    }
                                  },
                                ),
                              ],
                            );
                          },
                        );
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
