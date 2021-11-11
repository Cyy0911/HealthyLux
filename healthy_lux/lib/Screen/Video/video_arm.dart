import 'package:flutter/material.dart';
import 'package:healthy_lux/Components/appbar.dart';
import 'package:healthy_lux/Components/bottom_navigation_bar.dart';
import 'package:healthy_lux/Components/chewie.dart';
import 'package:healthy_lux/Model/video_api.dart';
import 'package:healthy_lux/Model/video_file.dart';
import 'package:healthy_lux/Preferences/app_theme.dart';
import 'package:video_player/video_player.dart';

class Arm extends StatefulWidget {
  const Arm({Key? key}) : super(key: key);

  @override
  _ArmState createState() => _ArmState();
}

class _ArmState extends State<Arm> {
  late Future<List<VideoFile>> futureFiles;

  @override
  void initState() {
    futureFiles = VideoApi.listAll('videoArm/');
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
          title: 'Arm Training',
          backButton: true,
        ),
      ),
      body: armBody(),
    );
  }

  Widget armBody() {
    return FutureBuilder<List<VideoFile>>(
      future: futureFiles,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const Center(child: CircularProgressIndicator());
          default:
            if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            } else {
              final files = snapshot.data;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 12),
                  Expanded(
                    child: ListView.builder(
                      itemCount: files!.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final file = files[index];
                        return Column(
                          children: [
                            Text(
                              file.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                                color: AppTheme.blueColor,
                              ),
                            ),
                            SizedBox(
                              height: 300,
                              child: ChewieListItem(
                                videoPlayerController:
                                    VideoPlayerController.network(
                                  file.url,
                                ),
                                looping: true,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              );
            }
        }
      },
    );
  }
}
