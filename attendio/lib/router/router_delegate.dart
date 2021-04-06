import 'dart:io';

import 'package:attendio/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:attendio/router/route_config.dart';
import 'package:attendio/router/pages/pages.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AttendioRouterDelegate extends RouterDelegate<AttendioConfig>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<AttendioConfig> {
  final GlobalKey<NavigatorState> _navigatorKey;
  final FirebaseAuth _authState;

  AttendioRouterDelegate(this._authState)
      : _navigatorKey = GlobalKey<NavigatorState>();

  @override
  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  bool _show404;
  bool get show404 => _show404;
  set show404(bool value) {
    _show404 = value;
    if (value == true) {
      // Set any non-login data to null such as current event
    }
    notifyListeners();
  }

  User _userState;
  User get userState => _userState;
  set userState(User value) {
    _userState = value;
    notifyListeners();
  }

  @override
  AttendioConfig get currentConfiguration {
    if (userState == null) {
      return AttendioConfig.login();
    } else if (userState != null) {
      return AttendioConfig.home(_authState.currentUser);
    } else if (show404 == true) {
      return AttendioConfig.unknown(_authState.currentUser);
    } else {
      return AttendioConfig.unknown(_authState.currentUser);
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Page> stack;
    if (show404 == true) {
      stack = _unknownStack;
    } else if (userState == null) {
      print("Logged OUT");
      print(userState);
      stack = _loggedOutStack;
    } else if (userState != null) {
      print("Logged IN");
      print(userState);
      stack = _loggedInStack;
    }

    return Navigator(
      key: navigatorKey,
      pages: stack,
      onPopPage: (route, result) {
        if (!route.didPop(result)) return false;
        return true;
      },
    );
  }

  List<Page> get _unknownStack => [UnknownPage()];

  List<Page> get _loggedOutStack => [LoginPage()];

  List<Page> get _loggedInStack => [HomePage()];

  @override
  Future<void> setNewRoutePath(AttendioConfig configuration) async {
    if (configuration.unknown) {
      show404 = true;
    } else if (configuration.isHomePage || configuration.isLoginPage) {
      show404 = false;
    } else {
      print("Could not set new route");
    }
  }
}
