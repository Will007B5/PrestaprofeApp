import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:async/async.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as fileextension;
import 'package:provider/provider.dart';

import 'package:prestaprofe/src/helpers/helpers.dart';
import 'package:prestaprofe/src/models/models.dart';
import 'package:prestaprofe/src/providers/providers.dart';
import 'package:prestaprofe/src/services/services.dart';

// verificar los permisos a internet.
// Línea <uses-permission android:name="android.permission.INTERNET" /> en el archivo AndroidManifest.xml (de la carpeta main),
// justo encima de <Application>.
// Luego ejecutar el comando flutter clean en la raíz del proyecto, y volver a generar el apk para probar.

class ClientsService extends ChangeNotifier {
  // final String _baseUrl = '10.0.2.2:8000'; //10.0.2.2:8000 virtual emulador
  final String _baseUrl = 'app.prestaprofe.com'; //Produccion

  Future<Map<String, String>> _setHeaders(
      {required bool authenticatedUser}) async {
    final Map<String, String> header = {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
      // 'Authorization' : 'Bearer $token'
    };
    return header;
  }

  final List<ClientModel> clients = [];
  late ClientModel
      currentClient; //late; hasta que se va a utilizar tiene un valor (todos los objetos pasan por referencia)
  final double _kilobyteConstant = 0.001;
  final double _megabyteConstant = 0.000001;

  final debouncer = Debouncer(duration: Duration(milliseconds: 800));

  String _localReceivedOtp = '';
  bool _isLoading = true;
  bool _isSaving = false;
  bool _isValidOtp = true;
  File? _newIneFile; //Puede ser pdf o imagen
  File? _newIneBackFile; //Puede ser pdf o imagen
  File? _newSelfieFile; //Puede ser pdf o imagen
  File? _newProofAddressFile; //Puede ser pdf o imagen
  File? _newPayStubFile; //Puede ser pdf o imagen

  ClientsService() {
    this.loadClients();
  }

  bool get isSaving {
    return _isSaving;
  }

  set isSaving(bool value) {
    _isSaving = value;
    notifyListeners(); //Notifica que hay que redibujar
  }

  bool get isValidOtp {
    return _isValidOtp;
  }

  set isValidOtp(bool value) {
    _isValidOtp = value;
    notifyListeners(); //Notifica que hay que redibujar
  }

  bool get isLoading {
    return _isLoading;
  }

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners(); //Notifica que hay que redibujar
  }

  Future<List<ClientModel>> loadClients() async {
    this._isLoading = true;
    notifyListeners();

    final url = Uri.https(
        _baseUrl, '/api/getClients'); //Enviamos el cuerpo y los parametros

    final headers = await this._setHeaders(authenticatedUser: false);

    final resp = await http.get(url, headers: headers);

    final List clientsMap = json.decode(resp.body);

    clientsMap.forEach((element) {
      final tempClient = ClientModel.fromMap(element);
      this.clients.add(tempClient);
    });

    this._isLoading = false;
    notifyListeners();

    return this.clients;
  }

  Future saveOrCreateClient(ClientModel client) async {
    this._isSaving = true;
    notifyListeners();

    if (client.id == null) {
      await this.createClient(client);
    } else {
      await this.updateClient(client);
    }

    this._isSaving = false;
    notifyListeners();
  }

  double roundDouble(double value, int places) {
    double mod = pow(10.0, places).toDouble();
    return ((value * mod).round().toDouble() / mod);
  }

  Future<double> getFileSizeInMegabytes(String path) async {
    final file = File.fromUri(Uri(path: path));
    final int size = await file.length();
    final double result = roundDouble(size.toDouble() * _megabyteConstant, 2);
    print('Bytes - ${size.toDouble().toString()}');
    return result;
  }

  void cleanFileImages() {
    this._newIneFile = null;
    this._newIneBackFile = null;
    this._newSelfieFile = null;
    this._newProofAddressFile = null;
    this._newPayStubFile = null;
  }

  void updateImagesPreview(String imageType, String path) async {
    //Este método solo actualiza la imagen de manera local para ser visualizada. No la sube a ningun lugar externo
    final fileSizeInMegabytes = await getFileSizeInMegabytes(path);
    print('Megabytes - ${fileSizeInMegabytes.toString()}');
    if (fileSizeInMegabytes < 4.95) {
      if (imageType == 'ine') {
        this.currentClient.ine = path;
        this._newIneFile = File.fromUri(Uri(path: path));
      }
      if (imageType == 'ineBack') {
        this.currentClient.ineBack = path;
        this._newIneBackFile = File.fromUri(Uri(path: path));
      } else if (imageType == 'selfie') {
        this.currentClient.selfie = path;
        this._newSelfieFile = File.fromUri(Uri(path: path));
      } else if (imageType == 'proofAddress') {
        this.currentClient.proofAddress = path;
        this._newProofAddressFile = File.fromUri(Uri(path: path));
      } else if (imageType == 'payStub') {
        this.currentClient.payStub = path;
        this._newPayStubFile = File.fromUri(Uri(path: path));
      }
    } else {
      NotificationsService.showSnackbar(
          'No se puede subir un archivo superior a 5MB', 'error');
    }
    notifyListeners();
  }

  Future<String> updateClient(ClientModel client) async {
    final url = Uri.https(_baseUrl, '/api/users/${client.id}');
    final headers = await this._setHeaders(authenticatedUser: false);
    final resp = await http.put(url, headers: headers, body: client.toJson());
    final decodedData = json.decode(resp.body);
    final index = this.clients.indexWhere((element) => element.id == client.id);
    this.clients[index] = client;
    return '';
  }

  Future<int> createClient(ClientModel client) async {
    if (this._newIneFile == null ||
        this._newSelfieFile == null ||
        this._newIneBackFile == null ||
        this._newProofAddressFile == null ||
        this._newPayStubFile == null) {
      NotificationsService.showSnackbar(
          'Verifique el apartado ADJUNTAR ARCHIVOS e intente de nuevo',
          'error');
      return 400;
    }

    this._isSaving = true;
    this.notifyListeners();

    final url = Uri.parse('https://app.prestaprofe.com/api/create-client');
    final packageUpload = http.MultipartRequest('POST', url);
    packageUpload.fields['name'] = client.name.trim();
    packageUpload.fields['last_name'] = client.lastName.trim();
    packageUpload.fields['birth_date'] =
        client.birthDate.toString().substring(0, 10);
    packageUpload.fields['gender'] = client.gender!;
    packageUpload.fields['civil_status'] = client.civilStatus!;
    packageUpload.fields['curp'] = client.curp!.trim();
    packageUpload.fields['address'] = client.address!.trim();
    packageUpload.fields['salary_id'] = client.salaryId.toString();
    packageUpload.fields['phone'] = client.phone!;
    packageUpload.fields['email'] = client.email!;
    packageUpload.fields['password'] = client.password as String;
    packageUpload.fields['rfc'] = client.rfc!.trim();

    final streamIneFile = new http.ByteStream(this._newIneFile!.openRead());
    streamIneFile.cast();
    final lengthIneFile = await this._newIneFile!.lengthSync();
    final multipartIneFile = new http.MultipartFile(
        'ine', streamIneFile, lengthIneFile,
        filename: fileextension.basename(this._newIneFile!.path));
    packageUpload.files.add(multipartIneFile);

    final streamIneBackFile =
        new http.ByteStream(this._newIneBackFile!.openRead());
    streamIneBackFile.cast();
    final lengthIneBackFile = await this._newIneBackFile!.lengthSync();
    final multipartIneBackFile = new http.MultipartFile(
        'ine_back', streamIneBackFile, lengthIneBackFile,
        filename: fileextension.basename(this._newIneBackFile!.path));
    packageUpload.files.add(multipartIneBackFile);

    final streamPayStubFile =
        new http.ByteStream(this._newPayStubFile!.openRead());
    streamPayStubFile.cast();
    final lengthPayStubFile = await this._newPayStubFile!.lengthSync();
    final multipartPayStubFile = new http.MultipartFile(
        'pay_stub', streamPayStubFile, lengthPayStubFile,
        filename: fileextension.basename(this._newPayStubFile!.path));
    packageUpload.files.add(multipartPayStubFile);

    final streamSelfieFile =
        new http.ByteStream(this._newSelfieFile!.openRead());
    streamSelfieFile.cast();
    final lengthSelfieFile = await this._newSelfieFile!.lengthSync();
    final multipartSelfieFile = new http.MultipartFile(
        'selfie', streamSelfieFile, lengthSelfieFile,
        filename: fileextension.basename(this._newSelfieFile!.path));
    packageUpload.files.add(multipartSelfieFile);

    final streamProofAddressFile =
        new http.ByteStream(this._newProofAddressFile!.openRead());
    streamProofAddressFile.cast();
    final lengthProofAddressFile =
        await this._newProofAddressFile!.lengthSync();
    final multipartProofAddressFile = new http.MultipartFile(
        'proof_address', streamProofAddressFile, lengthProofAddressFile,
        filename: fileextension.basename(this._newProofAddressFile!.path));
    packageUpload.files.add(multipartProofAddressFile);

    packageUpload.fields['first_reference_person_name'] =
        client.firstReferencePersonName!.trim();
    packageUpload.fields['first_reference_person_phone'] =
        client.firstReferencePersonPhone!;
    packageUpload.fields['second_reference_person_name'] =
        client.secondReferencePersonName!.trim();
    packageUpload.fields['second_reference_person_phone'] =
        client.secondReferencePersonPhone!;
    packageUpload.fields['city_id'] = client.cityId.toString();
    packageUpload.fields['job_id'] = client.jobId.toString();
    final headers = await this._setHeaders(authenticatedUser: false);
    final streamResponse = await packageUpload.send();
    final resp = await http.Response.fromStream(streamResponse);

    if (resp.statusCode >= 200 && resp.statusCode < 299) {
      final decodedResp = json.decode(resp.body);

      print(decodedResp);

      client.id = decodedResp['id'];
      this.currentClient.id = client.id;

      this.clients.add(client);

      NotificationsService.showSnackbar(
          '¡Ha sido registrado correctamente!', 'success');

      print(client.id.toString());

      this._isSaving = false;
      this.notifyListeners();
      return 200;
    }

    String textErrors = 'REVISE ESTOS CAMPOS E INTENTE DE NUEVO\n\n';

    ErrorModel.fromJson(resp.body).toMapErrorsText().forEach((key, value) {
      if (value.length > 0) {
        textErrors += '${key}, ';
      }
    });

    this._isSaving = false;
    this.notifyListeners();

    NotificationsService.showSnackbar(
        '${textErrors.substring(0, textErrors.length - 2)}', 'error');
    return 400;
  }

  Future<int> sendSmsToClient(ClientModel client) async {
    if (client.id != null && client.phone?.length == 10) {
      this._isSaving = true;
      this.notifyListeners();

      final url =
          Uri.https(_baseUrl, '/api/get-verification-code/${client.phone}');

      final headers = await this._setHeaders(authenticatedUser: false);

      final resp = await http.get(url, headers: headers);

      final Map<String, dynamic> decodedResp = json.decode(resp.body);

      if (decodedResp.containsKey('verification_code')) {
        _localReceivedOtp = decodedResp['verification_code'];
        print('CODIGO: ${_localReceivedOtp}');
      }

      this._isSaving = false;
      this.notifyListeners();

      NotificationsService.showSnackbar(
          'El mensaje SMS llegará en cualquier momento', 'success');
      return 200;
    }

    return 400;
  }

  Future<int> verifyClient(
      ClientModel client, BuildContext context, String otpCode) async {
    if (client.id != null) {
      this._isSaving = true;
      this.notifyListeners();

      if (otpCode != '' && otpCode == _localReceivedOtp) {
        final url = Uri.https(
            _baseUrl, '/api/change-verification-phone-status/${client.id}');

        final headers = await this._setHeaders(authenticatedUser: false);

        final resp = await http.get(url, headers: headers);

        this._isSaving = false;
        this._isValidOtp = true;
        _localReceivedOtp = '';
        this.notifyListeners();

        NotificationsService.showSnackbar(
            'El telefóno se verificó con éxito. ', 'success');
        Navigator.of(context)
            .pushNamedAndRemoveUntil('login', (Route<dynamic> route) => false);

        return 200;
      }

      this._isSaving = false;
      this._isValidOtp = false;
      this.notifyListeners();
    }
    return 400;
  }

  //Intenta verificar al cliente cuando se deja de escribir por un tiempo
  Future<int> debouncerWaitOtpCode(
      List<String> query, BuildContext context, ClientModel client) async {
    debouncer.value = ['', '', '', ''];
    debouncer.onValue = (value) async {
      if (!query.any((otpNum) => otpNum == '')) {
        print('YA HAY DEBOUNCE: ${query}');
        final joinedOtpQuery = query.join("");
        print('Joined OTP: ${joinedOtpQuery}');
        final results =
            await this.verifyClient(client, context, joinedOtpQuery);
      }
    };

    final timer = Timer.periodic(Duration(milliseconds: 600), (_) {
      debouncer.value = query;
    });

    Future.delayed(Duration(milliseconds: 601)).then((_) => timer.cancel());
    return 200;
  }
}
