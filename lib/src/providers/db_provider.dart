import 'dart:io'; //Propia de Flutter/Dart
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';//Paquete que importamos en el pubspect.yaml
import 'package:prestaprofe/src/helpers/helpers.dart';
import 'package:prestaprofe/src/providers/providers.dart';
import 'package:sqflite/sqflite.dart';

import 'package:prestaprofe/src/models/models.dart';

class DBProvider extends ChangeNotifier{

  static Database? _database;

  List<StateModel> statesList = [];
  List<MunicipalityModel> municipalitiesList = [];
  List<CityModel> citiesList = [];

  bool _isLoading = true;

  StateModel currentState;
  MunicipalityModel currentMunicipality;
  CityModel currentCity;

  final debouncer = Debouncer(
    duration: Duration(milliseconds: 500)
  );

  DBProvider(this.currentState, this.currentMunicipality, this.currentCity){
    this.loadPresets();
  }

  bool get isLoading {
    return _isLoading;
  }

  Future<Database?> get database async {
    if(_database != null) return _database;

    _database = await initDB();

    return _database;

  }

  Future<int> loadPresets() async {
    await this.loadStates();
    await this.loadMunicipalities();
    await this.loadCities();
    this._isLoading = false;
    notifyListeners();
    return 200;
  }

  Future<Database?> initDB() async {
    //Path de donde almacenaremos la base de datos
    Directory documentsDirectory = await getApplicationDocumentsDirectory(); //getApplicationDocumentsDirectory() es propio de path_provider, paquete que instalamos
    final path = join(documentsDirectory.path, 'prestaprofedbsqlite.db');
    
    // Copiar la base de datos de los assets
    final ByteData data = await rootBundle.load(join('assets', 'database', 'prestaprofedbsqlite.db'));
    final List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    // Sobreescribir donde se almacenara temporalmente la base de datos
    await File(path).writeAsBytes(bytes, flush: true);

    //Abrir la base de datos
    return await openDatabase(path);

  }


  Future<List<StateModel?>> loadStates() async {

    final db = await database;
    final res = await db!.query('states', orderBy: 'name ASC');
    if(res.isNotEmpty){
      //Hasta aquí, por si solo 'res' retorna una lista (List<Map<String, Object?>>)
      //Se debe transformar res pasandolo por un mapa y este resultado convertirlo a una lista de StateModel (devuelve 'Instance of StateModel')
      this.statesList = res.map((state) => StateModel.fromMap(state)).toList();
      return this.statesList;
    }
    else{
      return [];
    }    
  }

  Future<List<MunicipalityModel?>> loadMunicipalities() async {
    final stateId = 1;
    final db = await database;
    final res = await db!.query('municipalities', where: 'state_id = ?', whereArgs: [stateId], orderBy: 'name ASC');
    if(res.isNotEmpty){
      //Hasta aquí, por si solo 'res' retorna una lista (List<Map<String, Object?>>)
      //Se debe transformar res pasandolo por un mapa y este resultado convertirlo a una lista de StateModel (devuelve 'Instance of StateModel')
      this.municipalitiesList = res.map((municipality) => MunicipalityModel.fromMap(municipality)).toList();
      return this.municipalitiesList;
    }
    else{
      return [];
    }    
  }

  Future<List<CityModel?>> loadCities() async {
    final municipalityId = 1;
    final db = await database;
    final res = await db!.query('cities', where: 'municipality_id = ?', whereArgs: [municipalityId], orderBy: 'name ASC');
    if(res.isNotEmpty){
      //Hasta aquí, por si solo 'res' retorna una lista (List<Map<String, Object?>>)
      //Se debe transformar res pasandolo por un mapa y este resultado convertirlo a una lista de StateModel (devuelve 'Instance of StateModel')
      this.citiesList = res.map((city) => CityModel.fromMap(city)).toList();
      return this.citiesList;
    }
    else{
      return [];
    }    
  }

  Future<int> chargePresetsFromStateDropdown(int stateId) async {
    final db = await database;
    final res = await db!.query('municipalities', where: 'state_id = ?', whereArgs: [stateId], orderBy: 'name ASC');
    if(res.isNotEmpty){
      //Hasta aquí, por si solo 'res' retorna una lista (List<Map<String, Object?>>)
      //Se debe transformar res pasandolo por un mapa y este resultado convertirlo a una lista de StateModel (devuelve 'Instance of StateModel')
      this.municipalitiesList = res.map((municipality) => MunicipalityModel.fromMap(municipality)).toList();
      this.currentMunicipality.id = this.municipalitiesList[0].id;
      this.currentMunicipality.name = this.municipalitiesList[0].name;
      this.currentMunicipality.code = this.municipalitiesList[0].code;
      this.currentMunicipality.stateId = this.municipalitiesList[0].stateId;
      final db2 = await database;
      final res2 = await db2!.query('cities', where: 'municipality_id = ?', whereArgs: [this.municipalitiesList[0].id], orderBy: 'name ASC');
      if(res2.isNotEmpty){
        this.citiesList = res2.map((city) => CityModel.fromMap(city)).toList();
        this.currentCity.id = this.citiesList[0].id;
        this.currentCity.name = this.citiesList[0].name;
        this.currentCity.zipCode = this.citiesList[0].zipCode;
        this.currentCity.municipalityId = this.municipalitiesList[0].id;
        notifyListeners();
        return 200;
      }
      else{
        return 400;
      }
    }
    else{
      return 400;
    }    
  }

  Future<int> chargePresetsFromMunicipalityDropdown(int municipalityId) async {
    final db = await database;
    final res = await db!.query('cities', where: 'municipality_id = ?', whereArgs: [municipalityId], orderBy: 'name ASC');
    if(res.isNotEmpty){
      //Hasta aquí, por si solo 'res' retorna una lista (List<Map<String, Object?>>)
      //Se debe transformar res pasandolo por un mapa y este resultado convertirlo a una lista de StateModel (devuelve 'Instance of StateModel')
      this.citiesList = res.map((city) => CityModel.fromMap(city)).toList();
      this.currentCity.id = this.citiesList[0].id;
      this.currentCity.name = this.citiesList[0].name;
      this.currentCity.zipCode = this.citiesList[0].zipCode;
      this.currentCity.municipalityId = this.municipalitiesList[0].id;
      notifyListeners();
      return 200;
    }
    else{
      return 400;
    }    
  }

  void chargeZipCodeFromCityDropdow(int cityId) {
    final index = this.citiesList.indexWhere((city) => city.id == cityId);
    this.currentCity = this.citiesList[index];
  }

  Future<int> chargePresetsFromZipCode(String zipCode) async {
    final db = await database;
    final res = await db!.query('cities', where: 'zip_code = ?', whereArgs: [zipCode], limit: 1);
    if(res.isNotEmpty){
      CityModel resCity = res.map((city) => CityModel.fromMap(city)).toList()[0];
      final db2= await database;
      final res2 = await db2!.query('cities', where: 'municipality_id = ?', whereArgs: [resCity.municipalityId], orderBy: 'name ASC');
      if(res2.isNotEmpty){
        this.citiesList = res2.map((city) => CityModel.fromMap(city)).toList();
        this.currentCity = resCity;
        final db3 = await database;
        final res3 = await db3!.query('municipalities', where: 'id = ?', whereArgs: [this.currentCity.municipalityId.toString()], limit: 1);
        if(res3.isNotEmpty){
          MunicipalityModel resMunicipality = res3.map((municipality) => MunicipalityModel.fromMap(municipality)).toList()[0];
          final db4 = await database;
          final res4 = await db4!.query('municipalities', where: 'state_id = ?', whereArgs: [resMunicipality.stateId], orderBy: 'name ASC');
          if(res4.isNotEmpty){
            this.municipalitiesList = res4.map((municipality) => MunicipalityModel.fromMap(municipality)).toList();
            this.currentMunicipality = resMunicipality;
            final db5 = await database;
            final res5 = await db5!.query('states', where: 'id = ?', whereArgs: [this.currentMunicipality.stateId], limit: 1);
            if(res5.isNotEmpty){
              StateModel resState = res5.map((state) => StateModel.fromMap(state)).toList()[0];
              this.currentState = resState;
              notifyListeners();
              return 200;
            }
            else{
              return 400;
            }
          }
          else{
            return 400;
          }
        }
        else{
          return 400;
        }
      }
      else{
        return 400;
      }
    }
    else{
      print('no');
      return 400;
    }    
  }

  //Mete el query al stream cuando el usuario deja de escribir
  Future<int> getSuggestionsByQuery(String searchTerm) async{
    debouncer.value = '';
    debouncer.onValue = (value) async {
      if(value.toString().length == 5){
        final results = await this.chargePresetsFromZipCode(value);
      }
    };

    final timer = Timer.periodic(Duration(milliseconds: 300), (_) {
      debouncer.value = searchTerm;
    });

    Future.delayed(Duration(milliseconds: 301)).then((_) => timer.cancel());
    return 200;
  }


}