import 'package:flutter/material.dart';

import 'package:prestaprofe/src/models/models.dart';


//Al extender de ChangeNotifier
//Se puede utilizar en un ChangeNotifierProvider o MultiProvider
class CardFormProvider extends ChangeNotifier {

  GlobalKey<FormState> formRegisterClabeCard = GlobalKey<FormState>();
  
  CardModel currentCard;

  CardFormProvider(this.currentCard);

  bool _isLoading = false;

  String _cardOrClabe = 'card';

  bool get isLoading {
    return _isLoading;
  }

  set isLoading (bool value) {
    _isLoading = value;
    notifyListeners(); //Notifica que hay que redibujar
  }

  String get cardOrClabe {
    return _cardOrClabe;
  }

  set cardOrClabe (String value) {
    _cardOrClabe = value;
    notifyListeners(); //Notifica que hay que redibujar
  }

  bool isValidFormRegisterClabeCard(){
    return formRegisterClabeCard.currentState?.validate() ?? false;
  }

}