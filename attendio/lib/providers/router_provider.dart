import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:attendio/router/router.dart';
import 'package:attendio/providers/auth_provider.dart';

final delegateProvider =
    ChangeNotifierProvider.autoDispose<AttendioRouterDelegate>(
        (ref) => AttendioRouterDelegate(ref.watch(firebaseAuthProvider)));

final routeParserProvider =
    Provider<AttendioRouteInfoParser>((ref) => AttendioRouteInfoParser());
