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
  final ItemSelectedCallback onItemSelected;

  EventList(
    {@required this.onItemSelected}
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
        onTap: () => widget.onItemSelected(position),
      ),
    );
  }
}

/// Displays the details for the event selected on the EventList
class EventDetail extends StatefulWidget {
  final String eventTitle;
  //TODO add Event model item as data

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
  var selectedValue;
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
            child: EventList(onItemSelected: (value) {
              if (isLargeScreen) {
                //setState(() { selectedValue = value; });
              } else {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return MobileEventDetailPage("Event Title");
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

class MobileEventDetailPage extends StatefulWidget {
  final String eventTitle;

  MobileEventDetailPage(this.eventTitle);

  @override
  _MobileEventDetailPageState createState() => _MobileEventDetailPageState();
}

class _MobileEventDetailPageState extends State<MobileEventDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(), body: EventDetail(widget.eventTitle));
  }
}
