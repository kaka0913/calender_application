// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

final buttonStateProvider =
    StateNotifierProvider<ButtonState, bool>((ref) => ButtonState());

class ButtonState extends StateNotifier<bool> {
  ButtonState() : super(false);

  void updateButtonState(TextEditingController titleController,
      TextEditingController contentController,) {
    state =
        titleController.text.isNotEmpty && contentController.text.isNotEmpty;
  }
}
