import 'package:intl/intl.dart';

extension DoubleX on double {
  String toCurrency() {
    final formatter = NumberFormat.currency(symbol: '', decimalDigits: 2);
    return formatter.format(this);
  }
}
