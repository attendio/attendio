import 'package:attendio/models/attendee.dart';
import 'package:attendio/models/event.dart';
import 'package:attendio/utils/strings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:qr_flutter/qr_flutter.dart';

class TakeAttendancePage extends StatelessWidget {
  TakeAttendancePage(this.eventId);

 final DocumentReference eventId;

  @override
  Widget build(BuildContext context) {
    var isLargeScreen = false;
    var minScreenWidth = 600;

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

              return OrientationBuilder(builder: (context, orientation)
              {
                isLargeScreen = (MediaQuery
                    .of(context)
                    .size
                    .width > minScreenWidth);
                return Row(children: [
                  Expanded(
                    child: EventSignInWidget(event),
                    flex: 3,
                  ),
                  // Hide attendee list on mobile / small screens
                  // TODO make it a DraggableScrollableWidget instead
                  isLargeScreen ? Expanded(child: AttendeeList(eventId)) : Container(),
                ]);
              });
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ));
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
            textAlign: TextAlign.center,
          ),
          Text(
            event.event_name,
            style: Theme.of(context).textTheme.headline3,
            textAlign: TextAlign.center,
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
            textAlign: TextAlign.center,
          ),
          Text(
            Strings.instructionsBodyText1,
            style: Theme.of(context).textTheme.bodyText1,
            textAlign: TextAlign.center,
          ),
          Text(
            Strings.instructionsBodyText2,
            style: Theme.of(context).textTheme.bodyText1,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class AttendeeList extends HookWidget {
  AttendeeList(this.attendeeReference);

  DocumentReference attendeeReference;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: attendeeReference.collection('attendees').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          QuerySnapshot querySnapshot = snapshot.data;

          return ListView.builder(
              itemCount: querySnapshot.size,
              itemBuilder: (context, index) =>
                  _buildAttendeeListItem(querySnapshot.docs[index], index));
        }

        if (snapshot.hasError) {
          return Center(child: Text(snapshot.error.toString()));
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget _buildAttendeeListItem(snapshot, index) {
    final attendee = Attendee.fromSnapshot(snapshot);
    return Card(
        child: InkWell(
      child: ListTile(
        title: Text(attendee.displayName),
        leading: CircleAvatar(
            backgroundImage: Image.network(attendee.photoURL).image),
        // subtitle: Text(attendee.datetime.toString()),
      ),
    ));
  }
}
