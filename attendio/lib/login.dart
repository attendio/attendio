import 'package:flutter/material.dart';
import 'dynamic_link_funcs.dart';
import 'signin_funcs.dart';
import 'home.dart';
import 'package:attendio/utils/styles.dart';

// Login page layout
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();
    initDynamicLinks(context);
  }

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
              SizedBox(height: 150),
              FlutterLogo(size: 150),
              SizedBox(height: 100),
              _signInButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _signInButton() {
    final ButtonStyle outlinedStyle = ButtonStyle(
        elevation: MaterialStateProperty.resolveWith<double>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.pressed)) return 0;
          return null;
        }),
        overlayColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.pressed)) return Colors.grey;
          return null;
        }),
        shape: MaterialStateProperty.all<OutlinedBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(40))),
        side: MaterialStateProperty.resolveWith<BorderSide>(
            (Set<MaterialState> states) {
          return BorderSide(color: Colors.grey);
        }));

    return OutlinedButton(
      onPressed: () {
        signInWithGoogle().then((result) {
          if (result != null) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return FirstScreen();
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
                  color: Colors.grey,
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
