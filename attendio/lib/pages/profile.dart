import 'package:attendio/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'landing.dart';

// Login page layout
class Profile extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final auth = useProvider(authServicesProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text("Attendio"),
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  auth.signOutGoogle();
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) {
                    return LandingPage();
                  }), ModalRoute.withName('/'));
                },
                child: Icon(Icons.logout),
              )),
        ],
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        // mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(
            child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 2,
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                        auth.getPhotoURL(),
                      ),
                      radius: 75.0,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      auth.getName(),
                      style: TextStyle(
                        fontSize: 30.0,
                        color: Color(0xFF373737),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Card(
                      margin:
                          EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                      clipBehavior: Clip.antiAlias,
                      color: Color(0xFF6A1B9A),
                      elevation: 5.0,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 22.0),
                        child: Row(
                          children: <Widget>[
                            Container(
                              child: Column(
                                children: <Widget>[
                                  Text(
                                    "Events Created",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 22.0,
                                      // fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  Text(
                                    "250",
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      color: Colors.white,
                                      // fontWeight: FontWeight.bold,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              child: Column(
                                children: <Widget>[
                                  Text(
                                    "Events Attended",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 22.0,
                                      // fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  Text(
                                    "1337",
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      color: Colors.white,
                                      // fontWeight: FontWeight.bold,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Keeping this comment here for now since new widget was adapted from this snippet
          // ElevatedButton(
          //   onPressed: () async {
          //     String scanResult = await BarcodeScanner.scan();
          //     var link = Uri.parse(scanResult);
          //     var eventId =
          //         Uri.parse(link.queryParameters["link"]).pathSegments.last;
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //           builder: (context) => CheckInScreen(eventId)),
          //     );
          //   },
          //   child: Padding(
          //     padding: const EdgeInsets.all(8.0),
          //     child: Text(
          //       'Scan Event Code',
          //       style: TextStyle(fontSize: 25, color: Colors.white),
          //     ),
          //   ),
          // ),
          Container(
            alignment: Alignment.center,
            width: double.infinity,
            child: Text(
              'Your Events',
              style: TextStyle(
                fontSize: 28.0,
                color: Color(0xFF373737),
              ),
            ),
          ),
          Container(
            child: Divider(
              height: 10,
              thickness: 2,
            ),
          ),
          Expanded(
            child: Container(
              child: ListView(
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.calendar_today),
                    title: Text('My Event 1'),
                  ),
                  ListTile(
                    leading: Icon(Icons.calendar_today),
                    title: Text('My Event 2'),
                  ),
                  ListTile(
                    leading: Icon(Icons.calendar_today),
                    title: Text('My Event 3'),
                  ),
                  ListTile(
                    leading: Icon(Icons.calendar_today),
                    title: Text('My Event 4'),
                  ),
                  ListTile(
                    leading: Icon(Icons.calendar_today),
                    title: Text('My Event 5'),
                  ),
                  ListTile(
                    leading: Icon(Icons.calendar_today),
                    title: Text('My Event 6'),
                  ),
                  ListTile(
                    leading: Icon(Icons.calendar_today),
                    title: Text('My Event 7'),
                  ),
                  ListTile(
                    leading: Icon(Icons.calendar_today),
                    title: Text('My Event 8'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
