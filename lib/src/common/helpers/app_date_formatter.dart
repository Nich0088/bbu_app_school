import 'package:easy_localization/easy_localization.dart';

class AppDateFormatter {
  static const String monthCommaDateYear = "MMM dd, yyyy";

  static String formatDate({required String pattern, String? dateString}) {
    if (dateString == null || dateString.isEmpty == true) return '';

    return DateFormat(pattern).format(DateTime.parse(dateString));
  }
}
