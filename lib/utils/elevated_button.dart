import 'package:flutter/material.dart';

import 'mytext.dart';

class MyButton extends StatelessWidget {
  final Color bgcolor;
  final double width;
  final String text;
  final Color textColor;
  final Color bdcolor;
  final VoidCallback? onPress;
  final bool loading;
  final double textSize;

  const MyButton({
    Key? key,
    this.textSize = 14,
    this.width = 335,
    required this.text,
    this.loading = false,
    this.bdcolor = Colors.black,
    this.bgcolor = Colors.black,
    this.textColor = Colors.white,
    required this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // double w = MediaQuery.of(context).size.width;
    var s = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: onPress,
      child: Container(
        height: s.height * 0.08,
        width: s.width,
        decoration: BoxDecoration(
          color: Colors.deepPurple,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: loading
              ? const CircularProgressIndicator(
                  color: Colors.white,
                )
              : MyText(
                  align: TextAlign.center,
                  text: text,
                  size: textSize,
                  fontFamily: 'Montserrat',
                  weight: FontWeight.w700,
                  color: textColor,
                ),
        ),
      ),
    );
  }
}
