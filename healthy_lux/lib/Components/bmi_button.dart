import 'package:flutter/material.dart';
import 'package:healthy_lux/Preferences/app_theme.dart';

// ignore: must_be_immutable
class BtnPlusMinus extends StatelessWidget {
  BtnPlusMinus({Key? key, required this.buttonIcon, required this.onPress})
      : super(key: key);

  final IconData buttonIcon;
  void Function() onPress;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      child: Icon(buttonIcon),
      onPressed: onPress,
      fillColor: AppTheme.greyColor,
      constraints: const BoxConstraints.tightFor(
        width: 44.0,
        height: 44.0,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6.0),
      ),
    );
  }
}
