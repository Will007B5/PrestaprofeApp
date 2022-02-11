import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:prestaprofe/src/models/card_model.dart';

import 'package:prestaprofe/src/models/models.dart';

// verificar los permisos a internet. 
// Línea <uses-permission android:name="android.permission.INTERNET" /> en el archivo AndroidManifest.xml (de la carpeta main), 
// justo encima de <Application>.
// Luego ejecutar el comando flutter clean en la raíz del proyecto, y volver a generar el apk para probar.

class CardsService extends ChangeNotifier {

  // final String _baseUrl = '10.0.2.2:8000'; //10.0.2.2:8000 virtual emulador
  final String _baseUrl = 'app.prestaprofe.com'; //Produccion

  Future<Map<String, String>> _setHeaders({required bool authenticatedUser}) async {
    final Map<String, String> header = {
      'Content-Type' : 'application/json',
      'Accept' : 'application/json'
      // 'Authorization' : 'Bearer $token'
    };
    return header;
  }

  final List<CardModel> cards = [];

  bool isLoading = true;

  CardsService(){
    this.loadCards();
  }

  Future<List<CardModel>> loadCards() async {

    this.isLoading = true;
    notifyListeners();

    final url = Uri.https(_baseUrl, '/api/cards'); //Enviamos el cuerpo y los parametros

    final headers = await this._setHeaders(authenticatedUser: false);

    final resp = await http.get(url, headers: headers);

    final List cardsMap = json.decode( resp.body );

    cardsMap.forEach((element) {
      final tempCard = CardModel.fromMap(element);
      this.cards.add(tempCard);
    });

    this.isLoading = false;
    notifyListeners();

    print(this.cards);
    
    return this.cards;
  }

}