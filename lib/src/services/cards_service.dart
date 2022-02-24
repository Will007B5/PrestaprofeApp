import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:prestaprofe/src/models/card_model.dart';

import 'package:prestaprofe/src/models/models.dart';
import 'package:prestaprofe/src/services/services.dart';

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

  bool _isSaving = false;

  bool get isSaving {
    return _isSaving;
  }

  set isSaving (bool value) {
    _isSaving = value;
    notifyListeners();
  }

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

  List<CardModel> filterUserCards(int userId){
    return this.cards.where((card) => card.userId == userId).toList();
  }

  Future<int> registerCardClabe(CardModel card) async {
    this._isSaving = true;
    this.notifyListeners();

    final url = Uri.https(_baseUrl, '/api/cards');

    final headers = await this._setHeaders(authenticatedUser: false);

    final resp = await http.post(url, headers: headers, body: card.toJson());

    if (resp.statusCode >= 200 && resp.statusCode < 299) {

      this.cards.add(CardModel.fromJson(resp.body));

      this._isSaving = false;
      this.notifyListeners();
      return 200;
    }

    this._isSaving = false;
    this.notifyListeners();
    String textErrors = 'ERROR\n\n';

    ErrorModel.fromJson(resp.body).toMapErrorsText().forEach((key, value) {
      if(value.length > 0){
        textErrors+='${key}: ${value[0]}';
      }
    });

    NotificationsService.showSnackbar('${textErrors}', 'error');
    return 400;
  }

}