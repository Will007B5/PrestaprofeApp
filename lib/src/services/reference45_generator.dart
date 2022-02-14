import 'package:flutter/material.dart';

class Reference45Generator {
  //Consideraciones (segun pdf y excel bbva)
  //Posiciones libres no debe de tener un solo digito cero o cadenas que empiecen con cero
  //Fecha es a 6 digitos y no debe comenzar con 0 (sale error en las divisiones)
  //Importe debe ser mayor a 0 (e incluir los decimales)
  //Por lo tanto, el importe minimo es de 100 (1.00)

  //Dato entrada: 'LLPO236699', 40722, 23766
  //Dato salida: LLPO2366990VF600IC68

  static String makeReference({
    required String freePositions,        //freePositions = '2956334'; //De 1 a 10 posiciones; será id usuario
    required int limitDateNumber,         //limitDateNumber = 060122; //DDMMAA numero de 6 digitos; es la fecha límite de pago
    required int amountNumber             //amountNumber = 196623; //Importe con decimales (sin el punto decimal)
  }){
    //Equivalence Tables Variables
    List equivalTable1 = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 
                 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 
                 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'];
    Map<String,String> equivalTable2 = {
      'A': '1',
      'B': '2',
      'C': '3',
      'D': '4',
      'E': '5',
      'F': '6',
      'G': '7',
      'H': '8',
      'I': '9',
      'J': '1',
      'K': '2',
      'L': '3',
      'M': '4',
      'N': '5',
      'O': '6',
      'P': '7',
      'Q': '8',
      'R': '9',
      'S': '1',
      'T': '2',
      'U': '3',
      'V': '4',
      'W': '5',
      'X': '6',
      'Y': '7',
      'Z': '8'
    };

    //Aux Variables
    List arrayDateNumberRemainder = [];
    List arrayAmountNumberRemainder = [];
    String dateBase36 = '';
    String amountCheckDigit = '';
    String referenceCheckDigit = '';
    String temporalFinalReference = '';
    List arrayFinalReferenceNums = [];
    int addResultFinalReferenceNums = 0;
    String finalReference = '';
    RegExp regEx = RegExp(r'^[a-zA-Z]+$');
    List<String> arrayTemporalFinalReference = [];

    //Code Begins
    //Se asgina las posiciones libres a la variable final de referencias
    finalReference = freePositions;

    //Calculo fecha condensada base 36; longitud cadena resultante: 4
    //Cociente resultante se divide entre 36
    //Repetir proceso hasta que cociente sea igual a 0
    while(limitDateNumber > 0){
      arrayDateNumberRemainder.add(limitDateNumber.remainder(36)); //Remainder para sacar el residuo
      limitDateNumber = (limitDateNumber ~/ 36); // ~/ para truncar la division y que sea int
    }
    //Se invierte el orden de los residuos
    //Estos residuos se sustituyen en la tabla de equivalencias 1
    arrayDateNumberRemainder = arrayDateNumberRemainder.reversed.toList();
    arrayDateNumberRemainder.forEach((letter){
      dateBase36 += equivalTable1[letter];
    });
    //Si la cadena tiene longitud menor a 4 caracteres, rellenar con 0 a la izquierda
    while(dateBase36.length < 4){
      dateBase36 = '0'+dateBase36;
    }
    finalReference+=dateBase36;

    //Calculo digito verificador importe; longitud cadena resultante: 5
    //Cociente resultante se divide entre 36
    //Repetir proceso hasta que cociente sea igual a 0
    while(amountNumber > 0){
      arrayAmountNumberRemainder.add(amountNumber.remainder(36));
      amountNumber = (amountNumber ~/ 36);
    }
    //Se invierte el orden de los residuos
    //Estos residuos se sustituyen en la tabla de equivalencias 1
    arrayAmountNumberRemainder = arrayAmountNumberRemainder.reversed.toList();
    arrayAmountNumberRemainder.forEach((letter){
      amountCheckDigit += equivalTable1[letter];
    });
    //Si la cadena tiene longitud menor a 5 caracteres, rellenar con 0 a la izquierda
    while(amountCheckDigit.length < 5){
      amountCheckDigit = '0'+amountCheckDigit;
    }
    finalReference+=amountCheckDigit;

    //Calculo digito verificador de la referencia; longitud cadena resultante: 1
    //Se toma toda la referencia hasta el momento (desde posiciones libres hasta importe condensado)
    //Se sustituyen valores tomando la tabla de equivalencias 2
    finalReference.split('').forEach((letter){
      if(regEx.hasMatch(letter)){
        temporalFinalReference += equivalTable2[letter]!;
      }
      else{
        temporalFinalReference += letter;
      }
    });
    //Como el siguiente paso hay que multiplicar de derecha a izquierda,
    //Alternando primero el 2 y luego el 1,
    //Se hace un reverse a la cadena
    arrayTemporalFinalReference = temporalFinalReference.split('').reversed.toList();
    for(int index = 0; index < arrayTemporalFinalReference.length; index++) {
     if((index + 1) % 2 != 0) {
       arrayFinalReferenceNums.add(int.parse(arrayTemporalFinalReference[index]) * 2);
     }
     else if((index + 1) % 2 == 0) {
       arrayFinalReferenceNums.add(int.parse(arrayTemporalFinalReference[index]) * 1);
     }
    }
    //Se analiza la cadena. Los numeros a dos digitos se suman entre si para
    //Que sean a un digito
    //La cadena resultante cada caracter debe ser un numero a un digito
    for(int index = 0; index < arrayFinalReferenceNums.length; index++) {
      double aux1 = arrayFinalReferenceNums[index] / 10;
      int aux2 = aux1.floor();
      if(aux2 > 0){
        int tens = aux2;
        int units = (arrayFinalReferenceNums[index]).remainder(10);
        arrayFinalReferenceNums[index] = tens + units;
      }
    }
    //Se suman todos los digitos de la cadena para obtener un numero solamente
    addResultFinalReferenceNums = arrayFinalReferenceNums.reduce((before, actual){
      return before + actual;
    });
    //El resultado de la suma se divide entre 10 y se guarda el residuo
    //Luego al residuo se le sustrae 10
    referenceCheckDigit = (10 - (addResultFinalReferenceNums.remainder(10))).toString();
    //Como el digito verificador resultante debe ser de longitud 1
    //Si es de mas de 1 su longitud
    //Entonces tomar solamente el segundo digito
    if((int.parse(referenceCheckDigit) / 10).floor() > 0){
      referenceCheckDigit = ''+referenceCheckDigit;
      referenceCheckDigit = referenceCheckDigit[1];
    }
    else{
      referenceCheckDigit = ''+referenceCheckDigit;
    }

    //Resultado final
    finalReference+=referenceCheckDigit;
    return finalReference;
  }
}