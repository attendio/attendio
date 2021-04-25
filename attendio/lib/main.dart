import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'pages/event.dart';
import 'pages/landing.dart';

void main() {
  runApp(ProviderScope(child: App()));
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
              return LandingPage();
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
