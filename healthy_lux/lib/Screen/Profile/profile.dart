import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:healthy_lux/Components/text_field.dart';
import 'package:healthy_lux/Model/app_user.dart';
import 'package:healthy_lux/Model/firebase_service.dart';
import 'package:healthy_lux/Screen/HelpSection/SendEmail/send_email.dart';
import 'package:healthy_lux/components/appbar.dart';
import 'package:healthy_lux/components/bottom_navigation_bar.dart';
import 'package:healthy_lux/screen/profile/edit_profile.dart';

import '../../Preferences/app_theme.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final FirebaseService _firebaseService = FirebaseService();

  late User user;
  AppUser _appUser = AppUser();

  Future initData() async {
    try {
      User? currentUser = FirebaseAuth.instance.currentUser;

      if (currentUser != null) {
        _appUser =
            await _firebaseService.getUserInfoByEmail(currentUser.email!);

        setState(() {});
      }
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  onGoBack(dynamic value) {
    refreshData();
    setState(() {});
  }

  void refreshData() {
    initData();
  }

  void navigateSecondPage() {
    Route route = MaterialPageRoute(builder: (context) => const EditProfile());
    Navigator.push(context, route).then(onGoBack);
  }

  @override
  void initState() {
    refreshData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        bottomNavigationBar: const BuildBottomNavigationBar(),
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: BuildAppBar(
            title: 'User Profile',
            backButton: false,
          ),
        ),
        body: profileBody(),
      ),
    );
  }

  Widget profileBody() {
    return Container(
      color: AppTheme.whiteColor,
      padding: const EdgeInsets.only(left: 16, top: 25, right: 16),
      child: ListView(
        children: <Widget>[
          const SizedBox(
            height: 15,
          ),
          buildProfilePicture(),
          const SizedBox(
            height: 35,
          ),
          BuildTextField().buildTextField("User Name", _appUser.username),
          BuildTextField().buildTextField("E-mail", _appUser.email),
          BuildTextField().buildTextField("Age", "${_appUser.age}"),
          BuildTextField().buildTextField("BMI", "${_appUser.result}"),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // ignore: deprecated_member_use
              RaisedButton(
                padding: const EdgeInsets.fromLTRB(60, 10, 60, 10),
                onPressed: () {
                  navigateSecondPage();
                },
                child: Text('Edit Profile',
                    style: AppTheme.defaultTextStyle20White(true)),
                color: AppTheme.redAccentColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          // ignore: deprecated_member_use
          RaisedButton(
              padding: const EdgeInsets.all(15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const SendEmail()));
              },
              child: Text('Need help...',
                  style: AppTheme.defaultTextStyle18Black(false)
                      .copyWith(color: Colors.blue.shade900)),
              color: Theme.of(context).scaffoldBackgroundColor),
        ],
      ),
    );
  }

  Widget buildProfilePicture() {
    return Center(
      child: Stack(
        children: <Widget>[
          (_appUser.imageUrl != "")
              ? Container(
                  width: 130,
                  height: 130,
                  decoration: BoxDecoration(
                      border: Border.all(
                          width: 4,
                          color: Theme.of(context).scaffoldBackgroundColor),
                      boxShadow: [
                        BoxShadow(
                            spreadRadius: 2,
                            blurRadius: 10,
                            color: Colors.black.withOpacity(0.1),
                            offset: const Offset(0, 10))
                      ],
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(_appUser.imageUrl),
                      )),
                )
              : Container(
                  width: 130,
                  height: 130,
                  decoration: BoxDecoration(
                      border: Border.all(
                          width: 4,
                          color: Theme.of(context).scaffoldBackgroundColor),
                      boxShadow: [
                        BoxShadow(
                            spreadRadius: 2,
                            blurRadius: 10,
                            color: Colors.black.withOpacity(0.1),
                            offset: const Offset(0, 10))
                      ],
                      shape: BoxShape.circle,
                      image: const DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('images/Login.jpg'),
                      )),
                ),
        ],
      ),
    );
  }
}
