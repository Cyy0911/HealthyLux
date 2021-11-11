import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:healthy_lux/Components/alert_dialog.dart';
import 'package:healthy_lux/Model/user_data.dart';
import 'package:healthy_lux/Preferences/app_theme.dart';
import 'package:healthy_lux/Screen/HelpSection/Guide/user_guide.dart';
import 'package:healthy_lux/components/appbar.dart';
import 'package:healthy_lux/components/image_box.dart';
import 'package:healthy_lux/components/text_form_field.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController? nameController, emailController, passwordController;
  String name = "", email = "", password = "";

  checkAuthentication() async {
    _auth.authStateChanges().listen((user) {
      if (user != null) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const UserGuide()));
      }
    });
  }

  signUp() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        name = nameController!.text;
        email = emailController!.text;
        password = passwordController!.text;
        await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        // ignore: deprecated_member_use
        await _auth.currentUser!.updateProfile(displayName: name);
        userSetup(name, email);
      } catch (e) {
        BuildAlertDialog()
            .buildAlertDialog(context, "Error", e.toString(), "OK");
      }
    }
  }

  @override
  void initState() {
    nameController = TextEditingController();
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
          title: 'Sign Up',
          backButton: true,
        ),
      ),
      body: signupBody(),
    );
  }

  Widget signupBody() {
    return SingleChildScrollView(
      child: Column(
        children: [
          const ImageBox(height: 400.0, imagePath: 'images/logo1.PNG'),
          Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                BuildTextFormField(
                  errorMessage: 'Enter Name',
                  label: 'Name',
                  icon: Icons.person,
                  output: name,
                  controller: nameController,
                  obscureText: false,
                ),
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
                  onPressed: signUp,
                  child: Text('Sign Up',
                      style: AppTheme.defaultTextStyle20White(true)),
                  color: AppTheme.redAccentColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
