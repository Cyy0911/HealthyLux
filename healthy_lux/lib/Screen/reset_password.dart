import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:healthy_lux/Components/alert_dialog.dart';
import 'package:healthy_lux/Components/appbar.dart';
import 'package:healthy_lux/Preferences/app_theme.dart';
import 'package:healthy_lux/Screen/home.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  String? email;

  checkAuthentication() async {
    _auth.authStateChanges().listen((user) {
      if (user != null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const Home()));
      }
    });
  }

  reset() async {
    if (_formkey.currentState!.validate()) {
      _formkey.currentState!.save();
      try {
        await _auth.sendPasswordResetEmail(email: email!);
        BuildAlertDialog().buildAlertDialog(context, "Reset Password",
            "Request link have been sent. Please check your Mailbox", "OK");
      } catch (e) {
        BuildAlertDialog()
            .buildAlertDialog(context, "Error", e.toString(), "OK");
      }
    }
  }

  @override
  void initState() {
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
          title: 'Reset Password',
          backButton: true,
        ),
      ),
      body: resetPasswordBody(),
    );
  }

  Widget resetPasswordBody() {
    return Center(
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(15),
          child: Form(
            key: _formkey,
            child: Column(
              children: [
                Text(
                  "Reset Password",
                  style: AppTheme.defaultTextStyle30RedAccent(false),
                ),
                const SizedBox(
                  height: 60,
                ),
                TextFormField(
                    validator: (input) {
                      if (input!.isEmpty) return 'Enter Email';
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                        hintText: "Enter email",
                        labelText: "Email",
                        prefixIcon: Icon(Icons.email)),
                    onSaved: (input) => email = input),
                const SizedBox(
                  height: 50,
                ),
                SizedBox(
                  height: 60,
                  width: 180,
                  // ignore: deprecated_member_use
                  child: RaisedButton(
                      color: Colors.redAccent,
                      onPressed: reset,
                      child: Text(
                        "Send Request",
                        style: AppTheme.defaultTextStyle18White(false),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
