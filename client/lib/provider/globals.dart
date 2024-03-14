import 'package:client/model/user_model.dart';

Globals globals = Globals();

class Globals {
  SignInResponse? sigup;

  void clear() {
    sigup = null;
  }
}
