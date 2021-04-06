import 'package:firebase_auth/firebase_auth.dart';

class AttendioConfig {
  final User userState;
  final bool unknown;

  AttendioConfig.login()
      : unknown = false,
        userState = null;

  AttendioConfig.home(User state)
      : unknown = false,
        userState = state;

  AttendioConfig.unknown(User state)
      : unknown = true,
        userState = state;

  bool get isUnknown => unknown == true;
  bool get isLoginPage => unknown == false && userState == null;
  bool get isHomePage => unknown == false && userState != null;
}
