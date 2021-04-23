import 'package:attendio/utils/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TakeAttendancePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              Strings.signInTo.toUpperCase(),
              style: Theme.of(context).textTheme.headline5,
            ),
            Text(
              "Event Title", //TODO update with loaded content
              style: Theme.of(context).textTheme.headline3,
            ),
            Text(
              Strings.instructionsTitle,
              style: Theme.of(context).textTheme.subtitle1,
            ),
            Text(
              Strings.instructionsBodyText1,
              style: Theme.of(context).textTheme.bodyText1,
            ),
            Text(
              Strings.instructionsBodyText1,
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ],
        ),
      )
    );
  }

}