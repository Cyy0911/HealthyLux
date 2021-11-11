import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:healthy_lux/Preferences/app_theme.dart';
import 'package:healthy_lux/screen/home.dart';
import 'package:healthy_lux/screen/profile/profile.dart';

class BuildBottomNavigationBar extends StatefulWidget {
  const BuildBottomNavigationBar({Key? key}) : super(key: key);

  @override
  State<BuildBottomNavigationBar> createState() =>
      _BuildBottomNavigationBarState();
}

class _BuildBottomNavigationBarState extends State<BuildBottomNavigationBar> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  int selectedIndex = 0;
  int index = 0;

  signOut() async {
    _auth.signOut();
    // final googleSignIn = GoogleSignIn();
    // await googleSignIn.signOut();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: AppTheme.redAccentColor,
      selectedItemColor: AppTheme.blackColor,
      unselectedItemColor: AppTheme.whiteColor,
      currentIndex: index,
      items: const [
        BottomNavigationBarItem(
          label: "Home",
          icon: Icon(Icons.home, color: AppTheme.whiteColor),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_box_rounded, color: AppTheme.whiteColor),
          label: "Profile",
        ),
        BottomNavigationBarItem(
          label: "Sign Out",
          icon: Icon(Icons.logout, color: AppTheme.whiteColor),
        ),
      ],
      onTap: (index) {
        if (index == 0) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Home()),
          );
        } else if (index == 1) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Profile()),
          );
        } else if (index == 2) {
          signOut();
        }
      },
    );
  }
}
