import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class GlobalHelper {
  static toHumanReadable(String date, [format = 'dd-MMM-yyyy']) {
    DateTime dateTime = DateTime.parse(date);
    return DateFormat(format).format(dateTime);
  }

  static formatAmountReadable(String amount) {
    var _formattedNumber =
        NumberFormat.compactCurrency(decimalDigits: 2, symbol: "\$")
            .format(double.parse(amount));
    return _formattedNumber;
  }

  static formatAmount(String amount) {
    return '\$' + double.parse(amount).toStringAsFixed(2);
  }

  Future<String> getDeviceName() async {
    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

    try {
      if (Platform.isAndroid) {
        var build = await deviceInfoPlugin.androidInfo;
        return build.model!;
      } else if (Platform.isIOS) {
        var build = await deviceInfoPlugin.iosInfo;
        return build.model!;
      }
      return "Unknown";
    } on PlatformException {
      return 'Failed to get platform version';
    }
  }
}
