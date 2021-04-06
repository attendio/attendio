import 'package:attendio/providers/router_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:attendio/utils/auth_view_model.dart';

final firebaseAuthProvider =
    Provider<FirebaseAuth>((ref) => FirebaseAuth.instance);

final googleAuthProvider = Provider<GoogleSignIn>((ref) => GoogleSignIn());

final authServicesProvider = Provider<AuthViewModel>((ref) =>
    AuthViewModel(ref.read(firebaseAuthProvider), ref.read(delegateProvider)));

final authStateChangesProvider = StreamProvider.autoDispose<User>(
    (ref) => ref.watch(firebaseAuthProvider).authStateChanges());
