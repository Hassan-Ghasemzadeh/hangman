import 'package:flutter/material.dart';

import '../../../../core/nav_tools/nav_tools.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    Key? key,
    required this.data,
    this.onPressed,
  }) : super(key: key);
  final String data;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(navigator.context).size.width * 0.92,
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(data),
      ),
    );
  }
}
