import 'package:flutter/material.dart';

//Codigo depreciado
// final miTema = ThemeData.dark().copyWith(
//   accentColor: Colors.red
// );

// final generalTheme = ThemeData.light();
 
// final prestaprofeTheme = ThemeData(
//   colorScheme: generalTheme.colorScheme.copyWith(
//     secondary: Colors.red,
//   ),
// );

class PrestaprofeTheme {

  final BorderRadius _circularBorderRadius = BorderRadius.all(Radius.circular(8));
  final Color _primaryColor = Color.fromRGBO(51, 114, 134, 1);
  final Color _errorTextStyleColor = Colors.red[900]!.withOpacity(0.70);
  final Color _inputFilledColor = Colors.white;
  static Color loginUnderlineButtonsColor = Colors.white;
  static Color whiteColorText = Colors.white;
  static Color loginButtonDisabledColor = Colors.grey;
  static Color disabledColor = Colors.grey;
  static Color extensionButtonActivateColor = Color.fromRGBO(2, 158, 51, 1);
  static Color extensionGreenSuccessColor = Color.fromRGBO(2, 158, 51, 1);
  static Color successGreen300 = Colors.green[300]!;
  static Color extensionInactiveMarksColor = Colors.grey.shade400;
  static Color goldenClientName = Color.fromARGB(255, 238, 195, 67);
  static Color goldenIconPages = Color.fromARGB(255, 238, 195, 67);
  static Color whiteTextTitlePages = Colors.white;
  static Color loginButtonFillColor = Color.fromRGBO(191, 155, 48, 1);
  static Color loginButtonTextColor = Color.fromRGBO(27, 60, 70, 1);
  static Color dashboardIconContornColor = Color.fromARGB(255, 247, 214, 118);
  static Color accentRedText = Colors.red;
  static Color black87Text = Colors.black87;
  static Color strokeSweepGradientRingColor = Colors.black54;
  static Color strokeCircleAvatarRingColor = Colors.transparent;
  static Color mainOptionsContainerFillColor = Colors.grey.shade100; //Container con 10% en grises
  static Color clientOptionsContainerFilledColor = Colors.white;
  static Color clientOptionsContainerBorderColor = Colors.grey.shade300; 
  static Color clientOptionsContainerBorderColorAccentRed = Colors.red; 
  static List<Color> avatarGoldenRingColorList = [
    Color.fromARGB(255, 107, 91, 43),
    Color.fromARGB(255, 255, 225, 136),
    Color.fromARGB(255, 238, 195, 67),
    Color.fromARGB(255, 107, 91, 43),
    Color.fromARGB(255, 238, 195, 67),
    Color.fromARGB(255, 107, 91, 43),
    Color.fromARGB(255, 255, 225, 136),
    Color.fromARGB(255, 107, 91, 43),
    Color.fromARGB(255, 238, 195, 67),
    Color.fromARGB(255, 107, 91, 43),
    Color.fromARGB(255, 238, 195, 67),
    Color.fromARGB(255, 255, 225, 136),
    Color.fromARGB(255, 107, 91, 43),
    Color.fromARGB(255, 238, 195, 67),
    Color.fromARGB(255, 107, 91, 43),
  ];

  static ThemeData prestaprofeTheme(){
    return ThemeData(
      inputDecorationTheme: InputDecorationTheme(
        border: UnderlineInputBorder(borderRadius: PrestaprofeTheme()._circularBorderRadius),
        filled: true,
        fillColor: PrestaprofeTheme()._inputFilledColor,
        enabledBorder: UnderlineInputBorder(
          borderRadius: PrestaprofeTheme()._circularBorderRadius,
          borderSide: BorderSide(
            color: PrestaprofeTheme()._primaryColor
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderRadius: PrestaprofeTheme()._circularBorderRadius,
          borderSide: BorderSide(
            color: PrestaprofeTheme()._primaryColor,
            width: 2
          )
        ),
        errorStyle: TextStyle(
          fontWeight: FontWeight.bold,
          color: PrestaprofeTheme()._errorTextStyleColor,
        ),
        errorBorder: UnderlineInputBorder(
          borderRadius: PrestaprofeTheme()._circularBorderRadius,
          borderSide: BorderSide(
            color: PrestaprofeTheme()._errorTextStyleColor
          ),
        ),
        focusedErrorBorder: UnderlineInputBorder(
          borderRadius: PrestaprofeTheme()._circularBorderRadius,
          borderSide: BorderSide(
            color: PrestaprofeTheme()._errorTextStyleColor
          ),
        ),
        errorMaxLines: 3,
      ),
      appBarTheme: AppBarTheme(
        centerTitle: true,
        color: PrestaprofeTheme()._primaryColor
      ),
      colorScheme: ColorScheme.light(
        primary: PrestaprofeTheme()._primaryColor
      ),
      fontFamily: 'Montserrat'
    );
  }

}