import 'package:flutter/material.dart';

import 'login.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => LoginPage(),
      '/test': (context) => EventScreen(),
    },
  ));
}

class EventScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Event Screen',
      home: Scaffold(
        appBar: AppBar(
          title: Text('This is an event'),
        ),
        body: Center(
          child: Text('Event #1'),
        ),
      ),
    );
  }
}
