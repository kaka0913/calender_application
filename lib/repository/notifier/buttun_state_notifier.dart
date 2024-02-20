// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

final buttonStateProvider =
    AutoDisposeStateNotifierProvider<ButtonState, bool>((ref) => ButtonState());

class ButtonState extends StateNotifier<bool> {
  ButtonState() : super(false);

  final titleController = TextEditingController();
  final contentController = TextEditingController();

  void updateState () {
    state = titleController.text.isNotEmpty 
      && contentController.text.isNotEmpty;
  }
}
