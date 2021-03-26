import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Auth {
  final FirebaseAuth auth;
  final GoogleSignIn googleSignIn;

  Auth({@required this.auth, @required this.googleSignIn});

  // Functions for signing in and out via Google Auth.
  Future<String> signInWithGoogle() async {
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final UserCredential authResult =
        await auth.signInWithCredential(credential);
    final User user = authResult.user;

    if (user != null) {
      // Checking if email and name is null
      assert(user.email != null);
      assert(user.displayName != null);
      assert(user.photoURL != null);

      assert(!user.isAnonymous);
      assert(await user.getIdToken() != null);

      final User currentUser = auth.currentUser;
      assert(user.uid == currentUser.uid);

      print('signInWithGoogle succeeded: $user');

      return '$user';
    }

    return null;
  }

  Future<void> signOutGoogle() async {
    await googleSignIn.signOut();
    await auth.signOut();
  }

  bool isSignedIn() {
    return (auth.currentUser != null) ? true : false;
  }

  String getName() {
    String name = auth.currentUser.displayName;

    // Only taking the first part of the name, i.e., First Name
    return (name.contains(" ")) ? name.substring(0, name.indexOf(" ")) : name;
  }

  String getPhotoURL() {
    return auth.currentUser.photoURL;
  }

  String getEmail() {
    return auth.currentUser.email;
  }
}
