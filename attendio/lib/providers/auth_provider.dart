import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../utils/signin_funcs.dart';

final firebaseAuthProvider =
    Provider<FirebaseAuth>((ref) => FirebaseAuth.instance);

final googleAuthProvider = Provider<GoogleSignIn>((ref) => GoogleSignIn());

final authServicesProvider = Provider<Auth>((ref) => Auth(
    auth: ref.read(firebaseAuthProvider),
    googleSignIn: ref.read(googleAuthProvider)));
