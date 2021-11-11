// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

class ImageBox extends StatelessWidget {
  final height;
  final imagePath;

  const ImageBox({Key? key, required this.height, required this.imagePath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Image(
        image: AssetImage(imagePath),
        fit: BoxFit.contain,
      ),
    );
  }
}
