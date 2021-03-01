import 'package:flutter/material.dart';

import 'event.dart';
import 'login.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => LoginPage(),
      '/test': (context) => EventPage(),
    },
  ));
}
