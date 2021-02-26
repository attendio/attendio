import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Page showing the list of events created by the user,
/// along with details for each event when selected.

typedef Null ItemSelectedCallback(int value);

/// Displays a list of events scheduled
class EventList extends StatefulWidget {
  final int count;
  final ItemSelectedCallback onItemSelected;

  EventList(
      this.count,
      this.onItemSelected,
  );

  @override
  _EventListState createState() => _EventListState();
}

class _EventListState extends State<EventList> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: _getEventListTiles(context),
    );
  }

  List<Widget> _getEventListTiles(BuildContext context) {
    //TODO construct Event List Tiles dynamically from Firestore
    //TODO Will also need to implement onItemSelected for each

    return [
      Card(child: ListTile(title: Text('Event #1'))),
      Card(child: ListTile(title: Text('Event #2'))),
      Card(child: ListTile(title: Text('Event #3'))),
      Card(child: ListTile(title: Text('Event #4'))),
      Card(child: ListTile(title: Text('Event #5'))),
      Card(child: ListTile(title: Text('Event #6'))),
    ];
  }
}

/// Displays the details for the event selected on the EventList
class EventDetail extends StatefulWidget {

  final String eventTitle;

  EventDetail(this.eventTitle);

  @override
  _EventDetailState createState() => _EventDetailState();
}

class _EventDetailState extends State<EventDetail> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(widget.eventTitle, style: Theme.of(context).textTheme.headline1),
          ]
        )
      )
    );
  }
}

class EventDetailsPage extends StatefulWidget {
  final minScreenWidth = 600;

  @override
  _EventDetailsPageState createState() => _EventDetailsPageState();
}

class _EventDetailsPageState extends State<EventDetailsPage> {
  var selectedValue = 0;
  var isLargeScreen = false;
  
  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(builder: (context, orientation ) {

      isLargeScreen = (MediaQuery.of(context).size.width > widget.minScreenWidth);

      return Row(children: [
        Expanded(
          child: EventList(6, (value) {
            if (isLargeScreen) {
              selectedValue = value;
              setState(() {});
            } else {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return SmallDetailPage("Event Title");
                },
              ));
            }
          }),
        ),
        isLargeScreen ? Expanded(
        child: EventDetail("Event Title"),
          flex: 3)
        : Container(),
      ]);
    });
  }
}

class SmallDetailPage extends StatefulWidget {
  final String eventTitle;

  SmallDetailPage(this.eventTitle);

  @override
  _SmallDetailPageState createState() => _SmallDetailPageState();
}

class _SmallDetailPageState extends State<SmallDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: EventDetail(widget.eventTitle)
    );
  }
}