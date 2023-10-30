import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {

  final String text;
  final Color textColor;
  final double fontSize;
  final TextAlign textAlign;
  final FontWeight fontWeight;

  const TextWidget({super.key,
    required this.text,
    required this.textColor,
    required this.fontSize,
    required this.fontWeight,
    required this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        color: textColor,
        fontSize: fontSize,
        fontWeight: fontWeight,

      ),
    );
  }
}
