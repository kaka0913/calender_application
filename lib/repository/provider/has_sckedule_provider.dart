import 'package:calender_application/repository/drift_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final scheduleExistenceProvider = 
  FutureProvider.family.autoDispose<bool, DateTime>((ref, date) async {
    final datebase = ref.watch(driftDbProvider);
    final response = await datebase.hasAppointmentOnDate(date);
    return response;
});
