// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'package:calender_application/repository/drift_repository.dart';

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

  void setdata(Schedule schedule) {
    //スケジュール編集画面にてコントローラに初期値をセット
    titleController.text = schedule.title;
    contentController.text = schedule.content;
  }
}


final editingButtonStateProvider = AutoDisposeStateNotifierProvider.
  family<EditingButtonState, bool, Schedule>((ref, schedule) {
    return EditingButtonState(
      initialTitle: schedule.title,
      initialContent: schedule.content,
    );
});

class EditingButtonState extends StateNotifier<bool> {

  EditingButtonState({
    required String initialTitle, 
    required String initialContent,
    }
    ) : 
    titleController = TextEditingController(text: initialTitle),
    contentController = TextEditingController(text: initialContent),
    super(false);

  final TextEditingController titleController;
  final TextEditingController contentController;

  void updateState() {
    state = titleController.text.isNotEmpty && contentController.text.isNotEmpty;
  }
}
