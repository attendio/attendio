import 'event.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DataRepository {
  final CollectionReference collection = FirebaseFirestore.instance.collection('Events');

  Stream<QuerySnapshot> getStream() {
    return collection.snapshots();
  }

  Future<DocumentReference> addEvent(Event event) {
    return collection.add(event.toJson());
  }

  updateEvent(Event event) async {
    await collection.doc(event.reference.id).update(event.toJson());
  }
}