import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle robotoStyle(double fontSize, FontWeight fontWeight, Color fontColor) {
  return GoogleFonts.roboto(
    textStyle: TextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: fontColor,
    ),
  );
}
