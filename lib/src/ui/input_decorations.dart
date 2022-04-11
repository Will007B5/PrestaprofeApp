import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:prestaprofe/src/ui/prestaprofe_theme.dart';
import 'package:provider/provider.dart';

import 'package:prestaprofe/src/providers/providers.dart';


class InputDecorations {
  //Utilizara metodos estaticos a ser utilizados por los widgets que queramos
  //Seran estaticos para no hacer instancias de la clase

  static InputDecoration authInputDecoration({
    required String hintText,
    required String labelText,
    IconData? prefixIcon,
    IconData? suffixIcon,
    BuildContext? context
  }){ 
    return InputDecoration(
      border: PrestaprofeTheme.prestaprofeTheme().inputDecorationTheme.border,
      fillColor: PrestaprofeTheme.prestaprofeTheme().inputDecorationTheme.fillColor,
      filled: PrestaprofeTheme.prestaprofeTheme().inputDecorationTheme.filled,
      enabledBorder: PrestaprofeTheme.prestaprofeTheme().inputDecorationTheme.enabledBorder,
      focusedBorder: PrestaprofeTheme.prestaprofeTheme().inputDecorationTheme.focusedBorder,
      hintText: hintText,
      labelText: labelText,
      labelStyle: TextStyle(
        color: Colors.grey
      ),
      errorStyle: PrestaprofeTheme.prestaprofeTheme().inputDecorationTheme.errorStyle!.copyWith(
        fontSize: 16
      ),
      errorBorder: PrestaprofeTheme.prestaprofeTheme().inputDecorationTheme.errorBorder,
      focusedErrorBorder: PrestaprofeTheme.prestaprofeTheme().inputDecorationTheme.focusedErrorBorder,
      errorMaxLines: PrestaprofeTheme.prestaprofeTheme().inputDecorationTheme.errorMaxLines,
      prefixIcon: prefixIcon != null ? Icon(prefixIcon, color: Color.fromRGBO(51, 114, 134, 1)) : null,
      suffixIcon: (suffixIcon != null  && context != null) 
                  ? IconButton(
                    onPressed: (){
                      final loginForm = Provider.of<LoginFormProvider>(context, listen: false);
                      loginForm.obscurePasswordField = !loginForm.obscurePasswordField;
                    }, 
                    icon: Icon(suffixIcon, color: Color.fromRGBO(51, 114, 134, 1))
                  ) 
                  : null,
    );
  }

  static InputDecoration registerInputDecoration({
    required String hintText,
    required String labelText,
    required double height,
    required double textWidth,
    IconData? prefixIcon,
    IconData? suffixIcon,
    BuildContext? context
  }){ 
    final _circularBorderRadius = BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8), bottomLeft: Radius.circular(8), bottomRight: Radius.circular(8));
    
    return InputDecoration(
      border: UnderlineInputBorder(borderRadius: _circularBorderRadius),
      isDense: true,
      filled: true,
      fillColor: Colors.grey[300],
      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 3.5),
      enabledBorder: UnderlineInputBorder(
        borderRadius: _circularBorderRadius,
        borderSide: BorderSide(
          color: Color.fromRGBO(51, 114, 134, 1)
        ),
      ),
      focusedBorder: UnderlineInputBorder(
        borderRadius: _circularBorderRadius,
        borderSide: BorderSide(
          color: Color.fromRGBO(51, 114, 134, 1),
          width: 2
        )
      ),
      hintText: hintText,
      labelText: labelText,
      labelStyle: TextStyle(
        color: Color.fromRGBO(51, 114, 134, 1),
        fontSize: textWidth * 0.04
      ),
      floatingLabelStyle: TextStyle(
        color: Color.fromRGBO(51, 114, 134, 1),
        fontWeight: FontWeight.bold,
        fontSize: textWidth * 0.04
      ),
      errorStyle: TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.red[900]!.withOpacity(0.70),
        fontSize: textWidth * 0.03
      ),
      errorBorder: UnderlineInputBorder(
        borderRadius: _circularBorderRadius,
        borderSide: BorderSide(
          color: Colors.red[900]!.withOpacity(0.70)
        ),
      ),
      focusedErrorBorder: UnderlineInputBorder(
        borderRadius: _circularBorderRadius,
        borderSide: BorderSide(
          color: Colors.red[900]!.withOpacity(0.70)
        ),
      ),
      errorMaxLines: 3,
      //prefixIcon: prefixIcon != null ? Icon(prefixIcon, color: Color.fromRGBO(51, 114, 134, 1)) : null,
      suffixIcon: (suffixIcon != null  && context != null)? 
                  IconButton(
                    onPressed: (){
                      final registerForm = Provider.of<RegisterFormProvider>(context, listen: false);
                      registerForm.obscurePasswordFieldStepFour = !registerForm.obscurePasswordFieldStepFour;
                    }, 
                    icon: Icon(suffixIcon, color: Color.fromRGBO(51, 114, 134, 1))
                  ) : 
                  null,
    );
  }


  static InputDecoration myProfileHomeInputDecoration({
    required String hintText,
    required String labelText,
    required double textWidth,
    IconData? prefixIcon,
    IconData? suffixIcon,
    BuildContext? context
  }){ 
    final _circularBorderRadius = BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20), bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20));
    
    return InputDecoration(
      border: UnderlineInputBorder(borderRadius: _circularBorderRadius),
      isDense: true,
      filled: true,
      fillColor: Colors.grey[300],
      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 3.5),
      enabledBorder: UnderlineInputBorder(
        borderRadius: _circularBorderRadius,
        borderSide: BorderSide(
          color: Color.fromRGBO(51, 114, 134, 1)
        ),
      ),
      focusedBorder: UnderlineInputBorder(
        borderRadius: _circularBorderRadius,
        borderSide: BorderSide(
          color: Color.fromRGBO(51, 114, 134, 1),
          width: 2
        )
      ),
      hintText: hintText,
      labelText: labelText,
      hintStyle: TextStyle(
        color: Color.fromRGBO(51, 114, 134, 1),
        fontSize: textWidth * 0.95
      ),
      labelStyle: TextStyle(
        color: Color.fromRGBO(51, 114, 134, 1),
        fontSize: textWidth * 0.95
      ),
      floatingLabelStyle: TextStyle(
        color: Color.fromRGBO(51, 114, 134, 1),
        fontWeight: FontWeight.bold,
        fontSize: textWidth * 0.95
      ),
      errorStyle: TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.red[900]!.withOpacity(0.70),
        fontSize: textWidth * 0.85
      ),
      errorBorder: UnderlineInputBorder(
        borderRadius: _circularBorderRadius,
        borderSide: BorderSide(
          color: Colors.red[900]!.withOpacity(0.70)
        ),
      ),
      focusedErrorBorder: UnderlineInputBorder(
        borderRadius: _circularBorderRadius,
        borderSide: BorderSide(
          color: Colors.red[900]!.withOpacity(0.70)
        ),
      ),
      errorMaxLines: 3,
      //prefixIcon: prefixIcon != null ? Icon(prefixIcon, color: Color.fromRGBO(51, 114, 134, 1)) : null,
      suffixIcon: (suffixIcon != null  && context != null)? 
                  IconButton(
                    onPressed: (){
                      final registerForm = Provider.of<RegisterFormProvider>(context, listen: false);
                      registerForm.obscurePasswordFieldStepFour = !registerForm.obscurePasswordFieldStepFour;
                    }, 
                    icon: Icon(suffixIcon, color: Color.fromRGBO(51, 114, 134, 1))
                  ) : 
                  null,
    );
  }



}
