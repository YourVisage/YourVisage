import 'package:intl/intl.dart';

class Func {
  static bool isEmpty(Object o) => o == '';

  static bool isNotEmpty(Object? o) => o != null && o != '';

  static bool isNumeric(String str) {
    return double.tryParse(str) != null;
  }

  static String fixedPhoneNumber(String phone) {
    if (phone.isNotEmpty) {
      var first = phone.substring(0, 4);
      var second = phone.substring(4);
      return '$first-$second';
    } else {
      return '';
    }
  }

  static String toDateStr(String str) {
    // Datetime string-ийг форматлаад буцаана '2019.01.01T15:13:00.000' to '2019.01.01'
    if (isEmpty(str)) return '';

    DateTime dateTime = DateTime.parse(str);
    String formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);

    return formattedDate; //trim(str.split(" ")[0]);
  }

  static String toStr(Object obj) {
    String res = '';
    try {
      if (obj is DateTime) {
        // res = DateFormat('yyyy-MM-dd HH:mm:ss').format(obj);
        res = DateFormat('yyyy-MM-dd').format(obj);
      } else if (obj is int) {
        res = obj.toString();
      } else if (obj is double) {
        res = obj.toString();
      } else if (obj is String) {
        res = obj;
      }
    } catch (e) {
      print(e);
    }
    return res;
  }

  static String toMoneyStr(
    Object value, {
    bool obscureText = false, //Secure mode ашиглах эсэх
    NumberFormat? numberFormat,
  }) {
    // //print('testL:$value');

    /// Format number with "Decimal Point" digit grouping.
    /// 10000 -> 10,000.00
    if (obscureText) return '***';

    //Хоосон утгатай эсэх
    if (Func.toStr(value) == '') {
      return '0.00';
    }

    //Зөвхөн тоо агуулсан эсэх
    String tmpStr = Func.toStr(value).replaceAll(',', '').replaceAll('.', '');
    if (!isNumeric(tmpStr)) {
      return '0.00';
    }

    //Хэрэв ',' тэмдэгт агуулсан бол устгана
    double tmpDouble = double.parse(Func.toStr(value).replaceAll(',', ''));

    String formattedStr = '';
    String result = '';
    try {
      //Format number
      NumberFormat formatter = numberFormat ?? NumberFormat('#,###.##');
      result = formatter.format(tmpDouble);
      formattedStr = '${result.replaceAll(',', '\'')}₮';
    } catch (e) {
      //print(e);
      result = '0.00';
    }
    return formattedStr;
  }

  static String toMoneyComma(
    Object value, {
    bool obscureText = false, //Secure mode ашиглах эсэх
    NumberFormat? numberFormat,
  }) {
    // //print('testL:$value');

    /// Format number with "Decimal Point" digit grouping.
    /// 10000 -> 10,000.00
    if (obscureText) return '***';

    //Хоосон утгатай эсэх
    if (Func.toStr(value) == '') {
      return '0.00';
    }

    //Зөвхөн тоо агуулсан эсэх
    String tmpStr = Func.toStr(value).replaceAll(',', '').replaceAll('.', '');
    if (!isNumeric(tmpStr)) {
      return '0.00';
    }

    //Хэрэв ',' тэмдэгт агуулсан бол устгана
    double tmpDouble = double.parse(Func.toStr(value).replaceAll(',', ''));

    String formattedStr = '';
    String result = '';
    try {
      //Format number
      NumberFormat formatter = numberFormat ?? NumberFormat('#,###.##');
      result = formatter.format(tmpDouble);
      formattedStr = result.replaceAll(',', '\'');
    } catch (e) {
      //print(e);
      result = '0.00';
    }

    return formattedStr;
  }

  bool isEmail(String email) {
    final RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    return emailRegex.hasMatch(email);
  }

  bool getIsSpecialAd(String date) {
    if (date == '') {
      return false;
    } else if (date != '0001-01-01T00:00:00Z') {
      return true;
    } else {
      return false;
    }
  }

  bool isExpiredDate(String date) {
    DateTime formattedDate = DateFormat('yyyy-MM-dd').parse(date);
    DateTime nowDate =
        DateFormat('yyyy-MM-dd').parse(DateTime.now().toString());

    if (formattedDate == nowDate) {
      return false;
    } else if (formattedDate.isAfter(nowDate)) {
      return true;
    } else {
      return false;
    }
  }

  String dateDiffInDays(String first, String last) {
    var format = DateFormat('yyyy-MM-dd');
    first = format.format(DateTime.parse(first));
    last = format.format(DateTime.parse(last));

    DateTime firstDate = DateTime.parse(first);
    DateTime lastDate = DateTime.parse(last);

    return lastDate.difference(firstDate).inDays.isNegative
        ? '0'
        : lastDate.difference(firstDate).inDays.toString();
  }
  // }
}
