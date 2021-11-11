import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:healthy_lux/Screen/start.dart';
import 'package:healthy_lux/components/appbar.dart';
import 'package:healthy_lux/components/bottom_navigation_bar.dart';
import 'package:healthy_lux/model/video.dart';
import 'package:healthy_lux/components/video_card.dart';

import '../Preferences/app_theme.dart';
import 'Recipe/recipe.dart';
import 'bmi/bmi_calculator.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late User? user;
  bool isloggedin = false;

  late List<Videos> video;

  checkAuthentication() async {
    _auth.authStateChanges().listen((user) {
      if (user == null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const Start()));
      }
    });
  }

  getUser() async {
    User? firebaseUser = _auth.currentUser;
    await firebaseUser!.reload();
    firebaseUser = _auth.currentUser;

    if (firebaseUser != null) {
      user = firebaseUser;
      isloggedin = true;
      setState(() {});
    }
  }

  @override
  void initState() {
    video = allVideo;
    checkAuthentication();
    getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BuildBottomNavigationBar(),
      backgroundColor: AppTheme.whiteColor,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: BuildAppBar(
          title: 'Training and Diet',
          backButton: false,
        ),
      ),
      body: homeBody(),
    );
  }

  Widget homeBody() {
    return Column(
      children: [
        Flexible(flex: 4, child: buildRecipeCard()),
        Flexible(flex: 3, child: buildBMICard()),
        const SizedBox(height: 30),
        Flexible(flex: 3, child: buildVideoList()),
      ],
    );
  }

  Widget buildRecipeCard() {
    return GestureDetector(
      child: Container(
        height: 250.0,
        width: 450.0,
        margin: const EdgeInsets.only(top: 20.0),
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: AppTheme.blackColor,
              offset: Offset(4.0, 4.0),
            )
          ],
          image: DecorationImage(
            image: AssetImage('images/RECIPE.png'),
            fit: BoxFit.fill,
          ),
        ),
      ),
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const Recipe()));
      },
    );
  }

  Widget buildBMICard() {
    return GestureDetector(
      child: Container(
        width: 450,
        height: 150,
        margin: const EdgeInsets.only(
          top: 20.0,
        ),
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: AppTheme.blackColor,
              offset: Offset(4.0, 4.0),
            )
          ],
          image: DecorationImage(
            image: AssetImage('images/BMI.PNG'),
            fit: BoxFit.cover,
          ),
        ),
      ),
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const BMI()));
      },
    );
  }

  Widget buildVideoList() {
    return SizedBox(
      height: 350,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10, left: 20),
            child: Text("Training Tutorial __________________________",
                style: AppTheme.defaultTextStyle20RedAccent(true)),
          ),
          Expanded(
              child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: <Widget>[
                const SizedBox(
                  width: 20,
                ),
                for (int x = 0; x < video.length; x++)
                  VideoCard(
                    video: video[x],
                  ),
              ],
            ),
          )),
          const SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }
}
