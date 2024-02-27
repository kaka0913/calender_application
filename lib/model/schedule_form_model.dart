// Package imports:
import 'package:freezed_annotation/freezed_annotation.dart';

part 'schedule_form_model.freezed.dart';

@freezed
class ScheduleForm with _$ScheduleForm {
  const factory ScheduleForm({
    required String title,
    required DateTime startTime,
    required DateTime endTime,
    required bool isAllDay,
    required String content,
  }) = _ScheduleForm;
}
