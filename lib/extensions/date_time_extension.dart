extension DateTimeExtension on DateTime {
  String toDateString({String seperator = "/"}) => "$day$seperator$month$seperator$year";

  String toIsoDateString({String seperator = "/"}) => "$year$seperator$month$seperator$day";

  String to24HourString({String seperator = ":"}) => "$hour$seperator${(minute < 10) ? "0" : ""}$minute";

  String to12HourString({String seperator = ":"}) => "${hour % 12}$seperator${(minute < 10) ? "0" : ""}$minute ${(hour < 12) ? "AM" : "PM"}";

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