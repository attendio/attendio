import 'package:attendio/models/dataRepository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'models/event.dart';

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
        onTap: widget.onItemSelected(position),
      ),
    );
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
          Text(widget.eventTitle, style: Theme.of(context).textTheme.headline2),
        ])));
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
    return Scaffold(
      appBar: AppBar(),
      body: OrientationBuilder(builder: (context, orientation) {
        isLargeScreen =
            (MediaQuery.of(context).size.width > widget.minScreenWidth);

        return Row(children: [
          Expanded(
            child: EventList(6, (value) {
              if (isLargeScreen) {
                selectedValue = value;
                //setState(() {});
              } else {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return SmallDetailPage("Event Title");
                  },
                ));
              }
            }),
          ),
          isLargeScreen
              ? Expanded(child: EventDetail("Event Title"), flex: 3)
              : Container(),
        ]);
      }),
    );
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
    return Scaffold(appBar: AppBar(), body: EventDetail(widget.eventTitle));
  }
}
