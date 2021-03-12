import 'package:cloud_firestore/cloud_firestore.dart';

/// Data model for an Event specified in the Firestore.
/// Includes name and details about each event.
///
/// Implementation reference: https://www.raywenderlich.com/7426050-firebase-tutorial-for-flutter-getting-started
class Event {
  String event_name;
  String description;
  String username;
  DateTime datetime;
  String dyanmic_link;

  DocumentReference reference;

  Event(this.event_name, {this.description, this.username, this.datetime, this.dyanmic_link});
  
  factory Event.fromSnapshot(DocumentSnapshot snapshot) {
    Event newEvent = Event.fromJson(snapshot.data());
    newEvent.reference = snapshot.reference;
    return newEvent;
  }

  factory Event.fromJson(Map<dynamic, dynamic> json) => _EventFromJson(json);

  Map<String, dynamic> toJson() => _EventToJson(this);

  @override
  String toString() => "Event<$event_name>";
}

Event _EventFromJson(Map<dynamic, dynamic> json) {
  return Event(
    json['event_name'] as String,
    description: json['description'] as String,
    username: json['username'] as String,
    datetime: json['dateTime'] == null ? null : (json['dateTime'] as Timestamp).toDate(),
    dyanmic_link: json['dyanmic_link'] as String,
  );
}

Map<String, dynamic> _EventToJson(Event instance) =>
    <String, dynamic> {
      'event_name': instance.event_name,
      'description': instance.description,
      'username': instance.username,
      'datetime': instance.datetime,
      'dynamic_link': instance.dyanmic_link,
    };