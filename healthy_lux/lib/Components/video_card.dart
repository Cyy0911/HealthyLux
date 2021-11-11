import 'package:flutter/material.dart';
import 'package:healthy_lux/Preferences/app_theme.dart';
import 'package:healthy_lux/Screen/Video/video_abdominal.dart';
import 'package:healthy_lux/Screen/Video/video_arm.dart';
import 'package:healthy_lux/Screen/Video/video_back.dart';
import 'package:healthy_lux/Screen/Video/video_leg.dart';
import 'package:healthy_lux/Screen/Video/video_pectoral.dart';
import 'package:healthy_lux/model/video.dart';

class VideoCard extends StatelessWidget {
  final Videos video;
  const VideoCard({Key? key, required this.video}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(right: 20, bottom: 5),
        child: GestureDetector(
          onTap: () {
            if (video.index == 0) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Abdominal()),
              );
            } else if (video.index == 1) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Arm()),
              );
            } else if (video.index == 2) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Leg()),
              );
            } else if (video.index == 3) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Back()),
              );
            } else if (video.index == 4) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Pectoral()),
              );
            }
          },
          child: Material(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            elevation: 4,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Flexible(
                    fit: FlexFit.tight,
                    child: ClipRRect(
                      borderRadius:
                          const BorderRadius.vertical(top: Radius.circular(20)),
                      child: Image.asset(
                        video.imagePath,
                        width: 150,
                        fit: BoxFit.fill,
                      ),
                    )),
                Flexible(
                    fit: FlexFit.tight,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            video.videoCategory,
                            style: AppTheme.defaultTextStyle18Black(true),
                          )
                        ],
                      ),
                    ))
              ],
            ),
          ),
        ));
  }
}
