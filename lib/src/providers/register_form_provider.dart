import 'package:flutter/material.dart';

import 'package:prestaprofe/src/models/models.dart';


//Al extender de ChangeNotifier
//Se puede utilizar en un ChangeNotifierProvider o MultiProvider
class RegisterFormProvider extends ChangeNotifier {

  GlobalKey<FormState> formKeyStepOne = GlobalKey<FormState>();
  GlobalKey<FormFieldState> formKeyDDState = GlobalKey<FormFieldState>();
  GlobalKey<FormFieldState> formKeyDDMunicipality = GlobalKey<FormFieldState>();
  GlobalKey<FormFieldState> formKeyDDCity = GlobalKey<FormFieldState>();
  GlobalKey<FormState> formKeyStepTwo = GlobalKey<FormState>();
  GlobalKey<FormState> formKeyStepFour = GlobalKey<FormState>();
  
  ClientModel client;

  RegisterFormProvider(this.client);

  bool _obscurePasswordFieldStepFour = false;

  bool _isLoading = false;

  bool _isThereInfoInAnyForm = false;

  int _stepAppBarCount = 0;

  bool get obscurePasswordFieldStepFour {
    return _obscurePasswordFieldStepFour;
  }

  set obscurePasswordFieldStepFour (bool value) {
    _obscurePasswordFieldStepFour = value;
    notifyListeners(); //Notifica que hay que redibujar
  }

  bool get isLoading {
    return _isLoading;
  }

  set isLoading (bool value) {
    _isLoading = value;
    notifyListeners(); //Notifica que hay que redibujar
  }

  int get stepAppBarCount {
    return _stepAppBarCount;
  }

  set stepAppBarCount (int value) {
    _stepAppBarCount = value;
    notifyListeners(); //Notifica que hay que redibujar
  }

  bool isValidFormStepOne(){
    return formKeyStepOne.currentState?.validate() ?? false;
  }

  bool isValidFormStepTwo(){
    return formKeyStepTwo.currentState?.validate() ?? false;
  }

  bool isValidFormStepThree(){
    if(client.ine != '' && client.ineBack != '' && client.selfie != '' && client.proofAddress != '' && client.payStub != ''){
      return true;
    }
    else{
      return false;
    }
  }

  bool isValidFormStepFour(){
    return formKeyStepFour.currentState?.validate() ?? false;
  }

}