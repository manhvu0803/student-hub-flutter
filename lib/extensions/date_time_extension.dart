extension DateTimeExtension on DateTime {
  String toDateString({String seperator = "/", bool twoDigitMonth = true}) {
    var monthString = toMonthString(seperator: seperator, twoDigitMonth: twoDigitMonth);
    return "$day$seperator$monthString";
  }

  String toMonthString({String seperator = "/", bool twoDigitMonth = true}) {
    var zero = (twoDigitMonth && month < 10) ? "0" : "";
    return "$zero$month$seperator$year";
  }

  String toIsoDateString({String seperator = "/"}) => "$year$seperator$month$seperator$day";

  String to24HourString({String seperator = ":"}) => "$hour$seperator${(minute < 10) ? "0" : ""}$minute'";

  String to12HourString({String seperator = ":"}) {
    var minuteZero = (minute < 10) ? "0" : "";
    var text = (hour < 12) ? "AM" : "PM";
    return "${hour % 12}$seperator$minuteZero$minute' $text";
  }

  String toDateTimeString({
    String dateSeperator = "/",
    String timeSeperator = ":",
    String dateTimeSeperator = " ",
    bool use24Hour = true
  }) {
    var time = use24Hour ? to24HourString(seperator: timeSeperator) : to24HourString(seperator: timeSeperator);
    return "${toDateString(seperator: dateSeperator)}$dateTimeSeperator$time";
  }
}