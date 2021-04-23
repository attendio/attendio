import 'package:attendio/models/event.dart';
import 'package:attendio/providers/firestore_provider.dart';
import 'package:attendio/utils/strings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qr_flutter/qr_flutter.dart';

class TakeAttendancePage extends StatelessWidget {
  TakeAttendancePage(this.eventId);

  final DocumentReference eventId;

  @override
  Widget build(BuildContext context) {
    // final firestore = useProvider(firestoreProvider);

    return Scaffold(
      appBar: AppBar(),
        body: FutureBuilder<DocumentSnapshot>(
          future: eventId.get(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            }

            if (snapshot.hasData) {
              DocumentSnapshot documentSnapshot = snapshot.data;
              Event event = Event.fromSnapshot(documentSnapshot);

              return EventSignInWidget(event);
            }

            else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        )
    );
  }
}

class EventSignInWidget extends StatelessWidget {
    EventSignInWidget(this.event);

    final Event event;
    GlobalKey globalKey = new GlobalKey();

    @override
    Widget build(BuildContext context) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              Strings.signInTo.toUpperCase(),
              style: Theme.of(context).textTheme.headline5,
            ),
            Text(
              event.event_name,
              style: Theme.of(context).textTheme.headline3,
            ),
            RepaintBoundary(
              key: globalKey,
              child: QrImage(
                data: event.dyanmic_link ??
                    "https://www.youtube.com/watch?v=dQw4w9WgXcQ",
                version: QrVersions.auto,
                size: 400.0,
                backgroundColor: Colors.white,
              ),
            ),
            Text(
              Strings.instructionsTitle,
              style: Theme.of(context).textTheme.subtitle1,
            ),
            Text(
              Strings.instructionsBodyText1,
              style: Theme.of(context).textTheme.bodyText1,
            ),
            Text(
              Strings.instructionsBodyText2,
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ],
        ),
      );
    }
}