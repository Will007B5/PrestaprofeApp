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
      final String token = await AuthService.readToken();
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
      'device_name' : DeviceInfoService.uniqueDeviceName
    };
    
    // final url = Uri.http(_baseUrl, '/api/login'); //Enviamos el cuerpo y los parametros
    final url = Uri.https(_baseUrl, '/api/mobilelogin'); //Enviamos el cuerpo y los parametros

    final headers = await this._setHeaders(authenticatedUser: false);

    final resp = await http.post(url, body: json.encode(authData), headers: headers);

    final Map<String, dynamic> decodedResp = json.decode(resp.body);


    //Actualizar el paquete para escribir en la storage
    if(decodedResp.containsKey('token')){
      //Borrar ultima sesión
      await deleteAllStorage();
      currentClient = ClientModel.fromMap(decodedResp['user']);
      await assignFCMTokenToUser(PushNotificationService.token); //Guarda el token de FCM generado en la bd al usuario logueado
      //Guardar token en secure storage
      await _storage.write(key: 'token', value: decodedResp['token']);
      await _storage.write(key: 'client', value: json.encode(currentClient.toMap()));
      return null;
    }
    else {
      String textErrors = '';
      if(decodedResp.containsKey('message')){
        textErrors = decodedResp['message'];
      }
      else if(decodedResp.containsKey('password')){
        textErrors = decodedResp['password'];
      }
      //print(ErrorModel.fromJson(resp.body));
      // ErrorModel.fromJson(resp.body).toMapErrorsText().forEach((key, value) {
      //   if (value.length > 0) {
      //     textErrors += '${value}';
      //   }
      // });
      return textErrors;
    }

  }

  //Metodo estatico para pasar el token y ejecutar la operacion en la instancia normal de clase AuthService
  static Future<void> passFCMTokenToAuthService(String? fcmToken) async {
    await AuthService().assignFCMTokenToUser(fcmToken);
  }

  //Se asigna el token de FCM al usuario
  Future<int> assignFCMTokenToUser (String? fcmToken) async {

    if(this.currentClient != null && fcmToken != null){
      final url = Uri.https(AuthService()._baseUrl, '/api/has-token-user/${this.currentClient.id}/$fcmToken'); //Enviamos el cuerpo y los parametros

      final headers = await AuthService()._setHeaders(authenticatedUser: true);

      final resp = await http.get(url, headers: headers);

      if (resp.statusCode >= 200 && resp.statusCode < 299) {
        this.currentClient.token = fcmToken;
        await _storage.write(key: 'client', value: json.encode(this.currentClient.toMap()));
        return 200;
      }
      else {
        return 400;
      }
    }

    return 400;

  }

  Future logout() async {
    //Verificar bien el cierre de sesión

    final url = Uri.https(_baseUrl, '/api/logout'); //Enviamos el cuerpo y los parametros

    final headers = await this._setHeaders(authenticatedUser: true);

    final resp = await http.post(url, headers: headers);

    await deleteAllStorage();

    // await _storage.delete(key: 'token');
    // await _storage.delete(key: 'client');
    return;
  }

  Future<void> deleteAllStorage() async {
    await _storage.deleteAll(); //Borra todo el espacio designado de storage en la app
  }

  static Future<String> readToken() async {
    final r = await AuthService()._storage.read(key: 'token');
    print('TOKEN: $r');
    return await AuthService()._storage.read(key: 'token') ?? '';
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