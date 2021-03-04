import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'event.dart';
import 'login.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FutureBuilder(
          future: Firebase.initializeApp(),
          builder: (context, snapshot) {
            // Check for errors
            if (snapshot.hasError) {
              return const Scaffold(
                body: Center(
                  child: Text("Error"),
                ),
              );
            }

            // Once complete, show login page
            if (snapshot.connectionState == ConnectionState.done) {
              return LoginPage(
                  dynamicLink: FirebaseDynamicLinks.instance,
                  auth: FirebaseAuth.instance,
                  googleSignIn: GoogleSignIn());
            }

            // Otherwise, show that it is loading
            return const Scaffold(
              body: Center(
                child: Text("Loading..."),
              ),
            );
          }),
      routes: {
        '/test': (context) => EventPage(),
      },
    );
  }
}
