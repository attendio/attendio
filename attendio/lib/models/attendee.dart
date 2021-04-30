import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Attendee {
  String uid;
  String displayName;
  String photoURL;
  DateTime datetime;

  Attendee(this.uid, {this.displayName, this.photoURL, this.datetime});

  factory Attendee.fromCurrentUser() {
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;
    return Attendee(user.uid, displayName: user.displayName, photoURL: user.photoURL, datetime: DateTime.now());
  }

  factory Attendee.fromJson(Map<dynamic, dynamic> json) => _attendeeFromJson(json);
}

_attendeeFromJson(Map<dynamic, dynamic> json) {
  return Attendee(
    json['uid'] as String,
    displayName: json['displayName'] as String,
    photoURL: json['photoURL'] == null ? null : (json['photoURL'] as String),
    datetime: json['datetime'] == null ? null : (json['dateTime'] as Timestamp).toDate(),
  );
}

Map<String, dynamic> _attendeeToJson(Attendee instance) => <String, dynamic> {
  'uid': instance.uid,
  'displayName': instance.displayName,
  'photoURL': instance.photoURL,
  'datetime': instance.datetime,
};