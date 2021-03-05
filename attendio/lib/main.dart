import 'package:flutter/material.dart';
import 'utils/styles.dart';
import 'event.dart';
import 'login.dart';

void main() {
  runApp(MaterialApp(
    theme: globalTheme,
    initialRoute: '/',
    routes: {
      '/': (context) => LoginPage(),
      '/test': (context) => EventScreen(),
    },
  ));
}
