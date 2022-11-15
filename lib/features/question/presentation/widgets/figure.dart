import 'package:flutter/material.dart';

Widget figure(int tries) {
  return Stack(
    children: [
      figureImage(tries >= 0, "assets/hang.png"),
      figureImage(tries >= 1, "assets/head.png"),
      figureImage(tries >= 2, "assets/body.png"),
      figureImage(tries >= 3, "assets/ra.png"),
      figureImage(tries >= 4, "assets/la.png"),
      figureImage(tries >= 5, "assets/rl.png"),
      figureImage(tries >= 6, "assets/ll.png"),
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
