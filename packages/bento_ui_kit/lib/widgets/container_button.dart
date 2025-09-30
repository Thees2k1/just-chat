import 'package:bento_ui_kit/theme/colors.dart';
import 'package:flutter/material.dart';

class ContainerButton extends StatelessWidget {
  const ContainerButton({
    super.key,
    this.onPressed,
    this.label,
    this.padding = const EdgeInsets.all(8),
    this.radius = 12,
    this.width = 64,
    this.height = 32,
    this.borderWidth =1.5,
  });

  final VoidCallback? onPressed;
  final Widget? label;
  final EdgeInsets padding;
  final double radius;
  final double width;
  final double height;
  final double borderWidth;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          border: BoxBorder.all(
            color: MyColor.buttonBorderFallBack,
            width: borderWidth,
          ),
          boxShadow: [MyColor.buttonShadow],
          color: MyColor.buttonFill,
          borderRadius: BorderRadius.circular(radius),
        ),
        alignment: Alignment.center,
        padding: padding,
        child: label,
      ),
    );
  }
}
