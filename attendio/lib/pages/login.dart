import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../utils/styles.dart';

// Login page layout
class LoginPage extends StatefulWidget {
  final FirebaseDynamicLinks dynamicLink;
  final FirebaseAuth auth;
  final GoogleSignIn googleSignIn;

  LoginPage(
      {@required this.dynamicLink,
      @required this.auth,
      @required this.googleSignIn});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomPaint(
        painter: BackgroundPainter(),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 50),
              RichText(
                text: TextSpan(
                  text: 'Login',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 150),
              FlutterLogo(size: 150),
              SizedBox(height: 50),
            ],
          ),
        ),
      ),
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
    paint.color = colors['primary'];
    canvas.drawPath(mainBackground, paint);

    final p1 = Offset(0, height * 2);
    final p2 = Offset(width * 1.5, height * 0.5);
    Paint paint2 = Paint()
      ..color = colors['light_purple']
      ..strokeWidth = 400;
    canvas.drawLine(p1, p2, paint2);

    final p3 = Offset(-150, height * 0.8);
    final p4 = Offset(width, height * 1.2);
    Paint paint3 = Paint()
      ..color = Colors.white
      ..strokeWidth = 400;
    canvas.drawLine(p3, p4, paint3);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}
