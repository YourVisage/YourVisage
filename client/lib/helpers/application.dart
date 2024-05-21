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

  getGeneratedImage() async {
    final SharedPreferences sharedPref = await _sharedPref;
    return sharedPref.getString(Constants.storageKey + Constants.generatedImage);
  }

  setGeneratedImage(String generatedImage) async {
    final SharedPreferences sharedPref = await _sharedPref;
    sharedPref.setString(Constants.storageKey + Constants.generatedImage, generatedImage);
  }

  Future<SharedPreferences> getSharedPrefs() async {
    return await SharedPreferences.getInstance();
  }

  Future<String?> getSavedImageData() async {
    final prefs = await getSharedPrefs();
    return prefs.getString('generated_image');
  }

  getSessionToken() async {
    final SharedPreferences sharedPref = await _sharedPref;
    return sharedPref.getString(Constants.storageKey + Constants.jwt);
  }

  setSessionToken(String jwt) async {
    final SharedPreferences sharedPref = await _sharedPref;
    sharedPref.setString(Constants.storageKey + Constants.jwt, jwt);
  }
}
