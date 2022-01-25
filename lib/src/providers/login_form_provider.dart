import 'package:flutter/material.dart';

//Al extender de ChangeNotifier
//Se puede utilizar en un ChangeNotifierProvider o MultiProvider
class LoginFormProvider extends ChangeNotifier {

  //Globalkey permite llamar a un widget por medio de su unique key
  //Necesita un state
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();

  String email = '';
  String password = '';

  bool _isLoading = false;

  bool _obscurePasswordField = false;

  bool get isLoading {
    return _isLoading;
  }

  set isLoading (bool value) {
    _isLoading = value;
    notifyListeners(); //Notifica que hay que redibujar
  }

  bool get obscurePasswordField {
    return _obscurePasswordField;
  }

  set obscurePasswordField (bool value) {
    _obscurePasswordField = value;
    notifyListeners(); //Notifica que hay que redibujar
  }

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }
}