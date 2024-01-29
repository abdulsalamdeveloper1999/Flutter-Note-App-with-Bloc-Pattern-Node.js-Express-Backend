import 'package:flutter/material.dart';

class MyText extends StatelessWidget {
  final String text;
  final double? size;
  final FontWeight? weight;
  final Color? color;
  final TextAlign align;
  final TextDecoration? decoration;
  final String fontFamily;
  final int? maxLines;
  final TextOverflow? overflow;
  final FontStyle? fontStyle;
  final double? letterSpacing;

  const MyText({
    super.key,
    this.letterSpacing,
    this.fontStyle,
    this.overflow,
    required this.text,
    this.size = 14.0,
    this.weight = FontWeight.normal,
    this.color = Colors.black,
    this.align = TextAlign.left,
    this.decoration,
    this.fontFamily = 'EncodeSansMedium',
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: overflow,
      style: TextStyle(
        letterSpacing: letterSpacing,
        fontStyle: fontStyle,
        fontSize: size,
        fontWeight: weight,
        color: color,
        decoration: decoration,
        fontFamily: fontFamily,
      ),
      textAlign: align,
      maxLines: maxLines,
    );
  }
}
