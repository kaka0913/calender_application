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
import 'package:calender_application/model/schedule_form_model.dart';
import 'package:calender_application/repository/drift_repository.dart';
import 'package:calender_application/repository/provider/buttun_state_provider.dart';

class ScheduleAddForm extends ConsumerStatefulWidget {
  const ScheduleAddForm({required this.selectedDate, super.key});
  final DateTime selectedDate;

  @override
  ScheduleFormState createState() => ScheduleFormState();
}

class ScheduleFormState extends ConsumerState<ScheduleAddForm> {
  bool allDay = false;
  DateTime defaultTime = DateTime.now();
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
  final focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    defaultTime = DateTime.now();
    startDate = DateTime(
      widget.selectedDate.year,
      widget.selectedDate.month,
      widget.selectedDate.day,
      defaultTime.add(const Duration(hours: 1)).hour,
    );
    endDate = startDate.add(const Duration(hours: 1));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(focusNode);
    });
  }

  @override
  Widget build(BuildContext context) {
    final bottonState = ref.watch(buttonStateProvider);
    final bottonStateNotifier = ref.watch(buttonStateProvider.notifier);
    final database = ref.watch(driftDbProvider);
    final deviceWidth = MediaQuery.of(context).size.width;
    const themeColor = Color.fromARGB(255, 216, 216, 216);

    return Scaffold(
      backgroundColor: themeColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blue,
        title: GestureDetector(
          onTap: () {
            primaryFocus?.unfocus();
            bottonStateNotifier.updateState();
          },
          child: Stack(
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      if (bottonStateNotifier.titleController.text.isNotEmpty ||
                          bottonStateNotifier
                              .contentController.text.isNotEmpty) {
                        showCupertinoModalPopup<void>(
                          context: context,
                          builder: (BuildContext context) =>
                              const CustomCupertinoActionSheet(),
                        );
                        primaryFocus?.unfocus();
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
                            await database.addSchedule(
                              ScheduleForm(
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
                    '予定の追加',
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
          bottonStateNotifier.updateState();
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
                      child: TextField(
                        focusNode: focusNode,
                        controller: bottonStateNotifier.titleController,
                        decoration: const InputDecoration(
                          hintText: 'タイトルを入力してください',
                          border: InputBorder.none,
                        ),
                        onChanged: (text) {
                          if (text.isEmpty) {
                            bottonStateNotifier.updateState();
                          }
                        },
                        onSubmitted: (_) => bottonStateNotifier.updateState(),
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
                          //開始 終日の場合 年月日にみ選択
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
                                ? DateFormat('yyyy-MM-dd').format(endDate)
                                : DateFormat('yyyy-MM-dd HH:mm')
                                    .format(endDate),
                          ),
                        ],
                      ),
                      onTap: () {
                        primaryFocus?.unfocus();
                        if (allDay) {
                          //終了 終日の場合 年月日のみ選択
                          showCupertinoModalPopup<void>(
                            context: context,
                            builder: (_) => CustomCupertinoDatePicker(
                              onDateTimeChanged: (DateTime date) {
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
                          if (text.isEmpty) {
                            bottonStateNotifier.updateState();
                          }
                        },
                        onSubmitted: (_) => bottonStateNotifier.updateState(),
                        textInputAction: TextInputAction.done,
                      ),
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
