// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

//選択された日付を取得する
final selectedDateProvider = StateNotifierProvider<SelectedDateState, DateTime>(
  (ref) => SelectedDateState(),
);

class SelectedDateState extends StateNotifier<DateTime> {
  SelectedDateState() : super(DateTime.now());

  Future<DateTime> updateDate(DateTime newDate) async {
    return state = newDate;
  }
}

//カレンダーが表示している年月を取得する
final showingDateTimeProvider =
    StateNotifierProvider.autoDispose<ShowingDateTimeState, DateTime>(
  (ref) => ShowingDateTimeState(),
);

class ShowingDateTimeState extends StateNotifier<DateTime> {
  ShowingDateTimeState() : super(DateTime.now());

  Future<void> updateDate(DateTime newDate) async {
    state = newDate;
  }

  void toNextMonth() {
    state = DateTime(state.year, state.month + 1);
  }

  void toPreviousMonth() {
    state = DateTime(state.year, state.month - 1);
  }
}
