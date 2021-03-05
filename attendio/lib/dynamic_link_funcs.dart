import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'signin_funcs.dart';

class DynamicLink {
  final FirebaseDynamicLinks dynamicLink;
  final FirebaseAuth auth;
  final GoogleSignIn googleSignIn;

  DynamicLink(
      {@required this.dynamicLink,
      @required this.auth,
      @required this.googleSignIn});

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
      if (Auth(auth: auth, googleSignIn: googleSignIn).isSignedIn() == false) {
        String result = await Auth(auth: auth, googleSignIn: googleSignIn)
            .signInWithGoogle();
        if (result == null ||
            Auth(auth: auth, googleSignIn: googleSignIn).isSignedIn() ==
                false) {
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
