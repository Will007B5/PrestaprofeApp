import 'package:flutter/material.dart';

class Reference35Generator {
  //positions = id usuario + 4 primeros digitos CURP
  //Longitud minima obligatoria: 2
  //Longitud minima esperada: 5
  //Longitud maxima: 20
  //Este algoritmo genera un digito verificador + agregarle positions
  //EJEMPLO CON '9SALG'; DIGITO VERIFICADOR RESULTANTE = 4; REFERENCIA COMPLETA '9SALG4'

  static String makeReference({
    required String positions
  }){

  Map<String, int> _table = {
    'A': 1,
    'B': 2,
    'C': 3,
    'D': 4,
    'E': 5,
    'F': 6,
    'G': 7,
    'H': 8,
    'I': 9,
    'J': 10,
    'K': 11,
    'L': 12,
    'M': 13,
    'N': 14,
    'O': 15,
    'P': 16,
    'Q': 17,
    'R': 18,
    'S': 19,
    'T': 20,
    'U': 21,
    'V': 22,
    'W': 23,
    'X': 24,
    'Y': 25,
    'Z': 26
  };
  
  //1. A LAS POSICIONES SE LES ASIGNA UNA LETRA DE ACUERDO A LA TABLA
  RegExp _regexLetters = RegExp('[a-zA-Z]'); 
  List _newPositions = [];
  
  positions.runes.forEach((charNumCode){
    if(_regexLetters.hasMatch(String.fromCharCode(charNumCode))){
      _newPositions.add(_table[String.fromCharCode(charNumCode)]);
    }
    else{
      _newPositions.add(int.parse(String.fromCharCode(charNumCode)));
    }
  });
  
  //2. SE ASIGNA UN DIGITO MULTIPLICADOR A CADA CARACTER DE LA POSICION
  //LOS NUMEROS ASIGNADOS SON: 4, 3, 8; DE MANERA SUCESIVA
  //3. Y SE MULTIPLICA ESE DIGITO MULTIPLICADOR POR EL CARACTER (AHORA NUMERO)
  int _count = 1;
  List _multipliedPositions = _newPositions.map((num){
    if(_count == 1){
      _count = 2;
      return num * 4;
    }
    else if(_count == 2){
      _count = 3;
      return num * 3;
    }
    else if(_count == 3){
      _count = 1;
      return num * 8;
    }
  }).toList();
  
  //4. SI CADA POSICION ES DE DOS O MAS DIGITOS, SUMARLOS CADA NUMERO ENTRE SI
  //POR EJEMPLO: 36 = 3 + 6 = 9
  
  for(int index = 0; index < _multipliedPositions.length; index++) {
    bool parsed = false;
    while(!parsed){
      double aux1 = _multipliedPositions[index] / 10;
      int aux2 = aux1.floor();
      if(aux2 > 0){
        int tens = aux2;
        int units = (_multipliedPositions[index]).remainder(10);
        _multipliedPositions[index] = tens + units;
      }
      else{
        parsed = true;
      }
    }
  }
  
  //5. UNA VEZ QUE CADA POSICION SEA DE UNA SOLA CIFRA, SUMARLAS TODAS ENTRE ELLAS
  int _oneNumberPositions = _multipliedPositions.reduce((before, actual){
    return before + actual;
  });
  
  //6. EL RESULTADO DE LA SUMA SE DIVIDE ENTRE 10, Y SE GUARDA EL RESIDUO DE ESTA DIVISION
  //EL RESIDUO SE LE RESTA 10 Y SERÁ EL DIGITO VERIFICADOR
  int _referenceCheckDigit = (10 - (_oneNumberPositions.remainder(10)));

  final _completeReference = positions+_referenceCheckDigit.toString();

  return _completeReference;

  }
}