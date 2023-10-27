import 'package:intl/intl.dart';

class Formater {
  static String formatPrice(num? price) {
    final numberFormat = NumberFormat("NPR #,##,###");
    return numberFormat.format(price);
  }

  static String formatDate(DateTime date) {
    DateTime localDate = date.toLocal();
    final dateFormat = DateFormat("dd MMM y, hh:mm a");
    return dateFormat.format(localDate);
  }
}
