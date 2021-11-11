import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:healthy_lux/Components/alert_dialog.dart';
import 'package:healthy_lux/Model/app_user.dart';
import 'package:healthy_lux/Model/firebase_service.dart';
import 'package:healthy_lux/components/appbar.dart';

import '../../Preferences/app_theme.dart';

late String email, result;

// ignore: must_be_immutable
class BMIResult extends StatefulWidget {
  String result2;
  String msg;
  String des;
  BMIResult(
      {Key? key, required this.result2, required this.msg, required this.des})
      : super(key: key);

  @override
  _BMIResultState createState() => _BMIResultState();
}

class _BMIResultState extends State<BMIResult> {
  final FirebaseService _firebaseService = FirebaseService();
  final AppUser _appUser = AppUser();

  void saveData() async {
    email = _appUser.email;
    result = widget.result2;
    User? currentUser = FirebaseAuth.instance.currentUser;
    await _firebaseService.updateBmi(
        "${currentUser!.email}", double.parse(result));
    BuildAlertDialog().buildAlertDialog(
        context, "BMI Result", "Your BMI result have been saved.", "OK");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.whiteColor,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: BuildAppBar(
          title: 'BMI RESULT',
          backButton: true,
        ),
      ),
      body: bmiResultBody(),
    );
  }

  Widget bmiResultBody() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          height: 20,
        ),
        Expanded(
          child: Text(
            "Your Result",
            style: AppTheme.defaultTextStyle30Black(true),
          ),
        ),
        Expanded(flex: 6, child: bmiResult()),
        Center(
          // ignore: deprecated_member_use
          child: RaisedButton(
              padding: const EdgeInsets.fromLTRB(60, 10, 60, 10),
              onPressed: () {
                saveData();
              },
              child: Text('Save Result',
                  style: AppTheme.defaultTextStyle20White(true)),
              color: AppTheme.orangeColor),
        ),
        const SizedBox(
          height: 20,
        ),
        Expanded(
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10.0),
              color: AppTheme.redAccentColor,
              child: Text("Recalculate",
                  style: AppTheme.defaultTextStyle30Black(false)),
            ),
          ),
        ),
      ],
    );
  }

  Widget bmiResult() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(widget.result2,
            textAlign: TextAlign.center,
            style: AppTheme.defaultTextStyle50Black(true)),
        const SizedBox(
          height: 10,
        ),
        Text(widget.des,
            textAlign: TextAlign.center,
            style: AppTheme.defaultTextStyle20Black(true)),
      ],
    );
  }
}
