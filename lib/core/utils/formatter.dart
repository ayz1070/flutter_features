import 'package:intl/intl.dart';

class Formatter {
  static String formatPhoneNumber(String phoneNumber) {
    final RegExp regExp = RegExp(r'(\d{3})(\d{4})(\d{4})');
    return phoneNumber.replaceAllMapped(regExp, (Match m) => '${m[1]}-${m[2]}-${m[3]}');
  }

  /// 가격 포맷터: 1234567.89 -> 1,234,567원 (소수점 버림)
  static String formatPrice(double price) {
    final formatter = NumberFormat("#,###");
    return "${formatter.format(price.floor())}원"; // 소수점 버림 후 포맷팅
  }

  /// 가격 포맷터: 1234567.89 -> 1,234,567원 (소수점 버림)
  static String formatPoint(double point) {
    final formatter = NumberFormat("#,###");
    return "${formatter.format(point.floor())}P"; // 소수점 버림 후 포맷팅
  }

  /// 날짜 포멧터 (년.월.일)
  static String formatYearMonthDate(DateTime dateTime){
    final formatedDate = DateFormat('yyyy.MM.dd').format(dateTime);
    return formatedDate;
  }

  /// 시간 포멧터 (24:60)
  static String formatHourMinute(DateTime dateTime){
    final formatedTime = DateFormat("HH:mm").format(dateTime);
    return formatedTime;
  }

}