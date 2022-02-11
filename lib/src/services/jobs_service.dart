import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:prestaprofe/src/models/models.dart';

// verificar los permisos a internet. 
// Línea <uses-permission android:name="android.permission.INTERNET" /> en el archivo AndroidManifest.xml (de la carpeta main), 
// justo encima de <Application>.
// Luego ejecutar el comando flutter clean en la raíz del proyecto, y volver a generar el apk para probar.

class JobsService extends ChangeNotifier {

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

  final List<JobModel> jobs = [];

  bool isLoading = true;

  JobsService(){
    this.loadJobs();
  }

  Future<List<JobModel>> loadJobs() async {

    this.isLoading = true;
    notifyListeners();

    final url = Uri.https(_baseUrl, '/api/jobs'); //Enviamos el cuerpo y los parametros

    final headers = await this._setHeaders(authenticatedUser: false);

    final resp = await http.get(url, headers: headers);

    final List jobsMap = json.decode( resp.body );

    jobsMap.forEach((element) {
      final tempJob = JobModel.fromMap(element);
      this.jobs.add(tempJob);
    });

    this.isLoading = false;
    notifyListeners();
    
    return this.jobs;
  }

}