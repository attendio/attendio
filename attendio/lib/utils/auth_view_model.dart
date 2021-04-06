import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:attendio/router/router.dart';

class AuthViewModel {
  final FirebaseAuth _auth;
  final AttendioRouterDelegate _delegate;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  AuthViewModel(this._auth, this._delegate);

  Stream<User> get authStateChange => _auth.authStateChanges();

  Future<void> signInWithGoogle() async {
    await Firebase.initializeApp();

    final GoogleSignInAccount googleSignInAccount =
        await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final UserCredential authResult =
        await _auth.signInWithCredential(credential);
    final User user = authResult.user;

    if (user != null) {
      // Checking if email and name is null
      assert(user.email != null);
      assert(user.displayName != null);
      assert(user.photoURL != null);

      assert(!user.isAnonymous);
      assert(await user.getIdToken() != null);

      final User currentUser = _auth.currentUser;
      assert(user.uid == currentUser.uid);
      _delegate.userState = _auth.currentUser;

      // print('signInWithGoogle succeeded: $user');
    }

    return null;
  }

  Future<void> signOutGoogle() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
    _delegate.userState = null;

    print("User Signed Out");
  }
}
