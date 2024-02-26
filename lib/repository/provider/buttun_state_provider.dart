// Flutter imports:
import 'package:calender_application/repository/drift_repository.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

final buttonStateProvider =
    AutoDisposeStateNotifierProvider<ButtonState, bool>((ref) => ButtonState());

class ButtonState extends StateNotifier<bool> {
  ButtonState() : super(false);

  final titleController = TextEditingController();
  final contentController = TextEditingController();

  void updateState() {
    state =
        titleController.text.isNotEmpty && contentController.text.isNotEmpty;
  }

  void setdata(Schedule schedule){//スケジュール編集画面にてコントローラに初期値をセット
    titleController.text = schedule.title;
    contentController.text = schedule.content;
  }
}
