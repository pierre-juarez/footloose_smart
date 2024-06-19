import 'package:flutter/material.dart';

class TextWidgetInput extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;
  final TextAlign textAlign;

  const TextWidgetInput({
    super.key,
    required this.text,
    required this.fontSize,
    required this.fontWeight,
    required this.color,
    required this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
      ),
      textAlign: textAlign,
    );
  }
}
