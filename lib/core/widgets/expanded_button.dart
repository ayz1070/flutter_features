import 'package:flutter/material.dart';

class ExpandedButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color foregroundColor;
  final double borderRadius;
  final EdgeInsets padding;
  final TextStyle textStyle;
  final double? width;
  final double? height;

  const ExpandedButton({
    Key? key,
    required this.title,
    required this.onPressed,
    this.backgroundColor = Colors.white,
    this.foregroundColor = Colors.black,
    this.borderRadius = 4.0,
    this.padding = const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
    this.textStyle = const TextStyle(fontSize: 12),
    this.width,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          foregroundColor: foregroundColor,
          backgroundColor: backgroundColor,
          padding: padding,
          side: BorderSide(color: Colors.grey.shade300),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          minimumSize: width != null && height != null ? Size(width!, height!) : null,
        ),
        child: Text(
          title,
          style: textStyle,
        ),
      ),
    );
  }
}