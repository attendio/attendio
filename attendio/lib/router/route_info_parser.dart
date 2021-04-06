import 'package:attendio/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:attendio/router/route_config.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AttendioRouteInfoParser extends RouteInformationParser<AttendioConfig> {
  @override
  Future<AttendioConfig> parseRouteInformation(
      RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.location);
    final container = ProviderContainer();

    switch (uri.pathSegments.length) {
      case 0:
        {
          return AttendioConfig.home(
              container.read(firebaseAuthProvider).currentUser);
        }
      case 1:
        {
          final first = uri.pathSegments[0].toLowerCase();
          switch (first) {
            case "home":
              return AttendioConfig.home(
                  container.read(firebaseAuthProvider).currentUser);
            case "login":
              return AttendioConfig.login();
          }
          return AttendioConfig.unknown(
              container.read(firebaseAuthProvider).currentUser);
        }
      default:
        {
          return AttendioConfig.unknown(
              container.read(firebaseAuthProvider).currentUser);
        }
    }
  }
}
