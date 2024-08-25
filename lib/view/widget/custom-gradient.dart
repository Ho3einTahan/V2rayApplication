import 'package:flutter/cupertino.dart';

Widget CustomGradient({required Widget child,required Color firstColor,required Color secondColor}) {
  return ShaderMask(
      shaderCallback: (bounds) =>  LinearGradient(
            colors: [firstColor, secondColor],
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
          ).createShader(Rect.fromLTWH(0.0, 0.0, bounds.width, bounds.height)),
      child: child);
}
