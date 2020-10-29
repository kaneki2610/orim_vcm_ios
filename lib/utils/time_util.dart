import 'package:easy_localization/easy_localization.dart';

class TimeUtil {
  /// stringTime like 2020-02-25T09:31:17.2821561+07:00
  /// return hh:mm:ss
  static String convertStringToTextTime(String stringTime) {
    var parsedDate = DateTime.parse(stringTime).toLocal();
    String dateString = DateFormat('HH:mm:ss').format(parsedDate);
    return dateString ?? "";
//    String temp = stringTime.substring(0, 19);
//    DateTime dateTime = DateTime.parse(temp).toLocal();
//    String hour, minute, second;
//    hour = dateTime.hour >= 10 ? '${dateTime.hour}' : '0${dateTime.hour}';
//    minute = dateTime.minute >= 10 ? '${dateTime.minute}' : '0${dateTime.minute}';
//    second = dateTime.second >= 10 ? '${dateTime.second}' : '0${dateTime.second}';
//    return '$hour:$minute:$second';
  }

  /// stringTime like 2020-02-25T09:31:17.2821561+07:00
  /// return DD/MM/YYYY
  static String convertStringToTextDate(String stringTime) {
    var parsedDate = DateTime.parse(stringTime).toLocal();
    String dateString = DateFormat('dd/MM/yyyy').format(parsedDate);
    return dateString ?? "";
//    String temp = stringTime.substring(0, 19);
//    DateTime dateTime = DateTime.parse(temp).toLocal();
//    String day, month, year;
//    day = dateTime.day >= 10 ? '${dateTime.day}' : '0${dateTime.day}';
//    month = dateTime.month >= 10 ? '${dateTime.month}' : '0${dateTime.month}';
//    year = dateTime.year >= 10 ? '${dateTime.year}' : '0${dateTime.year}';
//    return '$day/$month/$year';
  }

  static String ddMMYYYYHHMMSS(DateTime time) {
    var parsedDate = time.toLocal();
    String dateString = DateFormat('dd/MM/yyyy HH:mm:ss').format(parsedDate);
    return dateString ?? "";
//    String temp = stringTime.substring(0, 19);
//    DateTime dateTime = DateTime.parse(temp).toLocal();
//    String hour, minute, second;
//    hour = dateTime.hour >= 10 ? '${dateTime.hour}' : '0${dateTime.hour}';
//    minute = dateTime.minute >= 10 ? '${dateTime.minute}' : '0${dateTime.minute}';
//    second = dateTime.second >= 10 ? '${dateTime.second}' : '0${dateTime.second}';
//    return '$hour:$minute:$second';
  }

  static String convertDdmmyyyToYyyyMMdd(String stringdate) {
    List<String> strs = stringdate.split("/");
    if (strs.length == 3) {
      return strs[2] + "-" + strs[1] + "-" + strs[0];
    } else {
      return stringdate;
    }
  }

  static String forMatddMMYYYYHHmmss(DateTime dateTime) {
    String dateString = DateFormat('dd/MM/yyyy HH:mm:ss').format(dateTime);
    return dateString;
  }

  static String formatYYYYMMDD(DateTime dateTime) {
    String dateString = DateFormat('yyyy-MM-dd').format(dateTime);
    return dateString;
  }
}
