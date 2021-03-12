import 'package:attendio/event.dart';
import 'package:attendio/landing.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mockito/mockito.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockUser extends Mock implements User {}

class MockGoogleSignIn extends Mock implements GoogleSignIn {}

class MockFirebaseDynamicLinks extends Mock implements FirebaseDynamicLinks {}

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

class MockPendingDynamicLinkData extends Mock
    implements PendingDynamicLinkData {}

void main() {
  final MockFirebaseAuth mockFirebaseAuth = MockFirebaseAuth();
  final MockGoogleSignIn mockGoogleSignIn = MockGoogleSignIn();
  final MockFirebaseDynamicLinks mockFirebaseDynamicLinks =
      MockFirebaseDynamicLinks();
  final mockObserver = MockNavigatorObserver();
  final mockUser = MockUser();
  final mockData = MockPendingDynamicLinkData();
  final linkUri = Uri.parse("https://www.example.com/test");

  setUp(() {});

  tearDown(() {
    reset(mockFirebaseAuth);
    reset(mockGoogleSignIn);
    reset(mockFirebaseDynamicLinks);
    reset(mockObserver);
  });

  testWidgets("Dynamic Links Signed In Test", (WidgetTester tester) async {
    // Code thinks there is a valid user signed in
    when(mockFirebaseAuth.currentUser).thenReturn(mockUser);

    // Code thinks a dynamic link launched the app
    when(mockData.link).thenReturn(linkUri);
    when(mockFirebaseDynamicLinks.getInitialLink())
        .thenAnswer((realInvocation) => Future.value(mockData));

    // Load LandingPage
    await tester.pumpWidget(MaterialApp(
      home: LandingPage(
          dynamicLink: mockFirebaseDynamicLinks,
          auth: mockFirebaseAuth,
          googleSignIn: mockGoogleSignIn),
      navigatorObservers: [mockObserver],
      routes: {
        '/test': (context) => EventPage(),
      },
    ));

    //Make sure functions were called and page was pushed
    verify(mockFirebaseAuth.currentUser).called(1);
    verify(mockData.link).called(1);
    verify(mockFirebaseDynamicLinks.getInitialLink()).called(1);
    verify(mockObserver.didPush(any, any));
  });
}
