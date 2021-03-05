import 'package:flutter/material.dart';
import 'utils/styles.dart';
import 'event.dart';
import 'landing.dart';

void main() {
  runApp(MaterialApp(
    theme: globalTheme,
    initialRoute: '/',
    routes: {
      '/': (context) => LandingPage(),
      '/test': (context) => EventScreen(),
    },
  ));
}
