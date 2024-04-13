extension DateTimeExtension on DateTime {
  String toDateString({String seperator = "/"}) => "$day$seperator$month$seperator$year";

  String toIsonDateString({String seperator = "/"}) => "$year$seperator$month$seperator$day";
}