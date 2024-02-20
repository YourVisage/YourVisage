import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Utils {
  static void hideKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
    SystemChannels.textInput.invokeMethod('TextInput.hide'); // hide keyboard
  }
}
