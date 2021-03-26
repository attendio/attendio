import 'package:attendio/utils/dynamic_link_funcs.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'auth_provider.dart';

final firebaseLinkProvider =
    Provider<FirebaseDynamicLinks>((ref) => FirebaseDynamicLinks.instance);

final linkServicesProvider = Provider<DynamicLink>((ref) => DynamicLink(
    dynamicLink: ref.read(firebaseLinkProvider),
    auth: ref.read(authServicesProvider)));
