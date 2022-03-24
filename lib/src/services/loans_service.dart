import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:prestaprofe/src/models/card_model.dart';

import 'package:prestaprofe/src/models/models.dart';
import 'package:prestaprofe/src/services/auth_service.dart';
import 'package:prestaprofe/src/services/services.dart';

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
    if(authenticatedUser){
      final String token = await AuthService.readToken();
      if(token != ''){
        header['Authorization'] = 'Bearer $token';
      }
    }
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

    final headers = await this._setHeaders(authenticatedUser: true);

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

  Future<int> createLoans(LoanModel loans, {required int idUser}) async {

    this.isLoading = true;
    notifyListeners();

    loans.userId = idUser;

    final url = Uri.https(_baseUrl, '/api/loans'); //Enviamos el cuerpo y los parametros

    final headers = await this._setHeaders(authenticatedUser: true);

    final resp = await http.post(url, headers: headers, body: loans.toJson());

    final decodedData = json.decode(resp.body);

    this.loans.add(LoanModel.fromMap(decodedData['data']));


    this.isLoading = false;
    notifyListeners();

    NotificationsService.showSnackbar('¡Su préstamo se ha generado correctamente!', 'success');
    
    return 200;
  }

  Future<int> updateReference(String reference, LoanModel loans) async {

    this.isLoading = true;
    notifyListeners();

    final url = Uri.https(_baseUrl, '/api/loans/${loans.id}'); //Enviamos el cuerpo y los parametros

    final headers = await this._setHeaders(authenticatedUser: true);
    
    Map data = {
    'payment_reference': reference
    };

    final resp = await http.put(url, headers: headers, body: json.encode(data));

    final decodedData = json.decode(resp.body);

    print(decodedData);

    final tempLoan = LoanModel.fromMap(decodedData['data']);

    final indexLoan = this.loans.indexWhere((loan) => loan.id == tempLoan.id);

    if(indexLoan > 0){
      this.loans[indexLoan].paymentReference = tempLoan.paymentReference;
    }
    
    this.isLoading = false;
    notifyListeners();

    NotificationsService.showSnackbar('¡Su referencia ha sido generada!', 'success');

    return 200;
  }

}