import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class AppTheme {
  static const Color blackColor = Colors.black;
  static const Color whiteColor = Colors.white;
  static const Color redAccentColor = Colors.redAccent;
  static const Color greenColor = Colors.green;
  static const Color orangeColor = Colors.orange;
  static const Color blueColor = Colors.blue;

  static const Color greyColor = Color(0xFF5A5555);
  static final Color grey300Color = Colors.grey.shade300;
  static const Color brownColor = Color(0xFF794B00);

  static TextStyle defaultTextStyle50Black(bool isBold) {
    return TextStyle(
        fontSize: 50,
        fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
        color: blackColor);
  }

  static TextStyle defaultTextStyle45White(bool isBold) {
    return TextStyle(
        fontSize: 45,
        fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
        color: whiteColor);
  }

  static TextStyle defaultTextStyle36RedAccent(bool isBold) {
    return TextStyle(
        fontSize: 36,
        fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
        color: redAccentColor);
  }

  static TextStyle defaultTextStyle30Black(bool isBold) {
    return TextStyle(
        fontSize: 30,
        fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
        color: blackColor);
  }

  static TextStyle defaultTextStyle30White(bool isBold) {
    return TextStyle(
        fontSize: 30,
        fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
        color: whiteColor);
  }

  static TextStyle defaultTextStyle30RedAccent(bool isBold) {
    return TextStyle(
        fontSize: 30,
        fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
        color: redAccentColor);
  }

  static TextStyle defaultTextStyle25Black(bool isBold) {
    return TextStyle(
        fontSize: 25,
        fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
        color: blackColor);
  }

  static TextStyle defaultTextStyle20Black(bool isBold) {
    return TextStyle(
        fontSize: 20,
        fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
        color: blackColor);
  }

  static TextStyle defaultTextStyle20White(bool isBold) {
    return TextStyle(
        fontSize: 20,
        fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
        color: whiteColor);
  }

  static TextStyle defaultTextStyle20RedAccent(bool isBold) {
    return TextStyle(
        fontSize: 20,
        fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
        color: redAccentColor);
  }

  static TextStyle defaultTextStyle18Black(bool isBold) {
    return TextStyle(
        fontSize: 18,
        fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
        color: blackColor);
  }

  static TextStyle defaultTextStyle18White(bool isBold) {
    return TextStyle(
        fontSize: 18,
        fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
        color: whiteColor);
  }

  static TextStyle defaultTextStyle17Black(bool isBold) {
    return TextStyle(
        fontSize: 17,
        fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
        color: blackColor);
  }

  static TextStyle defaultTextStyle16Black(bool isBold) {
    return TextStyle(
        fontSize: 16,
        fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
        color: blackColor);
  }

  static TextStyle defaultTextStyle15Black(bool isBold) {
    return TextStyle(
        fontSize: 15,
        fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
        color: blackColor);
  }

  static TextStyle defaultTextStyle15redAccent(bool isBold) {
    return TextStyle(
        fontSize: 15,
        fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
        color: redAccentColor);
  }

  static TextStyle defaultTextStyle14Black(bool isBold) {
    return TextStyle(
        fontSize: 14,
        fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
        color: blackColor);
  }

  static TextStyle defaultTextStyle14White(bool isBold) {
    return TextStyle(
        fontSize: 14,
        fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
        color: whiteColor);
  }
}
