import 'package:attendio/providers/dl_provider.dart';
import 'package:attendio/providers/firestore_provider.dart';
import 'package:attendio/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Login page layout
class CreateEvent extends HookWidget {
  final ButtonStyle createAccountStyle = ElevatedButton.styleFrom(
    elevation: 5,
    primary: Color(0xFF38006B),
  );

  final ButtonStyle submitStyle = ElevatedButton.styleFrom(
    elevation: 5,
    primary: Color(0xFFB39DDB),
  );

  DateTime selectedDate = DateTime.now();

  TextEditingController nameController = new TextEditingController();
  TextEditingController descriptionController = new TextEditingController();
  TextEditingController dateController = new TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime pickedDate = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015),
        lastDate: DateTime(2050));
    if (pickedDate != null && pickedDate != selectedDate)
      // setState(() {
      selectedDate = pickedDate;
    dateController.text = selectedDate.toString();
    // });
  }

  Widget _entryField(String title, controller) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
              controller: controller,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final firestore = useProvider(firestoreProvider);
    final dynamicLink = useProvider(linkServicesProvider);
    final auth = useProvider(firebaseAuthProvider);

    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            children: <Widget>[
              SizedBox(height: 100),
              _entryField("Event Name", nameController),
              // _entryField("Date & Time", dateController),
              _entryField("Description", descriptionController),
              ElevatedButton(
                style: submitStyle,
                onPressed: () => _selectDate(context),
                child: Text('Select date'),
              ),
              ElevatedButton(
                onPressed: () {
                  firestore.collection("Events").add({
                    "event_name": nameController.text,
                    "datetime": dateController.text,
                    "description": descriptionController.text,
                    "owner": auth.currentUser.uid,
                  }).then((value) async {
                    String link =
                        await dynamicLink.createDynamicLink("test", value.id);
                    List<String> attendees = [];
                    value.update({
                      "dyanmic_link": link,
                      "attendees": attendees,
                    });
                    print(value.id);
                  });
                },
                style: submitStyle,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Create Event',
                    style: TextStyle(fontSize: 25, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
