// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:healthy_lux/Preferences/app_theme.dart';

// ignore: must_be_immutable
class BuildTextFormField extends StatefulWidget {
  final errorMessage;
  final label;
  final icon;
  String output = "";
  final TextEditingController? controller;
  final obscureText;

  BuildTextFormField(
      {Key? key,
      this.errorMessage,
      this.label,
      this.icon,
      required this.output,
      this.controller,
      this.obscureText})
      : super(key: key);

  @override
  _BuildTextFormFieldState createState() => _BuildTextFormFieldState();
}

class _BuildTextFormFieldState extends State<BuildTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: widget.controller,
        obscureText: widget.obscureText ? true : false,
        validator: (input) {
          if (input!.isEmpty) return widget.errorMessage;
        },
        decoration: InputDecoration(
          labelText: widget.label,
          prefixIcon: Icon(widget.icon),
        ),
        onSaved: (input) => widget.output = input!);
  }

  Widget buildTextFormField(String labelText, String placeholder, bool readonly,
      bool keyboardType, validator) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: TextFormField(
        validator: validator,
        style: AppTheme.defaultTextStyle16Black(true),
        keyboardType: keyboardType ? TextInputType.number : null,
        inputFormatters: [
          keyboardType
              ? FilteringTextInputFormatter.digitsOnly
              : LengthLimitingTextInputFormatter(30),
        ],
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(bottom: 3),
            enabled: readonly ? false : true,
            labelText: labelText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: placeholder,
            hintStyle: AppTheme.defaultTextStyle16Black(true)),
      ),
    );
  }
}
