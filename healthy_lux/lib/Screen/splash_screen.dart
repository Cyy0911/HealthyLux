import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:healthy_lux/Preferences/app_theme.dart';
import 'package:healthy_lux/Screen/start.dart';

import 'home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  double _opacity = 0;

  checkAuthentication() async {
    _auth.authStateChanges().listen((user) {
      if (user != null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const Home()));
      } else {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const Start()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TweenAnimationBuilder(
              onEnd: () {
                _opacity = 1;
                setState(() {});
              },
              curve: Curves.bounceInOut,
              tween: Tween<double>(begin: 100, end: 200),
              duration: const Duration(seconds: 2),
              builder: (BuildContext context, dynamic value, Widget? child) {
                return Text('Healthy Lux',
                    style: AppTheme.defaultTextStyle50Black(true));
              },
            ),
            // const SizedBox(height: 530),
            AnimatedOpacity(
              onEnd: () {
                checkAuthentication();
              },
              opacity: _opacity,
              duration: const Duration(seconds: 1),
              child: Image.asset(
                'images/logo1.PNG',
                height: 300,
                width: 300,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
