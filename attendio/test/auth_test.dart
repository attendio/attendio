import 'package:attendio/utils/signin_funcs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mockito/mockito.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockGoogleSignIn extends Mock implements GoogleSignIn {}

void main() {
  final MockFirebaseAuth mockFirebaseAuth = MockFirebaseAuth();
  final MockGoogleSignIn mockGoogleSignIn = MockGoogleSignIn();

  setUp(() {});

  tearDown(() {
    reset(mockFirebaseAuth);
    reset(mockGoogleSignIn);
  });

  test("Sign Out Test", () async {
    // Sign out of Google
    await Auth(auth: mockFirebaseAuth, googleSignIn: mockGoogleSignIn)
        .signOutGoogle();

    // Check to make sure all instances are signed out
    verify(mockFirebaseAuth.signOut()).called(1);
    verify(mockGoogleSignIn.signOut()).called(1);
  });
}
