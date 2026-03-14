import 'package:flutter/material.dart';

class CrisfiitLogo extends StatelessWidget {
  final double height;

  const CrisfiitLogo({super.key, this.height = 160});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Image.asset(
      isDark
          ? "assets/images/logo_crisfiit_horizontal_dark.png" //dark
          : "assets/images/logo_crisfiit_horizontal_light.png", //light
      height: height,
    );
  }
}