import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class InputDecorations {
  //Utilizara metodos estaticos a ser utilizados por los widgets que queramos
  //Seran estaticos para no hacer instancias de la clase

  static InputDecoration authInputDecoration({
    required String hintText,
    required String labelText,
    IconData? prefixIcon,
    IconData? suffixIcon
  }){ 
    final _circularBorderRadius = BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20), bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20));
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
        color: Colors.red[900],
        fontSize: 16
      ),
      prefixIcon: prefixIcon != null ? Icon(prefixIcon, color: Color.fromRGBO(51, 114, 134, 1)) : null,
      suffixIcon: suffixIcon != null ? Icon(suffixIcon, color: Color.fromRGBO(51, 114, 134, 1)) : null
    );
  }

  static InputDecoration registerInputDecoration({
    required String hintText,
    required String labelText,
    IconData? prefixIcon
  }){ 
    final _circularBorderRadius = BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20), bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20));
    return InputDecoration(
      filled: true,
      fillColor: Colors.white,
      floatingLabelStyle: TextStyle(
        color: Color.fromRGBO(51, 114, 134, 1),
        fontWeight: FontWeight.bold,
        fontSize: 18
      ),
      border: OutlineInputBorder(borderRadius: _circularBorderRadius),
      enabledBorder: OutlineInputBorder(
        borderRadius: _circularBorderRadius,
        borderSide: BorderSide(
          color: Color.fromRGBO(51, 114, 134, 1),
          width: 2
        ),
      ),
      focusedBorder: OutlineInputBorder(
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
      prefixIcon: prefixIcon != null ? Icon(prefixIcon, color: Color.fromRGBO(51, 114, 134, 1)) : null
    );
  }

}
