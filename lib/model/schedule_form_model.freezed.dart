// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'schedule_form_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ScheduleForm {
  String get title => throw _privateConstructorUsedError;
  DateTime get startTime => throw _privateConstructorUsedError;
  DateTime get endTime => throw _privateConstructorUsedError;
  bool get isAllDay => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ScheduleFormCopyWith<ScheduleForm> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ScheduleFormCopyWith<$Res> {
  factory $ScheduleFormCopyWith(
          ScheduleForm value, $Res Function(ScheduleForm) then) =
      _$ScheduleFormCopyWithImpl<$Res, ScheduleForm>;
  @useResult
  $Res call(
      {String title,
      DateTime startTime,
      DateTime endTime,
      bool isAllDay,
      String content});
}

/// @nodoc
class _$ScheduleFormCopyWithImpl<$Res, $Val extends ScheduleForm>
    implements $ScheduleFormCopyWith<$Res> {
  _$ScheduleFormCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? startTime = null,
    Object? endTime = null,
    Object? isAllDay = null,
    Object? content = null,
  }) {
    return _then(_value.copyWith(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      startTime: null == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endTime: null == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isAllDay: null == isAllDay
          ? _value.isAllDay
          : isAllDay // ignore: cast_nullable_to_non_nullable
              as bool,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ScheduleFormCopyWith<$Res>
    implements $ScheduleFormCopyWith<$Res> {
  factory _$$_ScheduleFormCopyWith(
          _$_ScheduleForm value, $Res Function(_$_ScheduleForm) then) =
      __$$_ScheduleFormCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String title,
      DateTime startTime,
      DateTime endTime,
      bool isAllDay,
      String content});
}

/// @nodoc
class __$$_ScheduleFormCopyWithImpl<$Res>
    extends _$ScheduleFormCopyWithImpl<$Res, _$_ScheduleForm>
    implements _$$_ScheduleFormCopyWith<$Res> {
  __$$_ScheduleFormCopyWithImpl(
      _$_ScheduleForm _value, $Res Function(_$_ScheduleForm) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? startTime = null,
    Object? endTime = null,
    Object? isAllDay = null,
    Object? content = null,
  }) {
    return _then(_$_ScheduleForm(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      startTime: null == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endTime: null == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isAllDay: null == isAllDay
          ? _value.isAllDay
          : isAllDay // ignore: cast_nullable_to_non_nullable
              as bool,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_ScheduleForm implements _ScheduleForm {
  const _$_ScheduleForm(
      {required this.title,
      required this.startTime,
      required this.endTime,
      required this.isAllDay,
      required this.content});

  @override
  final String title;
  @override
  final DateTime startTime;
  @override
  final DateTime endTime;
  @override
  final bool isAllDay;
  @override
  final String content;

  @override
  String toString() {
    return 'ScheduleForm(title: $title, startTime: $startTime, endTime: $endTime, isAllDay: $isAllDay, content: $content)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ScheduleForm &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.endTime, endTime) || other.endTime == endTime) &&
            (identical(other.isAllDay, isAllDay) ||
                other.isAllDay == isAllDay) &&
            (identical(other.content, content) || other.content == content));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, title, startTime, endTime, isAllDay, content);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ScheduleFormCopyWith<_$_ScheduleForm> get copyWith =>
      __$$_ScheduleFormCopyWithImpl<_$_ScheduleForm>(this, _$identity);
}

abstract class _ScheduleForm implements ScheduleForm {
  const factory _ScheduleForm(
      {required final String title,
      required final DateTime startTime,
      required final DateTime endTime,
      required final bool isAllDay,
      required final String content}) = _$_ScheduleForm;

  @override
  String get title;
  @override
  DateTime get startTime;
  @override
  DateTime get endTime;
  @override
  bool get isAllDay;
  @override
  String get content;
  @override
  @JsonKey(ignore: true)
  _$$_ScheduleFormCopyWith<_$_ScheduleForm> get copyWith =>
      throw _privateConstructorUsedError;
}
