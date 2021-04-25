import 'package:attendio/events.dart';
import 'package:attendio/pages/check_in_screen.dart';
import 'package:attendio/providers/auth_provider.dart';
import 'package:barcode_scan_fix/barcode_scan.dart';
import 'package:attendio/providers/bottomnav_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'landing.dart';
import 'create_event.dart';
import 'test.dart';

// Landing page for post successful login
class HomePage extends HookWidget {
  final _views = [
    EventDetailsPage(),
    LandingPage(),
    PlaceholderWidget(Colors.amber),
  ];

  @override
  Widget build(BuildContext context) {
    final tabType = useProvider(tabTypeProvider);
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.white),
      home: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.shifting,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today),
              label: 'Events',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.face),
              label: 'Profile',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.check),
              label: 'Check In',
            ),
          ],
          onTap: (int selectIndex) {
            tabType.state = TabType.values[selectIndex];
          },
          currentIndex: tabType.state.index,
        ),
        body: _views[tabType.state.index],
      ),
    );
  }
}
