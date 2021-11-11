import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:healthy_lux/Screen/home.dart';
import 'package:healthy_lux/components/image_box.dart';
import 'package:healthy_lux/Preferences/app_theme.dart';
import 'package:healthy_lux/screen/login.dart';
import 'package:healthy_lux/screen/sign_up.dart';

class Start extends StatefulWidget {
  const Start({Key? key}) : super(key: key);

  @override
  _StartState createState() => _StartState();
}

class _StartState extends State<Start> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserCredential> googleSignIn() async {
    GoogleSignIn googleSignIn = GoogleSignIn();
    GoogleSignInAccount? googleUser = await googleSignIn.signIn();
    if (googleUser != null) {
      GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      if (googleAuth.idToken != null && googleAuth.accessToken != null) {
        final AuthCredential credential = GoogleAuthProvider.credential(
            accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

        final UserCredential user =
            await _auth.signInWithCredential(credential);

        await Navigator.push(
            context, MaterialPageRoute(builder: (context) => const Home()));

        return user;
      } else {
        throw StateError('Missing Google Auth Token');
      }
    } else {
      throw StateError('Sign in Aborted');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.whiteColor,
      body: startBody(),
    );
  }

  Widget startBody() {
    return Column(
      children: <Widget>[
        const SizedBox(height: 45.0),
        const ImageBox(height: 400.0, imagePath: "images/logo1.PNG"),
        const SizedBox(height: 20.0),
        RichText(
            text: TextSpan(
                text: 'Welcome to  ',
                style: AppTheme.defaultTextStyle25Black(true),
                children: <TextSpan>[
              TextSpan(
                  text: 'HealthyLux',
                  style: AppTheme.defaultTextStyle30RedAccent(true))
            ])),
        const SizedBox(height: 10.0),
        Text('A Training & Diet App',
            style: AppTheme.defaultTextStyle14Black(false)),
        const SizedBox(height: 12.0),
        Text('Your body hears everything that your mind says',
            style: AppTheme.defaultTextStyle14Black(true)),
        const SizedBox(height: 25.0),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
          // ignore: deprecated_member_use
          RaisedButton(
              padding: const EdgeInsets.only(left: 30, right: 30),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Login()));
              },
              child:
                  Text('LOGIN', style: AppTheme.defaultTextStyle20White(true)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              color: Colors.redAccent),
          const SizedBox(width: 20.0),
          // ignore: deprecated_member_use
          RaisedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const SignUp()));
              },
              child: Text('REGISTER',
                  style: AppTheme.defaultTextStyle20White(true)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              color: Colors.redAccent),
        ]),
        const SizedBox(height: 20.0),
        SignInButton(Buttons.Google,
            text: "Sign up with Google", onPressed: googleSignIn),
        const SizedBox(height: 30.0),
      ],
    );
  }
}
