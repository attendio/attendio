import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share/share.dart';
import 'package:flutter/services.dart';

class EventPage extends StatefulWidget {
  @override
  _EventPageState createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  GlobalKey globalKey = new GlobalKey();
  final ButtonStyle elevatedStyle = ElevatedButton.styleFrom(
      elevation: 5,
      primary: Colors.deepPurple,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)));

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
                  style: elevatedStyle,
                ),
                ElevatedButton(
                  onPressed: () {
                    Clipboard.setData(new ClipboardData(text: dynamicLink));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Copy Dynamic Link',
                      style: TextStyle(fontSize: 25, color: Colors.white),
                    ),
                  ),
                  style: elevatedStyle,
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
