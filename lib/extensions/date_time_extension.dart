extension DateTimeExtension on DateTime {
  String toDateString({String seperator = "/"}) => "$day$seperator$month$seperator$year";
}