import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'dynamic_link_funcs.dart';
import 'login.dart';
import 'signin_funcs.dart';

// Landing page for post successful login
class FirstScreen extends StatelessWidget {
  final FirebaseDynamicLinks dynamicLink;
  final FirebaseAuth auth;
  final GoogleSignIn googleSignIn;

  FirstScreen(
      {@required this.dynamicLink,
      @required this.auth,
      @required this.googleSignIn});

  final ButtonStyle elevatedStyle = ElevatedButton.styleFrom(
      elevation: 5,
      primary: Colors.deepPurple,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)));

  @override
  Widget build(BuildContext context) {
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
                  auth.currentUser.photoURL,
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
                Auth(auth: auth, googleSignIn: googleSignIn).getName(),
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
                auth.currentUser.email,
                style: TextStyle(
                    fontSize: 25,
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  Auth(auth: auth, googleSignIn: googleSignIn).signOutGoogle();
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) {
                    return LoginPage(
                        dynamicLink: dynamicLink,
                        auth: auth,
                        googleSignIn: googleSignIn);
                  }), ModalRoute.withName('/'));
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Sign Out',
                    style: TextStyle(fontSize: 25, color: Colors.white),
                  ),
                ),
                style: elevatedStyle,
              ),
              ElevatedButton(
                onPressed: () async {
                  String url = await DynamicLink(
                          dynamicLink: dynamicLink,
                          auth: auth,
                          googleSignIn: googleSignIn)
                      .createDynamicLink("test", "12345");
                  print(url);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Create Event',
                    style: TextStyle(fontSize: 25, color: Colors.white),
                  ),
                ),
                style: elevatedStyle,
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
                style: elevatedStyle,
              )
            ],
          ),
        ),
      ),
    );
  }
}
