// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

// Project imports:
import 'package:calender_application/common/action_sheet.dart';
import 'package:calender_application/common/date_picke.dart';
import 'package:calender_application/common/datetime_picker.dart';
import 'package:calender_application/repository/drift_repository.dart';
import 'package:calender_application/repository/provider/buttun_state_provider.dart';

class ScheduleEditForm extends ConsumerStatefulWidget {
  const ScheduleEditForm({required this.schedule, super.key});
  final Schedule schedule;

  @override
  ScheduleFormState createState() => ScheduleFormState();
}

class ScheduleFormState extends ConsumerState<ScheduleEditForm> {
  bool allDay = false;
  late DateTime startDate;
  late DateTime endDate;
  final focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    allDay = widget.schedule.isAllDay;
    startDate = widget.schedule.startTime;
    endDate = widget.schedule.endTime;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(focusNode);
    });
  }

  @override
  Widget build(BuildContext context) {
    final database = ref.watch(driftDbProvider);
    final bottonState = ref.watch(editingButtonStateProvider(widget.schedule));
    final bottonStateNotifier =
        ref.watch(editingButtonStateProvider(widget.schedule).notifier);
    final deviceWidth = MediaQuery.of(context).size.width;
    const themeColor = Color.fromARGB(255, 216, 216, 216);

    return Scaffold(
      backgroundColor: themeColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blue,
        title: GestureDetector(
          onTap: (){
             primaryFocus?.unfocus();
          },
          child: Stack(
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      if (bottonState) {
                        //変更されている場合を示すことができるので流用
                        showCupertinoModalPopup<void>(
                          context: context,
                          builder: (BuildContext context) =>
                              const CustomCupertinoActionSheet(),
                        );
                      } else {
                        Navigator.pop(context);
                      }
                    },
                    child: const Icon(
                      Icons.clear,
                      color: Colors.white,
                    ),
                  ),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: (bottonState == true)
                        ? () async {
                            await database.updateSchedule(
                              Schedule(
                                id: widget.schedule.id,
                                title: bottonStateNotifier.titleController.text,
                                startTime: startDate,
                                endTime: endDate,
                                isAllDay: allDay,
                                content:
                                    bottonStateNotifier.contentController.text,
                              ),
                            );
                            ref.invalidate(driftDbProvider);
                            if (mounted) {
                              Navigator.pop(context);
                            }
                          }
                        : null,
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        themeColor,
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
              Padding(
                padding: EdgeInsets.only(top: deviceWidth * 0.03),
                child: const Center(
                  child: Text(
                    '予定の編集',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: GestureDetector(
        onTap: () {
          primaryFocus?.unfocus();
        },
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
                    child: Theme(
                      data: Theme.of(context).copyWith(
                        hintColor: themeColor,
                      ),
                      child: TextFormField(
                        focusNode: focusNode,
                        controller: bottonStateNotifier.titleController,
                        decoration: const InputDecoration(
                          hintText: 'タイトルを入力してください',
                          border: InputBorder.none,
                        ),
                        onChanged: (text) {
                          if (widget.schedule.title != text || text.isEmpty) {
                            bottonStateNotifier.updateState();
                          }
                        },
                        onFieldSubmitted: (text) {
                          bottonStateNotifier.titleController.text = text;
                          if (widget.schedule.title != text || text.isEmpty) {
                            bottonStateNotifier.updateState();
                          }
                        },
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
                      value: allDay,
                      onChanged: (bool value) {
                        primaryFocus?.unfocus();
                        bottonStateNotifier.updateState();
                        setState(() {
                          allDay = value;
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
                      title: Row(
                        children: <Widget>[
                          const Text('開始'),
                          const Spacer(),
                          Text(
                            allDay
                                ? DateFormat('yyyy-MM-dd').format(startDate)
                                : DateFormat('yyyy-MM-dd HH:mm')
                                    .format(startDate),
                          ),
                        ],
                      ),
                      onTap: () {
                        primaryFocus?.unfocus();
                        if (allDay) {
                          //開始 終日の場合、年月日にみ選択
                          showCupertinoModalPopup<void>(
                            context: context,
                            builder: (_) => CustomCupertinoDatePicker(
                              onDateTimeChanged: (DateTime date) {
                                setState(() {
                                  startDate = date;
                                  if (endDate.isBefore(date)) {
                                    endDate = 
                                      date.add(const Duration(hours: 1));
                                  }
                                });
                              },
                            ),
                          );
                        } else {
                          //開始 月日時分
                          showCupertinoModalPopup<void>(
                            context: context,
                            builder: (_) => CustomCupertinoDateTimePicker(
                              initialDateTime: startDate,
                              onDateTimeChanged: (DateTime date) {
                                bottonStateNotifier.updateState();
                                setState(() {
                                  startDate = date;
                                  if (endDate.isBefore(date) ||
                                      endDate.isAtSameMomentAs(date)) {
                                    endDate = 
                                      date.add(const Duration(hours: 1));
                                  }
                                });
                              },
                            ),
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
                      title: Row(
                        children: <Widget>[
                          const Text('終了'),
                          const Spacer(),
                          Text(
                            allDay
                                ? DateFormat('yyyy-MM-dd')
                                .format(endDate)
                                : DateFormat('yyyy-MM-dd HH:mm')
                                .format(endDate),
                          ),
                        ],
                      ),
                      onTap: () {
                        primaryFocus?.unfocus();
                        if (allDay) {
                          //終了 終日の場合、年月日にみ選択
                          showCupertinoModalPopup<void>(
                            context: context,
                            builder: (_) => CustomCupertinoDatePicker(
                              onDateTimeChanged: (DateTime date) {
                                bottonStateNotifier.updateState();
                                setState(() {
                                  if (startDate.isAfter(date)) {
                                    endDate = startDate;
                                  } else {
                                    endDate = date;
                                  }
                                });
                              },
                            ),
                          );
                        } else {
                          //終了 月日時分
                          showCupertinoModalPopup<void>(
                            context: context,
                            builder: (_) => CustomCupertinoDateTimePicker(
                              minimumDateTime:
                                  startDate.add(const Duration(hours: 1)),
                              initialDateTime: endDate,
                              onDateTimeChanged: (DateTime date) {
                                bottonStateNotifier.updateState();
                                setState(() {
                                  if (date.isBefore(startDate)) {
                                    endDate =
                                        startDate.add(const Duration(hours: 1));
                                  } else {
                                    endDate = date;
                                  }
                                });
                              },
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15, bottom: 10),
                  child: Container(
                    color: Colors.white,
                    padding: const EdgeInsets.only(
                      bottom: 80,
                      left: 10,
                      right: 10,
                    ),
                    child: Theme(
                      data: Theme.of(context).copyWith(
                        hintColor: themeColor,
                      ),
                      child: TextFormField(
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
                          if (widget.schedule.title != text || text.isEmpty) {
                            bottonStateNotifier.updateState();
                          }
                        },
                        onFieldSubmitted: (text) {
                          bottonStateNotifier.contentController.text = text;
                          if (widget.schedule.content != text ||
                              text.isEmpty) {
                            bottonStateNotifier.updateState();
                          }
                        },
                        textInputAction: TextInputAction.done,
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
