import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:healthy_lux/Components/alert_dialog.dart';
import 'package:healthy_lux/Screen/reset_password.dart';
import 'package:healthy_lux/Screen/sign_up.dart';
import 'package:healthy_lux/components/appbar.dart';
import 'package:healthy_lux/components/image_box.dart';
import 'package:healthy_lux/components/text_form_field.dart';
import 'package:healthy_lux/screen/home.dart';

import '../Preferences/app_theme.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController? emailController, passwordController;
  String email = "", password = "";

  checkAuthentication() async {
    _auth.authStateChanges().listen((user) {
      if (user != null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const Home()));
      }
    });
  }

  login() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        email = emailController!.text;
        password = passwordController!.text;
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
      } catch (e) {
        BuildAlertDialog()
            .buildAlertDialog(context, "Error", e.toString(), "OK");
      }
    }
  }

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    checkAuthentication();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.whiteColor,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: BuildAppBar(
          title: "Log In",
          backButton: true,
        ),
      ),
      body: loginBody(),
    );
  }

  Widget loginBody() {
    return SingleChildScrollView(
      child: Column(
        children: [
          const ImageBox(height: 400.0, imagePath: 'images/logo1.PNG'),
          Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                BuildTextFormField(
                  errorMessage: 'Enter Email',
                  label: 'Email',
                  icon: Icons.email,
                  output: email,
                  controller: emailController,
                  obscureText: false,
                ),
                BuildTextFormField(
                  errorMessage: 'Please provide MINIMUM 6 character',
                  label: 'Password',
                  icon: Icons.lock_rounded,
                  output: password,
                  controller: passwordController,
                  obscureText: true,
                ),
                const SizedBox(
                  height: 20,
                ),
                // ignore: deprecated_member_use
                RaisedButton(
                  padding: const EdgeInsets.fromLTRB(70, 10, 70, 10),
                  onPressed: login,
                  child: Text('Login',
                      style: AppTheme.defaultTextStyle20White(true)),
                  color: AppTheme.redAccentColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          GestureDetector(
            child: const Text(
              "Create an Account?",
              style: TextStyle(color: Colors.blue),
            ),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const SignUp()));
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                child: const Text('Forgot Password?'),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ResetPassword()));
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
