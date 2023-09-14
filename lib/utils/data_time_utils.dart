String getMonthAbbreviation(DateTime date) => [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sept',
      'Oct',
      'Nov',
      'Dec',
    ][date.month + 1];

String getDayWithSuffix(DateTime date) {
  final day = date.day;
  if (day >= 11 && day <= 13) {
    return '$day' + 'th';
  }

  return switch (day % 10) {
    1 => '$day' + 'st',
    2 => '$day' + 'nd',
    3 => '$day' + 'rd',
    _ => '$day' + 'th'
  };
}

String getWeekday(DateTime date) => switch (date.weekday) {
      DateTime.monday => 'Monday',
      DateTime.tuesday => 'Tuesday',
      DateTime.wednesday => 'Wednesday',
      DateTime.thursday => 'Thursday',
      DateTime.friday => 'Friday',
      DateTime.saturday => 'Saturday',
      DateTime.sunday => 'Sunday',
      _ => ''
    };
