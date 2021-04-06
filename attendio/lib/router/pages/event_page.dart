import 'package:flutter/material.dart';
import 'package:attendio/pages/event_screen.dart';

class EventPage extends Page {
  EventPage() : super(key: ValueKey("UnknownPage"));

  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (BuildContext context) => EventScreen(),
    );
  }
}
