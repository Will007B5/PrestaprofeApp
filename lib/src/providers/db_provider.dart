import 'dart:io'; //Propia de Flutter/Dart

import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';//Paquete que importamos en el pubspect.yaml
import 'package:sqflite/sqflite.dart';

import 'package:prestaprofe/src/models/models.dart';

class DBProvider {

  static Database? _database;
  static final DBProvider db = DBProvider._(); //DBProvider._() es un constructor privado

  DBProvider._();

  Future<Database?> get database async {
    if(_database != null) return _database;

    _database = await initDB();

    return _database;

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


  Future<List<StateModel?>> getTodosLosScans() async {

    final db = await database;
    final res = await db!.query('states');
    final ff = res.map((state) => StateModel.fromMap(state)).toList();
    print(ff[0].toMap());
    //Hasta aquí, por si solo 'res' retorna una lista (List<Map<String, Object?>>)
    //Se debe transformar res pasandolo por un mapa y este resultado convertirlo a una lista de StateModel (devuelve 'Instance of StateModel')
    return res.isNotEmpty ? res.map((state) => StateModel.fromMap(state)).toList() : [];
    
  }


}