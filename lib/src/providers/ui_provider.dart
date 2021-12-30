
import 'package:flutter/material.dart';
//CLASE DE PRUEBA
//Se extiende de ChangeNotifier para poder usar el notifyListeners
class UiProvider extends ChangeNotifier {
  int _selectedMenuOpt = 0;

  int get selectedMenuOpt {
    return this._selectedMenuOpt;
  }

  set selectedMenuOpt(int i) {
    this._selectedMenuOpt = i;
    notifyListeners(); //Notifica a todos los widgets que estén escuchando el cambio del setter
  }

}