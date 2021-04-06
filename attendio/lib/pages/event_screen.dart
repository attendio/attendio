import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share/share.dart';

class EventScreen extends StatefulWidget {
  @override
  _EventPageState createState() => _EventPageState();
}

class _EventPageState extends State<EventScreen> {
  GlobalKey globalKey = new GlobalKey();

  String dynamicLink = "insert link here";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Event Page',
      home: Scaffold(
          appBar: AppBar(
            title: Text('This is an event'),
          ),
          body: Center(
            child: Column(
              children: <Widget>[
                RepaintBoundary(
                  key: globalKey,
                  child: QrImage(
                    data: dynamicLink,
                    version: QrVersions.auto,
                    size: 200.0,
                    backgroundColor: Colors.white,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    captureAndSharePng();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Share',
                      style: TextStyle(fontSize: 25, color: Colors.white),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: dynamicLink));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Copy Dynamic Link',
                      style: TextStyle(fontSize: 25, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }

  Future<void> captureAndSharePng() async {
    try {
      RenderRepaintBoundary boundary =
          globalKey.currentContext.findRenderObject();
      var image = await boundary.toImage();
      ByteData byteData = await image.toByteData(format: ImageByteFormat.png);
      Uint8List pngBytes = byteData.buffer.asUint8List();

      final tempDir = await getTemporaryDirectory();
      final file = await new File('${tempDir.path}/image.png').create();
      await file.writeAsBytes(pngBytes);

      Share.shareFiles([file.path]);
    } catch (e) {
      print(e.toString());
    }
  }
}
