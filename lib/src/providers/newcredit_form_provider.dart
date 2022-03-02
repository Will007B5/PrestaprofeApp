import 'package:flutter/material.dart';

import 'package:prestaprofe/src/helpers/helpers.dart';
import 'package:prestaprofe/src/models/models.dart';


//Al extender de ChangeNotifier
//Se puede utilizar en un ChangeNotifierProvider o MultiProvider
class NewCreditFormProvider extends ChangeNotifier {

  GlobalKey<FormState> formKeyNewCredit = GlobalKey<FormState>();
  
  LoanModel loan;

  NewCreditFormProvider(this.loan);

  double _amountSliderRange = 500.0;

  final double _sliderMinValue = 500.0;

  double _sliderMaxValue = 0.0;

  int _paymentSchemaDaysDuration = 1; //1 quincena/mes
  int _groupButtonSelectedButton = 0; //El 0 corresponde al primer cuadro de seleccion (1 quincena/15 dias)

  void changeAmount({required String paymentSchema, required int paymentSchemaDaysDuration}){
    //this.loan.amount = LoanInterestHelper.loanAmount(paymentSchema: paymentSchema, paymentSchemaDaysDuration: paymentSchemaDaysDuration, amountSliderRange: _amountSliderRange);
    this.loan.amount = _amountSliderRange;
    notifyListeners();
  }

  void initialAmount({required String paymentSchema, required int paymentSchemaDaysDuration}){
    //this.loan.amount =  LoanInterestHelper.loanAmount(paymentSchema: paymentSchema, paymentSchemaDaysDuration: paymentSchemaDaysDuration, amountSliderRange: _amountSliderRange);
    this.loan.amount = _amountSliderRange;
  }

  String changeInterestRateTextDescription({required String paymentSchema, required int paymentSchemaDaysDuration}){
    return LoanInterestHelper.interestRateTextDescription(paymentSchema: paymentSchema, paymentSchemaDaysDuration: paymentSchemaDaysDuration, amountSliderRange: _amountSliderRange);
  }

  String changeAmountInterestRateTextDescription({required String paymentSchema, required int paymentSchemaDaysDuration}){
    return LoanInterestHelper.amountInterestRateTextDescription(paymentSchema: paymentSchema, paymentSchemaDaysDuration: paymentSchemaDaysDuration, amountSliderRange: _amountSliderRange);
  }

  String changePaymentDurationInstructionsText({required String paymentSchema, required int paymentSchemaDaysDuration}){
    return LoanInterestHelper.paymentDurationInstructionsText(paymentSchema: paymentSchema, paymentSchemaDaysDuration: paymentSchemaDaysDuration);
  }

  String totalLoanAmount({required String paymentSchema, required int paymentSchemaDaysDuration}){
    double loanAmount = LoanInterestHelper.loanAmount(paymentSchema: paymentSchema, paymentSchemaDaysDuration: paymentSchemaDaysDuration, amountSliderRange: _amountSliderRange);
    final double stringLoanAmount = loanAmount;
    return stringLoanAmount.toStringAsFixed(2); 
  }

  String totalLoanAmountByPaymentSchemaDaysDuration({required String paymentSchema, required int paymentSchemaDaysDuration}){
    double loanAmount = LoanInterestHelper.loanAmount(paymentSchema: paymentSchema, paymentSchemaDaysDuration: paymentSchemaDaysDuration, amountSliderRange: _amountSliderRange);
    final double stringLoanAmount = loanAmount / paymentSchemaDaysDuration;
    return stringLoanAmount.toStringAsFixed(2); 
  }

  double sliderMaxValueByRange(int range){
    if(range == 1){
      _sliderMaxValue = 2000.0;
    }
    else if(range == 2){
      _sliderMaxValue = 20000.0;
    }
    return _sliderMaxValue;
  }

  bool isValidFormNewCredit(){
    return formKeyNewCredit.currentState?.validate() ?? false;
  }

  void customResetNewCreditForm(){
    _amountSliderRange = 500.0;
    _paymentSchemaDaysDuration = 1;
    _groupButtonSelectedButton = 0;
    this.loan = LoanModel.cleanLoan();
  }

  double get sliderMinValue {
    return _sliderMinValue;
  }

  int get paymentSchemaDaysDuration {
    return _paymentSchemaDaysDuration;
  }

  set paymentSchemaDaysDuration(int value) {
    _paymentSchemaDaysDuration = value;
    notifyListeners();
  }

  int get groupButtonSelectedButton {
    return _groupButtonSelectedButton;
  }

  set groupButtonSelectedButton(int value) {
    _groupButtonSelectedButton = value;
    notifyListeners();
  }

  double get amountSliderRange {
    return _amountSliderRange;
  }

  set amountSliderRange(double value) {
    _amountSliderRange = value;
    notifyListeners();
  }

}