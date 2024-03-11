// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PageChangeNotifier extends StateNotifier<bool> {
  PageChangeNotifier() : super(false);
  void notifyChange() {
    state = !state;
  }
}

final pageChangeProvider = StateNotifierProvider<PageChangeNotifier, bool>(
  (ref) => PageChangeNotifier(),
);
