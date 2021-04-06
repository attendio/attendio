import 'package:flutter/material.dart';
import 'package:attendio/pages/unknown_screen.dart';

class UnknownPage extends Page {
  UnknownPage() : super(key: ValueKey("UnknownPage"));

  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (BuildContext context) => UnknownScreen(),
    );
  }
}
