import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// verificar los permisos a internet. 
// Línea <uses-permission android:name="android.permission.INTERNET" /> en el archivo AndroidManifest.xml (de la carpeta main), 
// justo encima de <Application>.
// Luego ejecutar el comando flutter clean en la raíz del proyecto, y volver a generar el apk para probar.

class AuthService extends ChangeNotifier {

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
  Future<String?> createUser ({required String name, required String lastName, required String birthDate, required String gender, required String civilStatus, required String curp, required String address, required String institutionId, required String type, required String salaryId, required String phone, required String email}) async {

    final Map<String, dynamic> authData = {
      'name'           : name, //'required|string|max:255',
      'last_name'      : lastName, //'required|string|max:255',
      'birth_date'     : birthDate, //'required|date',
      'gender'         : gender, //'required|in:Hombre,Mujer',
      'civil_status'   : civilStatus, //'required|in:Soltero/a,Casado/a,Divorciado/a,Separacion en proceso judicial,Viudo/a,Concubinato',
      'curp'           : curp, //'string|size:13',
      'address'        : address, //'required|max:255',
      'institution_id' : institutionId, //'required|exists:institutions,id',
      'type'           : type, //'required|string',
      'salary_id'      : salaryId, //'required|exists:salaries,id',
      'phone'          : phone, //'required|string|max:15',
      'email'          : email //'required|string|email|max:255|unique:users'
    };

    final url = Uri.http(_baseUrl, '/api/register'); //Enviamos el cuerpo y los parametros

    final headers = await this._setHeaders(authenticatedUser: false);

    final resp = await http.post(url, body: json.encode(authData), headers: headers);

    final Map<String, dynamic> decodedResp = json.decode(resp.body);

    if(decodedResp.containsKey('idToken')){
      return null;
    }
    else{
      return 'Ocurrio un error al crear el usuario';
    }

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
      await _storage.write(key: 'token', value: decodedResp['token']);
      return null;
    }
    else{
      return 'Credenciales incorrectas';
    }

  }

  Future logout() async {
    // await storage.deleteAll(); //Borra todo el espacio designado de storage en la app

    final url = Uri.http(_baseUrl, '/api/logout'); //Enviamos el cuerpo y los parametros

    final headers = await this._setHeaders(authenticatedUser: true);

    final resp = await http.post(url, headers: headers);

    await _storage.delete(key: 'token');
    return;
  }

  Future<String> readToken() async {
    return await _storage.read(key: 'token') ?? '';
  }

}