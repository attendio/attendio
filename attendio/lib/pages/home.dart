import 'package:attendio/events.dart';
import 'package:attendio/pages/profile.dart';
import 'package:attendio/pages/checkin.dart';
import 'package:attendio/providers/bottomnav_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Landing page for post successful login
class HomePage extends HookWidget {
  final _views = [
    EventDetailsPage(),
    Profile(),
    CheckIn(),
  ];

  @override
  Widget build(BuildContext context) {
    final tabType = useProvider(tabTypeProvider);
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color(0xFF6A1B9A),
        scaffoldBackgroundColor: Color(0xFFFFFFFF),
      ),
      home: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.shifting,
          selectedItemColor: Colors.white,
          unselectedItemColor: Color(0xFFE6CEFF),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today),
              label: 'Events',
              backgroundColor: Color(0xFF6A1B9A),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.face),
              label: 'Profile',
              backgroundColor: Color(0xFF6A1B9A),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.check),
              label: 'Check In',
              backgroundColor: Color(0xFF6A1B9A),
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
