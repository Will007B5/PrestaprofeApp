import 'package:flutter/material.dart';

class LoanInterestHelper {

  //Constantes
  final _constInterestRange1 = 0.13; //13% De 500 a 1500
  final _constInterestRange2 = 0.115; //11.5% De 2000 a 20000
  final _constIVA = 0.16; //16%

  //Metodo que devuelve la constante de porcentaje a aplicar dependiendo del monto solicitado 
  double _constInterestByRange(double amount) => amount < 2000 ? _constInterestRange1 : _constInterestRange2;

  //Metodo que calcula los intereses segun su esquema de pago (quincenal/mensual)
  double _calculateInterests({required String paymentSchema, required int paymentSchemaDaysDuration, required double amountSliderRange}){
    
    //Variables prestamos mensuales
    double _resultMonthlyInterest = 0.0;
    double _resultIVAMonthlyInterest = 0.0;
    double _resultTotalMonthlyInterest = 0.0;

    //Variables prestamos quincenales
    double _resultBiweeklyInterest = 0.0;
    double _resultIVABiweeklyInterest = 0.0;
    double _resultTotalBiweeklyInterest = 0.0;

    switch(paymentSchema){
      case 'biweekly':
        _resultBiweeklyInterest = ((amountSliderRange * LoanInterestHelper()._constInterestByRange(amountSliderRange)) / 2) * paymentSchemaDaysDuration; //Calculo monto base interés quincenal
        _resultIVABiweeklyInterest = _resultBiweeklyInterest * LoanInterestHelper()._constIVA; //Calculo Iva Interes Quincenal
        _resultTotalBiweeklyInterest = _resultBiweeklyInterest + _resultIVABiweeklyInterest; //Calculo Interes Quincenal Total
        return _resultTotalBiweeklyInterest;
      case 'monthly':
        _resultMonthlyInterest = amountSliderRange * LoanInterestHelper()._constInterestByRange(amountSliderRange) * paymentSchemaDaysDuration; //Calculo monto base interés mensual
        _resultIVAMonthlyInterest = _resultMonthlyInterest * LoanInterestHelper()._constIVA; //Calculo Iva Interes Mensual
        _resultTotalMonthlyInterest = _resultMonthlyInterest + _resultIVAMonthlyInterest; //Calculo Interes Mensual Total
      return _resultTotalMonthlyInterest;
    }
    return 0.0;

  }

  //Metodo que calcula los intereses segun su esquema de pago (quincenal/mensual) pero sin contar las quincenas/meses de duracion (para ser usado en la descripcion del texto del nuevo credito)
  double _calculateUnitaryInterestsTextDescription({required String paymentSchema, required double amountSliderRange}){
    
    //Variables prestamos mensuales
    double _resultMonthlyInterest = 0.0;
    double _resultIVAMonthlyInterest = 0.0;
    double _resultTotalMonthlyInterest = 0.0;

    //Variables prestamos quincenales
    double _resultBiweeklyInterest = 0.0;
    double _resultIVABiweeklyInterest = 0.0;
    double _resultTotalBiweeklyInterest = 0.0;

    switch(paymentSchema){
      case 'biweekly':
        _resultBiweeklyInterest = ((amountSliderRange * LoanInterestHelper()._constInterestByRange(amountSliderRange)) / 2); //Calculo monto base interés quincenal
        _resultIVABiweeklyInterest = _resultBiweeklyInterest * LoanInterestHelper()._constIVA; //Calculo Iva Interes Quincenal
        _resultTotalBiweeklyInterest = _resultBiweeklyInterest + _resultIVABiweeklyInterest; //Calculo Interes Quincenal Total
        return _resultTotalBiweeklyInterest;
      case 'monthly':
        _resultMonthlyInterest = amountSliderRange * LoanInterestHelper()._constInterestByRange(amountSliderRange); //Calculo monto base interés mensual
        _resultIVAMonthlyInterest = _resultMonthlyInterest * LoanInterestHelper()._constIVA; //Calculo Iva Interes Mensual
        _resultTotalMonthlyInterest = _resultMonthlyInterest + _resultIVAMonthlyInterest; //Calculo Interes Mensual Total
      return _resultTotalMonthlyInterest;
    }
    return 0.0;

  }

  //Metodo que calcula el monto total (con intereses) del prestamo
  static double loanAmount({
    required String paymentSchema, // biweekly y monthly
    required int paymentSchemaDaysDuration, //1 y 3 quincenas; 1 y 2 meses
    required double amountSliderRange //Valor del monto a solicitar
  }){

    //Variable total del monto
    double _resultTotalLoanAmount = 0.0;

    switch(paymentSchema){
      case 'biweekly':
        _resultTotalLoanAmount = amountSliderRange + LoanInterestHelper()._calculateInterests(paymentSchema: paymentSchema, paymentSchemaDaysDuration: paymentSchemaDaysDuration, amountSliderRange: amountSliderRange); //Suma de intereses al monto base; monto total a pagar
        break;
      case 'monthly':
        _resultTotalLoanAmount = amountSliderRange + LoanInterestHelper()._calculateInterests(paymentSchema: paymentSchema, paymentSchemaDaysDuration: paymentSchemaDaysDuration, amountSliderRange: amountSliderRange); //Suma de intereses al monto base; monto total a pagar
      break;
    }
    print('_resultTotalLoanAmount ${_resultTotalLoanAmount}');
    return _resultTotalLoanAmount;

  }

  //Metodo que devuelve la descripcion de tasas de interes del prestamo
  static String interestRateTextDescription({
    required String paymentSchema, // biweekly y monthly
    required int paymentSchemaDaysDuration, //1 y 3 quincenas; 1 y 2 meses
    required double amountSliderRange //Valor del monto a solicitar
  }){

    switch(paymentSchema){
      case 'biweekly':
        return 'TASA DE INTERÉS QUINCENAL DEL ${((LoanInterestHelper()._constInterestByRange(amountSliderRange) * 100) / 2).toString()}% (+ IVA) (\$${LoanInterestHelper()._calculateUnitaryInterestsTextDescription(paymentSchema: paymentSchema, amountSliderRange: amountSliderRange).toStringAsFixed(2)} x ${paymentSchemaDaysDuration > 1 ? paymentSchemaDaysDuration.toString() + ' QUINCENAS' : paymentSchemaDaysDuration.toString() + ' QUINCENA'})';
      case 'monthly':
        return 'TASA DE INTERÉS MENSUAL DEL ${((LoanInterestHelper()._constInterestByRange(amountSliderRange) * 100)).toString()}% (+ IVA) (\$${LoanInterestHelper()._calculateUnitaryInterestsTextDescription(paymentSchema: paymentSchema, amountSliderRange: amountSliderRange).toStringAsFixed(2)} x ${paymentSchemaDaysDuration > 1 ? paymentSchemaDaysDuration.toString() + ' MESES' : paymentSchemaDaysDuration.toString() + ' MES'})';
    }
    return '';

  }

  //Metodo que devulve solamente el monto/valor (en texto) del interés calculado a esa quincena/mes
  static String amountInterestRateTextDescription({
    required String paymentSchema, // biweekly y monthly
    required int paymentSchemaDaysDuration, //1 y 3 quincenas; 1 y 2 meses
    required double amountSliderRange //Valor del monto a solicitar
  }){

    switch(paymentSchema){
      case 'biweekly':
        return '${LoanInterestHelper()._calculateInterests(paymentSchema: paymentSchema, paymentSchemaDaysDuration: paymentSchemaDaysDuration, amountSliderRange: amountSliderRange).toStringAsFixed(2)}';
      case 'monthly':
        return '${LoanInterestHelper()._calculateInterests(paymentSchema: paymentSchema, paymentSchemaDaysDuration: paymentSchemaDaysDuration, amountSliderRange: amountSliderRange).toStringAsFixed(2)}';
    }
    return '';

  }

  //Metodo que devulve la descripcion de dias de duración del prestamo (Por ejemplo: 3 pagos quincenales de $xxx.xx)
  static String paymentDurationInstructionsText({
    required String paymentSchema, // biweekly y monthly
    required int paymentSchemaDaysDuration, //1 y 3 quincenas; 1 y 2 meses
  }){

    switch(paymentSchema){
      case 'biweekly':
        return '${paymentSchemaDaysDuration > 1 ? paymentSchemaDaysDuration.toString() + ' PAGOS QUINCENALES DE' : paymentSchemaDaysDuration.toString() + ' PAGO QUINCENAL DE'}';
      case 'monthly':
        return '${paymentSchemaDaysDuration > 1 ? paymentSchemaDaysDuration.toString() + ' PAGOS MENSUALES DE' : paymentSchemaDaysDuration.toString() + ' PAGO MENSUAL DE'}';
    }
    return '';

  }

}