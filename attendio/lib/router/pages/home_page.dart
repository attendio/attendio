import 'package:flutter/material.dart';
import 'package:attendio/pages/home_screen.dart';

class HomePage extends Page {
  HomePage() : super(key: ValueKey("UnknownPage"));

  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (BuildContext context) => HomeScreen(),
    );
  }
}
