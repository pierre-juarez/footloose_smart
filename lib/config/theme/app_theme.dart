import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:footloose_tickets/config/helpers/roboto_style.dart';

class AppTheme {
  static Color backgroundColor = Colors.black;
  static Color inputBgColor = const Color.fromRGBO(240, 240, 240, 0.2);
  static TextStyle styleInput = robotoStyle(15, FontWeight.w400, Colors.white);
  static Color colorPrimary = const Color(0xff6F359C);
  static Color colorSecondary = const Color(0xff0033A0);
  static Color colorTerciary = const Color(0xffFDB913);
  static Color colorStyleText = Colors.white;
  static Color colorError = const Color(0xffD52B1E);

  static BoxDecoration inputCustomDecoration = BoxDecoration(
    color: AppTheme.inputBgColor,
    borderRadius: BorderRadius.circular(7.0),
  );

  static InputDecoration customDecorationCollapsed = InputDecoration.collapsed(
    focusColor: Colors.white.withOpacity(0.8),
    hintText: "",
    hintStyle: AppTheme.styleInput,
  );

  static Icon? getCheckCircle(bool param) {
    return param
        ? Icon(
            FontAwesomeIcons.solidCircleCheck,
            color: Colors.white.withOpacity(0.5),
            size: 23,
          )
        : null;
  }

  static Icon? getCheckCircleGreen(bool param) {
    return param
        ? const Icon(
            FontAwesomeIcons.solidCircleCheck,
            color: Color(0xff2AC957),
            size: 23,
          )
        : null;
  }

  static InputDecoration getCustomDecorationInput(bool eval) {
    return InputDecoration(
      isCollapsed: false,
      focusedBorder: InputBorder.none,
      border: InputBorder.none,
      focusColor: Colors.white.withOpacity(0.8),
      hintText: "",
      hintStyle: AppTheme.styleInput,
      suffixIcon: AppTheme.getCheckCircle(eval),
    );
  }

  ThemeData getTheme() => ThemeData(
        useMaterial3: true,
        colorSchemeSeed: backgroundColor,
      );
}
