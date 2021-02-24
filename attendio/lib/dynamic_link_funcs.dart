import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'signin_funcs.dart';

void initDynamicLinks(context) async {
  FirebaseDynamicLinks.instance.onLink(
      onSuccess: (PendingDynamicLinkData dynamicLink) async {
    final Uri deepLink = dynamicLink?.link;

    handleDeepLink(context, deepLink);
  }, onError: (OnLinkErrorException e) async {
    print('onLinkError');
    print(e.message);
  });

  final PendingDynamicLinkData data =
      await FirebaseDynamicLinks.instance.getInitialLink();

  final Uri deepLink = data?.link;

  handleDeepLink(context, deepLink);
}

void handleDeepLink(context, Uri deepLink) async {
  if (deepLink != null) {
    if (isSignedIn() == false) {
      String result = await signInWithGoogle();
      if (result == null || isSignedIn() == false) {
        throw "Sign-in Error";
      }
    }
    Navigator.pushNamed(context, deepLink.path);
  }
}
