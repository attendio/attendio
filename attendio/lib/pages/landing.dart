import 'package:attendio/providers/auth_provider.dart';
import 'package:attendio/providers/dl_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'home.dart';

// Login page layout
class LandingPage extends HookWidget {
  final ButtonStyle loginStyle = ElevatedButton.styleFrom(
    elevation: 5,
    primary: Color(0xFFB39DDB),
  );

  final ButtonStyle signupStyle = ElevatedButton.styleFrom(
    elevation: 5,
    primary: Color(0xFFB39DDB),
  );

  @override
  Widget build(BuildContext context) {
    final dynamicLink = useProvider(linkServicesProvider);
    dynamicLink.initDynamicLinks(context);
    return Scaffold(
      body: CustomPaint(
        painter: BackgroundPainter(),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 150),
              //FlutterLogo(size: 150),
              Image.asset('assets/icon/icon.png',
                  height: 150, width: 150, scale: 0.3),
              SizedBox(height: 100),
              // ElevatedButton(
              //   onPressed: () {
              //     Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //             builder: (context) => LoginPage(
              //                 dynamicLink: widget.dynamicLink,
              //                 auth: widget.auth,
              //                 googleSignIn: widget.googleSignIn)));
              //   },
              //   style: loginStyle,
              //   child: Padding(
              //     padding: const EdgeInsets.all(8.0),
              //     child: Text(
              //       'Have account? Login',
              //       style: TextStyle(fontSize: 25, color: Colors.white),
              //     ),
              //   ),
              // ),
              SizedBox(height: 15),
              _signInButton(context),
              SizedBox(height: 15),
              // ElevatedButton(
              //   onPressed: () {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(builder: (context) => SignupPage()),
              //     );
              //   },
              //   style: signupStyle,
              //   child: Padding(
              //     padding: const EdgeInsets.all(8.0),
              //     child: Text(
              //       'Sign Up',
              //       style: TextStyle(fontSize: 25, color: Colors.white),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _signInButton(BuildContext context) {
    final auth = useProvider(authServicesProvider);

    final ButtonStyle outlinedStyle = ElevatedButton.styleFrom(
      elevation: 5,
      primary: Color(0xFFB39DDB),
    );

    return OutlinedButton(
      onPressed: () {
        auth.signInWithGoogle().then((result) {
          if (result != null) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return HomePage();
                },
              ),
            );
          }
        });
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(image: AssetImage("assets/google_logo.png"), height: 35.0),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Sign in with Google',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
      style: outlinedStyle,
    );
  }
}

// https://www.youtube.com/watch?v=u96GgqHFy3c
class BackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final height = size.height;
    final width = size.width;
    Paint paint = Paint();

    Path mainBackground = Path();
    mainBackground.addRect(Rect.fromLTRB(0, 0, width, height));
    paint.color = Color(0xFF6A1B9A);
    canvas.drawPath(mainBackground, paint);

    final p1 = Offset(0, height * 2);
    final p2 = Offset(width * 1.5, height * 0.5);
    Paint paint2 = Paint()
      ..color = Color(0xFFB39DDB)
      ..strokeWidth = 400;
    canvas.drawLine(p1, p2, paint2);

    final p3 = Offset(-150, height * 0.8);
    final p4 = Offset(width, height * 1.2);
    Paint paint3 = Paint()
      ..color = Color(0xFFFFFFFF)
      ..strokeWidth = 400;
    canvas.drawLine(p3, p4, paint3);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}
