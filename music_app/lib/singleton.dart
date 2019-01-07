import 'package:music_app/login.dart';

class LoginEnsure {
  static final LoginEnsure _loginEnsure = new LoginEnsure._internal();

  static var isLogin = true;

  factory LoginEnsure() {
    return _loginEnsure;
  }

  LoginEnsure._internal();
}
