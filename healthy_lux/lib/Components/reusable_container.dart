import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ReusableContainer extends StatelessWidget {
  ReusableContainer(
      {Key? key, required this.contColor, required this.customChild, this.opt})
      : super(key: key);

  final Color contColor;
  final Widget customChild;
  void Function()? opt;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: opt,
      child: Container(
        child: customChild,
        margin: const EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          color: contColor,
          borderRadius: BorderRadius.circular(15.0),
        ),
      ),
    );
  }
}
