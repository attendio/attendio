import 'package:attendio/providers/auth_provider.dart';
import 'package:attendio/utils/styles.dart';
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
        title: Text("Attendio",
            style: TextStyle(
                color: Color(0xFF6A1B9A),
                fontWeight: FontWeight.w700,
                fontSize: 25)),
        backgroundColor: Colors.white,
        elevation: 5,
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
                child: Icon(Icons.logout, color: Color(0xFF6A1B9A)),
              )),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(
            height: 25,
          ),
          Container(
            child: Container(
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                        auth.getPhotoURL(),
                      ),
                      radius: 45.0,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      auth.getName(),
                      style: TextStyle(
                        fontSize: 25.0,
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
                            horizontal: 6.0, vertical: 15.0),
                        child: Row(
                          children: <Widget>[
                            Container(
                              margin: const EdgeInsets.only(left: 16.0),
                              child: Column(
                                children: <Widget>[
                                  Text(
                                    "Events Created",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.0,
                                      // fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  Text(
                                    "250",
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      color: Colors.white,
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
                                      fontSize: 18.0,
                                      // fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  Text(
                                    "1337",
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      color: Colors.white,
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
          Container(
            height: 25,
          ),
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
