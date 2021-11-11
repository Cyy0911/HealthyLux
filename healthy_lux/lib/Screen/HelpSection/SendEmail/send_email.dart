import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:healthy_lux/Components/appbar.dart';
import 'package:healthy_lux/Preferences/app_theme.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:mailto/mailto.dart';

class SendEmail extends StatelessWidget {
  const SendEmail({Key? key}) : super(key: key);

  launchMailto() async {
    final mailtoLink = Mailto(
      to: ['19060201@imail.sunway.edu.my'],
      cc: ['fany_cy@hotmail.com'],
      subject: 'Customer Help',
    );

    await launch('$mailtoLink');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: AppTheme.whiteColor,
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: BuildAppBar(
            title: 'Help',
            backButton: true,
          ),
        ),
        body: feedbackBody(),
      ),
    );
  }

  Widget feedbackBody() {
    return SafeArea(
      child: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 200.0,
            ),
            Text('Welcome to HealthyLux',
                style: AppTheme.defaultTextStyle36RedAccent(true)),
            const SizedBox(
              height: 20.0,
            ),
            Text('For any Queries, Mail us',
                style: AppTheme.defaultTextStyle20Black(false)),
            const SizedBox(
              height: 20.0,
            ),
            // ignore: deprecated_member_use
            RaisedButton(
                onPressed: launchMailto,
                child: const Text('Here', style: TextStyle(fontSize: 20)),
                textColor: AppTheme.whiteColor,
                color: AppTheme.redAccentColor,
                padding: const EdgeInsets.all(15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                )),
          ],
        ),
      ),
    );
  }
}
