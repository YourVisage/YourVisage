import 'dart:io';

import 'package:client/static/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<SharedPreferences> _sharedPref = SharedPreferences.getInstance();
Application application = Application();

class Application extends Constants {
  getProfileImage() async {
    final SharedPreferences sharedPref = await _sharedPref;
    return sharedPref.getString(Constants.storageKey + Constants.prifileImage);
  }

  setProfileImage(String prifileImage) async {
    final SharedPreferences sharedPref = await _sharedPref;
    sharedPref.setString(Constants.storageKey + Constants.prifileImage, prifileImage);
  }
}
