import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class EventPage extends StatefulWidget {
  @override
  _EventPageState createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  String dynamicLink = "https://attendio.page.link/test";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Event Screen',
      home: Scaffold(
        appBar: AppBar(
          title: Text('This is an event'),
        ),
        body: Center(
          child: QrImage(
            data: dynamicLink,
            version: QrVersions.auto,
            size: 200.0,
            backgroundColor: Colors.white,
          ),
        ),
      ),
    );
  }
}
