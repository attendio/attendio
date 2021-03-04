import 'package:flutter/material.dart';

import 'event.dart';
import 'landing.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => LandingPage(),
      '/test': (context) => EventScreen(),
    },
  ));
}
