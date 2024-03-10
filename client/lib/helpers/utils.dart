import 'package:client/component/custom_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:overlay_support/overlay_support.dart';

class Utils {
  static void hideKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
    SystemChannels.textInput.invokeMethod('TextInput.hide'); // hide keyboard
  }

  bool isValidEmail(String email) {
    // Using a regular expression to validate email format
    final RegExp emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegExp.hasMatch(email);
  }

  showToastAlert(String message, {bool isAlert = true}) {
    showOverlay(
      (_, t) {
        return CustomToast(
          message: message,
          isAlert: isAlert,
        );
      },
      key: ValueKey(message),
      duration: const Duration(milliseconds: 1000),
      reverseAnimationDuration: const Duration(milliseconds: 1000),
    );
  }

  bool isSame(String str1, String str2) {
    return str1 == str2;
  }
}
