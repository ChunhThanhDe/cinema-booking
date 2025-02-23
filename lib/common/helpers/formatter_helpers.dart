/*
 * @ Author: Chung Nguyen Thanh <chunhthanhde.dev@gmail.com>
 * @ Created: 2025-12-20 14:32:06
 * @ Message: 🎯 Happy coding and Have a nice day! 🌤️
 */

import 'package:intl/intl.dart';

extension HHmm on Duration {
  String formatHHmm() {
    //1:34:00.000000
    final str = toString();

    final texts = str.split(":");
    final textHour = texts[0].padLeft(2, '0');
    final textMinute = texts[1].padLeft(2, '0');

    return "${textHour}h ${textMinute}m";
  }
}

extension FormatNumber on int {
  String formatDecimalThousand() {
    //2025 -> 2,025
    var f = NumberFormat.decimalPattern("en_US");
    return f.format(this);
  }
}

extension FormatDate on int {
  // ignore: non_constant_identifier_names
  String MMM_dd_yyyy() {
    return DateFormat(
      "MMM dd, yyyy",
    ).format(DateTime.fromMillisecondsSinceEpoch(this * 1000));
  }
}
