import 'package:attendio/models/dataRepository.dart';
import 'package:attendio/pages/create_event.dart';
import 'package:attendio/pages/take_attendance.dart';
import 'package:attendio/utils/share_funcs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'models/event.dart';
import 'package:fluttertoast/fluttertoast.dart';

/// Page showing the list of events created by the user,
/// along with details for each event when selected.
/// References:
///   - https://iiro.dev/implementing-adaptive-master-detail-layouts/
///   - https://medium.com/flutter-community/developing-for-multiple-screen-sizes-and-orientations-in-flutter-fragments-in-flutter-a4c51b849434

/// Displays a list of events scheduled
class EventList extends StatefulWidget {
  final ValueChanged<Event> onItemSelected;

  EventList({@required this.onItemSelected});

  @override
  _EventListState createState() => _EventListState();
}

class _EventListState extends State<EventList> {
  final DataRepository repository = DataRepository();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: repository.getStream(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text(snapshot.error.toString()));
        }

        QuerySnapshot querySnapshot = snapshot.data;

        return ListView.builder(
            itemCount: querySnapshot.size,
            itemBuilder: (context, index) =>
                _buildEventListItem(querySnapshot.docs[index], index));
      },
    );
  }

  Widget _buildEventListItem(snapshot, position) {
    final event = Event.fromSnapshot(snapshot);
    return Card(
      child: InkWell(
        child: ListTile(
          title: Text(event.event_name),
        ),
        onTap: () => widget.onItemSelected(event),
      ),
    );
  }
}

/// Displays the details for the event selected on the EventList
class EventDetail extends StatefulWidget {
  final Event event;
  //TODO add Event model item as data

  EventDetail(this.event);

  @override
  _EventDetailState createState() => _EventDetailState();
}

class _EventDetailState extends State<EventDetail> {
  GlobalKey globalKey = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
          Text(
            widget.event?.event_name ?? "No name",
            style: Theme.of(context).textTheme.headline2,
            textAlign: TextAlign.center,
          ),
          Text(
            widget.event?.description ?? "",
            style: Theme.of(context).textTheme.headline5,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20.0),
          RepaintBoundary(
            key: globalKey,
            child: QrImage(
              data: widget.event?.dyanmic_link ??
                  "https://www.youtube.com/watch?v=dQw4w9WgXcQ",
              version: QrVersions.auto,
              size: 200.0,
              backgroundColor: Colors.white,
            ),
          ),
          SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          TakeAttendancePage(widget.event.reference)));
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Take Attendance',
                style: TextStyle(fontSize: 25, color: Colors.white),
              ),
            ),
          ),
          SizedBox(height: 20.0),
          OutlinedButton(
            onPressed: () {
              captureAndSharePng(globalKey);
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Share Image',
                style: TextStyle(fontSize: 25),
              ),
            ),
          ),
          SizedBox(height: 20.0),
          OutlinedButton(
            onPressed: () {
              shareText(widget.event?.dyanmic_link ?? "No link");
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Share Link',
                style: TextStyle(fontSize: 25),
              ),
            ),
          ),
        ])));
  }
}

class EventDetailsPage extends StatefulWidget {
  final minScreenWidth = 600;

  @override
  _EventDetailsPageState createState() => _EventDetailsPageState();
}

class _EventDetailsPageState extends State<EventDetailsPage> {
  Event selectedEvent;
  var isLargeScreen = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Attendio"),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {
                print("here");
                Fluttertoast.showToast(
                    msg: "Feature to be added",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    textColor: Colors.black,
                    fontSize: 16.0);
              },
              child: Icon(
                Icons.search,
                size: 26.0,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CreateEvent()),
                );
              },
              child: Icon(Icons.add),
            ),
          ),
        ],
      ),
      body: OrientationBuilder(builder: (context, orientation) {
        isLargeScreen =
            (MediaQuery.of(context).size.width > widget.minScreenWidth);

        return Row(children: [
          Expanded(
            child: EventList(onItemSelected: (event) {
              if (isLargeScreen) {
                setState(() {
                  selectedEvent = event;
                });
              } else {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return MobileEventDetailPage(event);
                  },
                ));
              }
            }),
          ),
          isLargeScreen
              ? Expanded(child: EventDetail(selectedEvent), flex: 3)
              : Container(),
        ]);
      }),
    );
  }
}

class MobileEventDetailPage extends StatefulWidget {
  final Event event;

  MobileEventDetailPage(this.event);

  @override
  _MobileEventDetailPageState createState() => _MobileEventDetailPageState();
}

class _MobileEventDetailPageState extends State<MobileEventDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(), body: EventDetail(widget.event));
  }
}
