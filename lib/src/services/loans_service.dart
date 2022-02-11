import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:prestaprofe/src/models/card_model.dart';

import 'package:prestaprofe/src/models/models.dart';

// verificar los permisos a internet. 
// Línea <uses-permission android:name="android.permission.INTERNET" /> en el archivo AndroidManifest.xml (de la carpeta main), 
// justo encima de <Application>.
// Luego ejecutar el comando flutter clean en la raíz del proyecto, y volver a generar el apk para probar.

class LoansService extends ChangeNotifier {

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

  final List<LoanModel> loans = [];
  late LoanModel currentLoan;

  bool isLoading = true;

  LoansService(){
    this.loadLoans();
  }

  Future<List<LoanModel>> loadLoans() async {

    this.isLoading = true;
    notifyListeners();

    final url = Uri.https(_baseUrl, '/api/loans'); //Enviamos el cuerpo y los parametros

    final headers = await this._setHeaders(authenticatedUser: false);

    final resp = await http.get(url, headers: headers);

    final Map<String, dynamic> decodedResp = json.decode(resp.body);

    final List loansMap = decodedResp['data'];

    loansMap.forEach((element) {
      final tempLoan = LoanModel.fromMap(element);
      this.loans.add(tempLoan);
    });

    this.isLoading = false;
    notifyListeners();

    print(this.loans);
    
    return this.loans;
  }

  Future<int> createLoans(LoanModel loans) async {

    this.isLoading = true;
    notifyListeners();

    final url = Uri.https(_baseUrl, '/api/loans'); //Enviamos el cuerpo y los parametros

    final headers = await this._setHeaders(authenticatedUser: false);

    final resp = await http.post(url, headers: headers, body: loans.toJson());

    final decodedData = resp.body;

    print(decodedData);
    
    return 200;
  }

  Future<int> updateReference(String reference, LoanModel loans) async {

    this.isLoading = true;
    notifyListeners();

    final url = Uri.https(_baseUrl, '/api/loans/${loans.id}'); //Enviamos el cuerpo y los parametros

    final headers = await this._setHeaders(authenticatedUser: false);
    
    Map data = {
    'payment_reference': reference
    };

    final resp = await http.put(url, headers: headers, body: json.encode(data));

    final decodedData = resp.body;

    print(decodedData);
    
    this.isLoading = false;
    notifyListeners();
    return 200;
  }

}