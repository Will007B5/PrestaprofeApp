import 'dart:async';

import 'package:flutter/material.dart';

import 'package:internet_connection_checker/internet_connection_checker.dart';

class InternetService extends ChangeNotifier{

  InternetConnectionChecker internetConnectionChecker = InternetConnectionChecker(); //Esta es una clase singleton; la misma instancia estará disponible en toda la app
  late StreamSubscription _internetStream;
  late bool _hasInternet;

  StreamSubscription get internetStream => _internetStream;

  bool get hasInternet => _hasInternet;

  set internetStream(StreamSubscription value){
    _internetStream = value;
  }

  StreamSubscription<InternetConnectionStatus> onStatusChange (){
    return internetConnectionChecker.onStatusChange.listen((status) {
      _hasInternet = status == InternetConnectionStatus.connected;
      notifyListeners();
      print('El estado de la conexión es: $hasInternet');
    });
  }

  closeInternetStream(){
    _internetStream.cancel(); //Los streams siempre hay que cancelarlos debido a que si no se hace, siguen recibiendo informacion despues de terminanda la app
  }

}

// class InternetServiceChangeNotifier extends ChangeNotifier {
//   bool hasInternet = false;
//   onChangeInternetState(bool state){
//     this.hasInternet = state;
//     notifyListeners();
//   }
// }