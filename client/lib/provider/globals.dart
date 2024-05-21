import 'package:client/helpers/application.dart';
import 'package:client/helpers/shared_pref.dart';
import 'package:client/model/login_model.dart';
import 'package:client/model/user_model.dart';
import 'package:client/router/router_path.dart';
import 'package:client/static/constant.dart';

Globals globals = Globals();

class Globals {
  SignInResponse? sigup;
  LoginUserResponse? login;

  void clear() {
    sigup = null;
    login = null;
    application.setProfileImage('');
    application.setGeneratedImage('');
    SharedPref.setSessionToken('');
    Navkey.navkey.currentState?.pushNamedAndRemoveUntil(RouterPath.login, (route) => false);
  }
}
