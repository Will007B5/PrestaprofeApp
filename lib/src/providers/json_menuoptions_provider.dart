import 'package:flutter/services.dart' show rootBundle; //Para leer JSON; solo quiero el rootBundle
import 'dart:convert';

class _JsonMenuOptionsProvider{

  Map<dynamic, dynamic> _options = {};

  _JsonMenuOptionsProvider(); //Constructor vacío

  void loadOptions() async{

    final response = await rootBundle.loadString('jsondata/options.json');

    Map dataMap = json.decode(response);
    _options = dataMap;
  }

  Map<dynamic, dynamic> get getMenuOptions {
    return _options;
  }
}

final jsonMenuOptionsProvider = new _JsonMenuOptionsProvider();