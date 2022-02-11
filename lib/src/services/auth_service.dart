import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:prestaprofe/src/models/models.dart';
import 'package:prestaprofe/src/providers/providers.dart';
import 'package:prestaprofe/src/services/services.dart';

// verificar los permisos a internet. 
// Línea <uses-permission android:name="android.permission.INTERNET" /> en el archivo AndroidManifest.xml (de la carpeta main), 
// justo encima de <Application>.
// Luego ejecutar el comando flutter clean en la raíz del proyecto, y volver a generar el apk para probar.

class AuthService extends ChangeNotifier {

  late ClientModel currentClient;

  // final String _baseUrl = '10.0.2.2:8000'; //10.0.2.2:8000 virtual emulador
  final String _baseUrl = 'app.prestaprofe.com'; //Produccion

  final _storage = new FlutterSecureStorage();

  Future<Map<String, String>> _setHeaders({required bool authenticatedUser}) async {
    final Map<String, String> header = {
      'Content-Type' : 'application/json',
      'Accept' : 'application/json'
      // 'Authorization' : 'Bearer $token'
    };
    if(authenticatedUser){
      final String token = await this.readToken();
      if(token != ''){
        header['Authorization'] = 'Bearer $token';
      }
    }
    return header;
  }

  //Si retornamos algo es un error, si no todo bien
  Future<String?> login (String email, String password) async {

    final Map<String, dynamic> authData = {
      'email'       : email,
      'password'    : password,
      'device_name' : 'MiA1'
    };
    
    // final url = Uri.http(_baseUrl, '/api/login'); //Enviamos el cuerpo y los parametros
    final url = Uri.https(_baseUrl, '/api/mobilelogin'); //Enviamos el cuerpo y los parametros

    final headers = await this._setHeaders(authenticatedUser: false);

    final resp = await http.post(url, body: json.encode(authData), headers: headers);

    final Map<String, dynamic> decodedResp = json.decode(resp.body);


    //Actualizar el paquete para escribir en la storage
    if(decodedResp.containsKey('token')){
      //Guardar token en secure storage
      print(decodedResp['user']);
      await _storage.write(key: 'token', value: decodedResp['token']);
      await _storage.write(key: 'client', value: json.encode(decodedResp['user']));
      currentClient = ClientModel.fromMap(decodedResp['user']);
      print(currentClient);
      return null;
    }
    else{
      return 'Credenciales incorrectas';
    }

  }

  Future logout() async {
    //Verificar bien el cierre de sesión
    // await storage.deleteAll(); //Borra todo el espacio designado de storage en la app

    final url = Uri.https(_baseUrl, '/api/logout'); //Enviamos el cuerpo y los parametros

    final headers = await this._setHeaders(authenticatedUser: true);

    final resp = await http.post(url, headers: headers);

    await _storage.delete(key: 'token');
    await _storage.delete(key: 'client');
    return;
  }

  Future<String> readToken() async {
    return await _storage.read(key: 'token') ?? '';
  }

  Future<int> assignCurrentClient() async{
    final client = await _storage.read(key: 'client');
    if(client != null){
      this.currentClient = ClientModel.fromMap(json.decode(client));
      return 200;
    }
    else{
      return 400;
    }
  }

}