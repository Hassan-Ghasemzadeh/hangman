import 'package:flutter/material.dart';

Widget figure(int tries) {
  return Stack(
    children: [
      figureImage(tries >= 0, "assets/figure/hang.png"),
      figureImage(tries >= 1, "assets/figure/head.png"),
      figureImage(tries >= 2, "assets/figure/body.png"),
      figureImage(tries >= 3, "assets/figure/ra.png"),
      figureImage(tries >= 4, "assets/figure/la.png"),
      figureImage(tries >= 5, "assets/figure/rl.png"),
      figureImage(tries >= 6, "assets/figure/ll.png"),
    ],
  );
}

Widget figureImage(bool visible, String path) {
  return Visibility(
    visible: visible,
    child: SizedBox(
      width: 250,
      height: 250,
      child: Image.asset(path),
    ),
  );
}
