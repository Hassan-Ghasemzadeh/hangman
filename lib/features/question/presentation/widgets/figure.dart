import 'package:flutter/material.dart';

Widget figure(int tries) {
  return Stack(
    children: [
      figureImage(
        tries >= 0,
        "assets/img/hang.png",
        Colors.brown,
      ),
      figureImage(
        tries >= 1,
        "assets/img/head.png",
        Colors.black,
      ),
      figureImage(
        tries >= 2,
        "assets/img/body.png",
        Colors.black,
      ),
      figureImage(
        tries >= 3,
        "assets/img/ra.png",
        Colors.black,
      ),
      figureImage(
        tries >= 4,
        "assets/img/la.png",
        Colors.black,
      ),
      figureImage(
        tries >= 5,
        "assets/img/rl.png",
        Colors.black,
      ),
      figureImage(
        tries >= 6,
        "assets/img/ll.png",
        Colors.black,
      ),
    ],
  );
}

Widget figureImage(bool visible, String path, [Color? color]) {
  return Visibility(
    visible: visible,
    child: SizedBox(
      width: 250,
      height: 250,
      child: Image.asset(
        path,
        color: color,
      ),
    ),
  );
}
