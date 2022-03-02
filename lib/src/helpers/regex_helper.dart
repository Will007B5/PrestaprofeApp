import 'package:flutter/material.dart';

//Clase creada para llevar el control de expresiones regulares y validaciones
class RegexHelper {

  static RegExp name = RegExp(r'^[a-zA-zÁÉÍÓÚÜáéíóúüÑñ. ]{0,50}');
  static RegExp address = RegExp(r'^[0-9a-zA-zÁÉÍÓÚÜáéíóúüÑñ#.,/-/ ]{0,50}');
  static RegExp zipCode = RegExp(r'^[0-9]{0,5}');
  static RegExp curp = RegExp(r'^[0-9a-zA-z]{0,18}');
  static RegExp rfc = RegExp(r'^[0-9a-zA-z]{0,13}');
  static RegExp phone = RegExp(r'^[0-9]{0,10}');
  static RegExp filterSpecialCharsFromPhone = RegExp("[-!\$%^&*()_+|~=`{}\\[\\]:;'<>?,.\\/\"]");
  static RegExp email = RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
  static RegExp monthAndYearNumbersOnly = RegExp(r'^[0-9]{0,2}'); 
  static RegExp monthTwoDigitsRule = RegExp(r'^(0[1-9]|1[012])$');
  final datetimeYearOnly = DateTime.now().year.toString();
  static RegExp yearTwoDigitsRule = RegExp(r'^(['+RegexHelper().datetimeYearOnly[2]+r'-9]['+RegexHelper().datetimeYearOnly[3]+r'-9])$'); //Con concatenacion de variables le decimos que solo tome a partir del año actual (empezando por 2022 o 22 o [RegexHelper().datetimeYearOnly[2] RegexHelper().datetimeYearOnly[3]])
  static RegExp clabe = RegExp(r'^[0-9]{0,21}');

  static String makeValidPhone({
    required String phoneNumber
  }){
    String resultFilteredNumber = phoneNumber.replaceAll(filterSpecialCharsFromPhone, "").replaceAll(" ", "");
    if(resultFilteredNumber.startsWith('521')){
      return resultFilteredNumber.substring(3);
    }
    else if(resultFilteredNumber.startsWith('52')){
      return resultFilteredNumber.substring(2);
    }
    else{
      return resultFilteredNumber;
    }
  }
}