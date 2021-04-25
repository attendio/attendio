import 'package:attendio/pages/check_in_screen.dart';
import 'package:attendio/pages/home.dart';
import 'package:attendio/pages/profile.dart';
import 'package:barcode_scan_fix/barcode_scan.dart';
import 'package:flutter/material.dart';

class CheckIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // String res = checkinCam();

    return Scaffold(
      appBar: AppBar(
        title: Text("Attendio"),
      ),
      body: Column(
        children: <Widget>[
          Container(
            child: ElevatedButton(
              onPressed: () async {
                String scanResult = await BarcodeScanner.scan();
                var link = Uri.parse(scanResult);
                var eventId =
                    Uri.parse(link.queryParameters["link"]).pathSegments.last;
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CheckInScreen(eventId)),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Scan Event Code',
                  style: TextStyle(fontSize: 25, color: Colors.white),
                ),
              ),
            ),
          ),
          Container(
            child: ElevatedButton(
              onPressed: () async {},
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Enter Event Code',
                  style: TextStyle(fontSize: 25, color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
