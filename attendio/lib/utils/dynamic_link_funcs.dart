import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:attendio/utils/auth_view_model.dart';

class DynamicLink {
  final FirebaseDynamicLinks dynamicLink;
  final AuthViewModel authService;
  final FirebaseAuth auth;

  DynamicLink(
      {@required this.dynamicLink,
      @required this.authService,
      @required this.auth});

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
      if (auth.currentUser == null) {
        try {
          await authService.signInWithGoogle();
        } catch (e) {
          throw "Sign-in Error";
        }
      }
      Navigator.pushNamed(context, deepLink.path);
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
