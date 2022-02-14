import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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
    final _circularBorderRadius = BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8), bottomLeft: Radius.circular(8), bottomRight: Radius.circular(8));
    
    return InputDecoration(
      border: UnderlineInputBorder(borderRadius: _circularBorderRadius),
      fillColor: Colors.white,
      filled: true,
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
        color: Colors.grey
      ),
      errorStyle: TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.red[900]!.withOpacity(0.70),
        fontSize: 16
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
      prefixIcon: prefixIcon != null ? Icon(prefixIcon, color: Color.fromRGBO(51, 114, 134, 1)) : null,
      suffixIcon: (suffixIcon != null  && context != null)? 
                  IconButton(
                    onPressed: (){
                      final loginForm = Provider.of<LoginFormProvider>(context, listen: false);
                      loginForm.obscurePasswordField = !loginForm.obscurePasswordField;
                    }, 
                    icon: Icon(suffixIcon, color: Color.fromRGBO(51, 114, 134, 1))
                  ) : 
                  null,
    );
  }

  static InputDecoration registerInputDecoration({
    required String hintText,
    required String labelText,
    required double height,
    required double textWidth,
    IconData? prefixIcon
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
    );
  }

  // static InputDecoration registerInputDecoration({
  //   required String hintText,
  //   required String labelText,
  //   required double height,
  //   required double textWidth,
  //   IconData? prefixIcon
  // }){ 
  //   return InputDecoration(
  //     focusedErrorBorder: InputBorder.none,
  //     errorBorder: InputBorder.none,
  //     isDense: true,
  //     filled: true,
  //     fillColor: Colors.white,
  //     //constraints: BoxConstraints.expand(height: 44),
  //     floatingLabelStyle: TextStyle(
  //       color: Color.fromRGBO(51, 114, 134, 1),
  //       fontWeight: FontWeight.bold,
  //       fontSize: textWidth * 0.04
  //     ),
  //     border: InputBorder.none,
  //     hintText: hintText,
  //     labelText: labelText,
  //     labelStyle: TextStyle(
  //       color: Colors.grey,
  //       fontSize: textWidth * 0.04
  //     ),
  //     //prefixIcon: prefixIcon != null ? Icon(prefixIcon, color: Color.fromRGBO(51, 114, 134, 1)) : null
  //   );
  // }

}
