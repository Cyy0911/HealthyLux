import 'package:flutter/material.dart';
import 'package:healthy_lux/Preferences/app_theme.dart';
import 'package:healthy_lux/Screen/home.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class UserGuide extends StatefulWidget {
  const UserGuide({Key? key}) : super(key: key);

  @override
  _UserGuideState createState() => _UserGuideState();
}

class _UserGuideState extends State<UserGuide> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: userguideBody());
  }

  Widget userguideBody() {
    return Stack(
      children: [
        PageView(controller: _pageController, children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/phonePoster1.png'),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/phonePoster2.png'),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/phonePoster3.png'),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/phonePoster4.png'),
                fit: BoxFit.fill,
              ),
            ),
          ),
        ]),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: SmoothPageIndicator(
                  controller: _pageController,
                  count: 4,
                  effect: const WormEffect(),
                  onDotClicked: (index) => _pageController.animateToPage(index,
                      duration: const Duration(microseconds: 250),
                      curve: Curves.bounceOut),
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            GestureDetector(
              child:
                  Text('SKIP', style: AppTheme.defaultTextStyle20Black(true)),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Home()));
              },
            )
          ],
        ),
      ],
    );
  }
}
