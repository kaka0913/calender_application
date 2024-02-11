class CalendarBuilder {
  List<List<int?>> build(DateTime date) {
    final calendar = <List<int?>>[];

    final firstWeekday = _calcFirstWeekday(date);
    final lastDate = _calcLastDate(date);

    final firstWeek = List.generate(7, (index) {
      final i = index + 1;
      final offset = i - firstWeekday;
      return i < firstWeekday ? null : 1 + offset;
    });

    calendar.add(firstWeek);

    while (true) {
      final firstDateOfWeek = calendar.last.last! + 1;
      final week = List.generate(7, (index) {
        final date = firstDateOfWeek + index;
        return date <= lastDate ? date : null;
      });

      calendar.add(week);

      final lastDateOfWeek = week.last;
      if (lastDateOfWeek == null || lastDateOfWeek >= lastDate) {
        break;
      }
    }

    return calendar;
  }

  int _calcFirstWeekday(DateTime date) {
    return DateTime(date.year, date.month).weekday;
  }

  int _calcLastDate(DateTime date) {
    return DateTime(date.year, date.month + 1, 0).day;
  }
}
