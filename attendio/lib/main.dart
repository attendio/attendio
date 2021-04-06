import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:attendio/providers/router_provider.dart';
import 'package:attendio/utils/styles.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(ProviderScope(child: NavApp()));
}

class NavApp extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final delegate = useProvider(delegateProvider);
    final parser = useProvider(routeParserProvider);
    return MaterialApp.router(
      theme: globalTheme,
      routerDelegate: delegate,
      routeInformationParser: parser,
    );
  }
}

// class App extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: FutureBuilder(
//           future: Firebase.initializeApp(),
//           builder: (context, snapshot) {
//             // Check for errors
//             if (snapshot.hasError) {
//               return const Scaffold(
//                 body: Center(
//                   child: Text("Error"),
//                 ),
//               );
//             }

//             // Once complete, show login page
//             if (snapshot.connectionState == ConnectionState.done) {
//               return LandingPage();
//             }

//             // Otherwise, show that it is loading
//             return const Scaffold(
//               body: Center(
//                 child: Text("Loading..."),
//               ),
//             );
//           }),
//       routes: {
//         '/test': (context) => EventScreen(),
//       },
//     );
//   }
// }
