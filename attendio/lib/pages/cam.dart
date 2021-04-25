import 'package:attendio/pages/check_in_screen.dart';
import 'package:attendio/pages/home.dart';
import 'package:attendio/pages/profile.dart';
import 'package:barcode_scan_fix/barcode_scan.dart';
import 'package:flutter/material.dart';

Future<String> checkinCam() async {
  String scanResult = await BarcodeScanner.scan();
  var link = Uri.parse(scanResult);
  var eventId = Uri.parse(link.queryParameters["link"]).pathSegments.last;
  return eventId;
}

class CameraCheckin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // String res = checkinCam();
    return FutureBuilder<String>(
      future: checkinCam(),
      builder: (context, AsyncSnapshot<String> snapshot) {
        if (snapshot.hasData) {
          return CheckInScreen(snapshot.data);
        } else {
          // TODO Need to update navbar index in the event of going back and not scanning code
          return Profile();
        }
      },
    );
  }
}
