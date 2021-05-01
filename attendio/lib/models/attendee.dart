import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Attendee {
  String uid;
  String displayName;
  String photoURL;
  DateTime datetime;
  DocumentReference reference;

  Attendee(this.uid, {this.displayName, this.photoURL, this.datetime});

  factory Attendee.fromCurrentUser() {
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;
    return Attendee(user.uid,
        displayName: user.displayName,
        photoURL: user.photoURL,
        datetime: DateTime.now());
  }

  factory Attendee.fromSnapshot(DocumentSnapshot snapshot) {
    Attendee newAttendee = Attendee.fromJson(snapshot.data());
    newAttendee.reference = snapshot.reference;
    return newAttendee;
  }

  factory Attendee.fromJson(Map<dynamic, dynamic> json) =>
      _attendeeFromJson(json);
}

_attendeeFromJson(Map<dynamic, dynamic> json) {
  return Attendee(
    json['uid'] as String,
    displayName: json['displayName'] as String,
    photoURL: json['photoURL'] == null ? null : (json['photoURL'] as String),
    datetime: json['datetime'] == null
        ? null
        : (json['dateTime'] as Timestamp)?.toDate() ?? null,
  );
}

extension JsonEncoding on Attendee {
  Map<String, dynamic> toJson() => <String, dynamic>{
        'uid': this.uid,
        'displayName': this.displayName,
        'photoURL': this.photoURL,
        'datetime': this.datetime,
      };
}
