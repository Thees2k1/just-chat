import 'package:flutter/material.dart';

class CircleButton extends StatelessWidget {
  const CircleButton({super.key, this.child, this.onPressed});

  final VoidCallback? onPressed;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: onPressed, child: child);
  }
}
