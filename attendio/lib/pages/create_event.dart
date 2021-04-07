import 'package:attendio/providers/dl_provider.dart';
import 'package:attendio/providers/firestore_provider.dart';
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
    TextEditingController nameController = new TextEditingController();
    TextEditingController dateController = new TextEditingController();
    TextEditingController descriptionController = new TextEditingController();

    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            children: <Widget>[
              SizedBox(height: 100),
              _entryField("Event Name", nameController),
              _entryField("Date & Time", dateController),
              _entryField("Description", descriptionController),
              ElevatedButton(
                onPressed: () {
                  print(nameController.text);
                  print(dateController.text);
                  print(descriptionController.text);
                  firestore.collection("Events").add({
                    "event_name": nameController.text,
                    "datetime": dateController.text,
                    "description": descriptionController.text,
                  }).then((value) async {
                    String link =
                        await dynamicLink.createDynamicLink("test", value.id);
                    value.update({"dyanmic_link": link});
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
