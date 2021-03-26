import 'package:attendio/providers/auth_provider.dart';
// import 'package:attendio/providers/dl_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'landing.dart';
import 'create_event.dart';

// Landing page for post successful login
class HomePage extends HookWidget {
  final ButtonStyle elevatedStyle = ElevatedButton.styleFrom(
      elevation: 5,
      primary: Colors.deepPurple,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)));

  @override
  Widget build(BuildContext context) {
    final auth = useProvider(authServicesProvider);
    // final dynamicLink = useProvider(linkServicesProvider);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Colors.blue[100], Colors.blue[400]],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              CircleAvatar(
                backgroundImage: NetworkImage(
                  auth.getPhotoURL(),
                ),
                radius: 60,
                backgroundColor: Colors.transparent,
              ),
              SizedBox(height: 40),
              Text(
                'NAME',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54),
              ),
              Text(
                auth.getName(),
                style: TextStyle(
                    fontSize: 25,
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text(
                'EMAIL',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54),
              ),
              Text(
                auth.getEmail(),
                style: TextStyle(
                    fontSize: 25,
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  auth.signOutGoogle();
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) {
                    return LandingPage();
                  }), ModalRoute.withName('/'));
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Sign Out',
                    style: TextStyle(fontSize: 25, color: Colors.white),
                  ),
                ),
              ),
              ElevatedButton(
                // onPressed: () async {
                //   String url = await dynamicLink
                //       .createDynamicLink("test", "12345");
                //   print(url);
                // },
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CreateEvent()),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Create Event',
                    style: TextStyle(fontSize: 25, color: Colors.white),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/test');
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Go To Event',
                    style: TextStyle(fontSize: 25, color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
