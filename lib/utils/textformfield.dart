// ignore_for_file: public_member_api_docs, sort_constructors_first, prefer_typing_uninitialized_variables
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MyField extends StatelessWidget {
  var hintText,
      prefixIcon,
      suffixIcon,
      hintstyle,
      controller,
      obscureText,
      keyboardType,
      labelText,
      maxLines;

  String? Function(String?)? validator;
  MyField(
      {super.key,
      this.suffixIcon,
      this.obscureText = false,
      this.controller,
      this.hintText,
      this.hintstyle,
      this.prefixIcon,
      this.validator,
      this.keyboardType,
      this.labelText,
      this.maxLines = 1});

  @override
  Widget build(BuildContext context) {
    var kborder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: const BorderSide(color: Colors.transparent),
    );
    var kTextFormFieldStyle = const TextStyle(
      color: Colors.black,
      fontSize: 14.0,
      // fontFamily: 'EncodeSansRegular',
    );

    return TextFormField(
      textAlign: TextAlign.start,
      textAlignVertical: TextAlignVertical.top,
      maxLines: maxLines,
      keyboardType: keyboardType,
      obscureText: obscureText,
      style: kTextFormFieldStyle,
      validator: validator,
      controller: controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.black.withOpacity(0.09),
        // contentPadding: EdgeInsets.symmetric(
        //   horizontal: 20,
        //   vertical: 5,
        // ),
        focusedBorder: kborder,
        enabledBorder: kborder,
        border: kborder,
        hintText: hintText,
        labelText: labelText,
        // hintStyle: kLighGreyStyle,
        // labelStyle: kLighGreyStyle,
        // labelStyle: kLighGreyStyle,
        // labelText: hintText,
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
      ),
    );
  }
}
