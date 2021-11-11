import 'package:flutter/material.dart';
import 'package:healthy_lux/Preferences/app_theme.dart';

class BuildTextField {
  Widget buildTextField(String labelText, String placeholder) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: TextField(
        style: AppTheme.defaultTextStyle16Black(true),
        enabled: false,
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(bottom: 3),
            labelText: labelText,
            labelStyle: AppTheme.defaultTextStyle20Black(true),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: placeholder,
            hintStyle: AppTheme.defaultTextStyle16Black(false)),
      ),
    );
  }
}
