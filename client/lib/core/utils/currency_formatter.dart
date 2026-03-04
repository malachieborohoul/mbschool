import 'package:intl/intl.dart';

class CurrencyFormatter {
  static NumberFormat getFormatter(int languageCode) {
    String locale = languageCode == 0 ? "en_US" : "fr_FR";
    return NumberFormat("###0.00", locale);
  }
}
