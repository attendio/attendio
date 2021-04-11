import 'package:attendio/pages/check_in_screen.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'signin_funcs.dart';

class DynamicLink {
  final FirebaseDynamicLinks dynamicLink;
  final Auth auth;

  DynamicLink({@required this.dynamicLink, @required this.auth});

  // Checks if app was launched through dynamic link and routes accordingly
  void initDynamicLinks(context) async {
    dynamicLink.onLink(onSuccess: (PendingDynamicLinkData dynamicLink) async {
      final Uri deepLink = dynamicLink?.link;

      handleDeepLink(context, deepLink);
    }, onError: (OnLinkErrorException e) async {
      print('onLinkError');
      print(e.message);
    });

    final PendingDynamicLinkData data = await dynamicLink.getInitialLink();

    final Uri deepLink = data?.link;

    handleDeepLink(context, deepLink);
  }

  // Extracts path from deeplink and goes to window
  void handleDeepLink(context, Uri deepLink) async {
    if (deepLink != null) {
      if (auth.isSignedIn() == false) {
        String result = await auth.signInWithGoogle();
        if (result == null || auth.isSignedIn() == false) {
          throw "Sign-in Error";
        }
      }
      var eventId = deepLink.pathSegments.last;
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CheckInScreen(eventId)),
      );
    }
  }

  // Creates dynamic link
  Future<String> createDynamicLink(String username, String eventId) async {
    final DynamicLinkParameters parameters = DynamicLinkParameters(
        uriPrefix: 'https://attendio.page.link/',
        link: Uri.parse('https://www.example.com/$username/$eventId'),
        androidParameters: AndroidParameters(
          packageName: 'com.example.attendio',
        ));

    final Uri dynamicUrl = await parameters.buildUrl();

    return dynamicUrl.toString();
  }
}
