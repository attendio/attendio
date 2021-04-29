import 'package:attendio/pages/check_in_screen.dart';
import 'package:barcode_scan_fix/barcode_scan.dart';
import 'package:flutter/material.dart';

class CheckIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // String res = checkinCam();

    return Scaffold(
      appBar: AppBar(
        title: Text("Attendio",
            style: TextStyle(
                color: Color(0xFF6A1B9A),
                fontWeight: FontWeight.w700,
                fontSize: 25)),
        backgroundColor: Colors.white,
        elevation: 5,
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 100,
          ),
          Container(
            child: Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFF6A1B9A),
                ),
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
          ),
          Container(
            height: 100,
          ),
          Container(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Color(0xFF6A1B9A),
              ),
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
