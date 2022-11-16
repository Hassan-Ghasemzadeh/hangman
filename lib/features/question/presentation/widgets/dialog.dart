import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hangman/core/nav_tools/nav_tools.dart';

Future<void> showAlertDialog({required String title}) => showDialog(
      context: navigator.context,
      barrierColor: Colors.white.withOpacity(0.2),
      builder: (ctx) => BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Container(
                height: 50,
                width: MediaQuery.of(navigator.context).size.width * 0.9,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 241, 53, 163),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Center(
                  child: DefaultTextStyle(
                    style: const TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontFamily: 'Swagstie',
                    ),
                    child: Text(
                      title,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
