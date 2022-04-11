import 'package:flutter/material.dart';

class PrestaprofeButtonsStyle {
  static ButtonStyle loginUnderlineButtons({
    required double fontSize
  }){
    return ButtonStyle(
      textStyle: MaterialStateProperty.all(TextStyle(
        decoration: TextDecoration.underline,
        fontSize: fontSize,
      ))
    );
  }
}

// ButtonStyle loginUnderlineButtons = ButtonStyle(
//   overlayColor: MaterialStateProperty.all(Color.fromRGBO(51, 114, 134, 0.2)),
//   shape: MaterialStateProperty.all(StadiumBorder()),
//   foregroundColor: MaterialStateProperty.all(Color.fromRGBO(255, 255, 255, 0.8)),
//   textStyle: MaterialStateProperty.all(TextStyle(
//     decoration: TextDecoration.underline,
//     fontSize: 16
//   ))
// );