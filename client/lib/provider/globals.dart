import 'package:client/model/login_model.dart';
import 'package:client/model/user_model.dart';

Globals globals = Globals();

class Globals {
  SignInResponse? sigup;
  LoginUserResponse? login;

  void clear() {
    sigup = null;
  }
}
