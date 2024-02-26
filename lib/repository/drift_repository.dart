// Dart imports:
import 'dart:io';

// Package imports:
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

// Project imports:
import 'package:calender_application/model/schedule_form_model.dart';

part 'drift_repository.g.dart';

final driftDbProvider = Provider<SckeduleDatabase>((ref) {
  final database = SckeduleDatabase();
  return database;
});

class Schedules extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  DateTimeColumn get startTime => dateTime()();
  DateTimeColumn get endTime => dateTime()();
  BoolColumn get isAllDay => boolean()();
  TextColumn get content => text()();
}

@DriftDatabase(tables: [Schedules])
class SckeduleDatabase extends _$SckeduleDatabase {
  SckeduleDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Future<List<Schedule>> getSchedules(DateTime time) {
    return (select(schedules)
          ..where(
            (s) =>
                s.startTime.year.equals(time.year) &
                s.startTime.month.equals(time.month) &
                s.startTime.day.equals(time.day),
          ))
        .get();
  }

  //安全にデータを追加するためにScheduleFormクラスを使用
  Future<int> addSchedule(ScheduleForm schedule) {
    return into(schedules).insert(
      SchedulesCompanion(
        title: Value(schedule.title),
        startTime: Value(schedule.startTime),
        endTime: Value(schedule.endTime),
        isAllDay: Value(schedule.isAllDay),
        content: Value(schedule.content),
      ),
    );
  }

  Future<int> deleteSchedule(int id) {
    return (delete(schedules)..where((tbl) => tbl.id.equals(id))).go();
  }

  Future<int> updateSchedule(Schedule schedule) {
    return (update(schedules)..where((tbl) => tbl.id.equals(schedule.id)))
        .write(
      SchedulesCompanion(
        title: Value(schedule.title),
        startTime: Value(schedule.startTime),
        endTime: Value(schedule.endTime),
        isAllDay: Value(schedule.isAllDay),
        content: Value(schedule.content),
      ),
    );
  }

  Future<bool> hasAppointmentOnDate(DateTime date) async {
    final startOfDay = DateTime(date.year, date.month, date.day);
    final endOfDay = DateTime(date.year, date.month, date.day, 23, 59, 59);
    final queryRows = await (select(schedules)..where((t) 
      => t.startTime.isBiggerOrEqualValue(startOfDay) & 
         t.startTime.isSmallerOrEqualValue(endOfDay),)).get();
    return queryRows.isNotEmpty;
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;
    return NativeDatabase(file);
  });
}
