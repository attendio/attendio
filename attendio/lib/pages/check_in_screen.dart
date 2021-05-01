import 'package:attendio/models/attendee.dart';
import 'package:attendio/models/event.dart';
import 'package:attendio/providers/auth_provider.dart';
import 'package:attendio/providers/firestore_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CheckInScreen extends HookWidget {
  final eventId;

  CheckInScreen(this.eventId);

  @override
  Widget build(BuildContext context) {
    final firestore = useProvider(firestoreProvider);
    final auth = useProvider(firebaseAuthProvider);

    return StreamBuilder(
      stream: firestore.collection("Events").doc(eventId).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text(snapshot.error.toString()));
        }

        DocumentSnapshot docSnapshot = snapshot.data;
        Event event = Event.fromSnapshot(docSnapshot);
        DocumentReference docReference = docSnapshot.reference;

        if (auth.currentUser?.uid != null) {
          final attendee = Attendee.fromCurrentUser();

          // Add document using User ID as the document ID to prevent
          // duplicate entries for the same attendee.
          docReference
              .collection("attendees")
              .doc(attendee.uid)
              .set(attendee.toJson());
        }

        return MaterialApp(
          home: Scaffold(
              body: Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                Text(
                  event.event_name ?? "No Event Name",
                  style: Theme.of(context).textTheme.headline2,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20.0),
                Image.asset(
                  'assets/icon/check.png',
                  width: 200,
                  height: 200,
                ),
                SizedBox(height: 20.0),
                Text(
                  "Successfully Checked In",
                  style: Theme.of(context).textTheme.headline5,
                  textAlign: TextAlign.center,
                ),
              ]))),
        );
      },
    );
  }
}
