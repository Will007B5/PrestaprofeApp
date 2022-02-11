import 'package:flutter/material.dart';

import 'package:prestaprofe/src/models/models.dart';


//Al extender de ChangeNotifier
//Se puede utilizar en un ChangeNotifierProvider o MultiProvider
class NewCreditFormProvider extends ChangeNotifier {

  GlobalKey<FormState> formKeyNewCredit = GlobalKey<FormState>();
  
  LoanModel loan;

  NewCreditFormProvider(this.loan);

  final _interesConst = 0.13; //13%
  final _ivaConst = 0.16; //16%
  double _amountSliderRange = 500.0;

  double _calculoInteresMensual = 0.0;
  double _calculoIvaInteresMensual = 0.0;
  double _interesMensualTotal = 0.0;

  double _calculoInteresQuincenal = 0.0;
  double _calculoIvaInteresQuincenal = 0.0;
  double _interesQuincenalTotal = 0.0;

  double _totalAmountPrestamo = 0.0;


  bool isValidFormNewCredit(){
    return formKeyNewCredit.currentState?.validate() ?? false;
  }

  double get amountSliderRange {
    return _amountSliderRange;
  }

  double get totalAmountPrestamo {
    return _totalAmountPrestamo;
  }

  set amountSliderRange(double value) {
    _amountSliderRange = value;
    notifyListeners();
  }

  void changeAmount(String days, String paymentSchema){
    if(days == '15 dias'){

      _calculoInteresQuincenal = (_amountSliderRange * _interesConst) / 2; //Calculo monto base interés quincenal

      _calculoIvaInteresQuincenal = _calculoInteresQuincenal * _ivaConst;

      _interesQuincenalTotal = _calculoInteresQuincenal + _calculoIvaInteresQuincenal;

      _totalAmountPrestamo = _amountSliderRange + _interesQuincenalTotal;

    }
    else if(days == '30 dias'){
      _calculoInteresMensual = _amountSliderRange * _interesConst; //Calculo monto base interés mensual

      _calculoIvaInteresMensual = _calculoInteresMensual * _ivaConst; //Calculo Iva Interes Mensual

      _interesMensualTotal = _calculoInteresMensual + _calculoIvaInteresMensual; //Calculo Interes Mensual Total


      _totalAmountPrestamo = _amountSliderRange + _interesMensualTotal; //Suma de intereses al monto base; monto total a pagar
    }
    else if(days == '45 dias'){

      _calculoInteresQuincenal = ((_amountSliderRange * _interesConst) / 2) * 3; //Calculo monto base interés quincenal

      _calculoIvaInteresQuincenal = _calculoInteresQuincenal * _ivaConst;

      _interesQuincenalTotal = _calculoInteresQuincenal + _calculoIvaInteresQuincenal;

      _totalAmountPrestamo = _amountSliderRange + _interesQuincenalTotal;

    }
    else if(days == '60 dias'){
      _calculoInteresMensual = (_amountSliderRange * _interesConst) * 2; //Calculo monto base interés mensual

      _calculoIvaInteresMensual = _calculoInteresMensual * _ivaConst; //Calculo Iva Interes Mensual

      _interesMensualTotal = _calculoInteresMensual + _calculoIvaInteresMensual; //Calculo Interes Mensual Total


      _totalAmountPrestamo = _amountSliderRange + _interesMensualTotal; //Suma de intereses al monto base; monto total a pagar
    }
    this.loan.amount = _totalAmountPrestamo;
    print(_totalAmountPrestamo);
    notifyListeners();
  }

}