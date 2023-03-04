import 'dart:ui';

import 'package:flutter/material.dart';

class GradientBackground extends StatelessWidget {
  const GradientBackground({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
            colors: [
              // Color(0xFF4DB6AC),
              // Color(0xff26A69A),
              // Color(0xff009688),
              // Color(0xff00897B),
              // Color(0xffff5f6d),
              // Color(0xffffc371),
            ],
        ),
      ),
    );
  }
}
