import 'package:intl/intl.dart';

class Format {
  static final money = NumberFormat("#,##0.00", "en_US");

  static String toMoney(double dollars) {
    return '\$${money.format(dollars)}';
  }
}
