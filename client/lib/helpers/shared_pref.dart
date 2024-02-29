import 'package:client/helpers/func.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences? sharedPref;

class SharedPrefKey {
  static const String key = 'visage';

  static const String theme = 'theme';
  static const String introLimit = 'introLimit';

  /// Auth
  static const String phoneNumber = 'phoneNumber';
  static const String password = 'password';
  static const String rememberMe = 'rememberMe';
  static const String biometricAuth = 'biometricAuth';
  static const String sessionToken = 'sessionToken'; // Session token

  /// Push notification
  static const String pushNotifToken =
      'pushNotifToken'; // Google firebase push notification token
  static const String registeredPushNotifToken =
      'registeredPushNotifToken'; // Өмнө нь server рүү бүртгүүлсэн эсэх
}

class SharedPref {
  static String getSessionToken() {
    //
    return sharedPref?.getString(SharedPrefKey.sessionToken) ?? '';
  }

  static void setSessionToken(String? sessionToken) {
    sharedPref?.setString(
        SharedPrefKey.sessionToken, Func.toStr(sessionToken ?? ''));
  }




  static bool getRememberMe() {
    return sharedPref?.getBool(SharedPrefKey.rememberMe) ?? false;
  }

  static void setRememberMe(bool isRemembered) {
    sharedPref?.setBool(SharedPrefKey.rememberMe, isRemembered);
  }
}
