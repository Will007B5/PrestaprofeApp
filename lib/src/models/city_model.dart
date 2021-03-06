import 'dart:convert';

import 'package:prestaprofe/src/models/client_model.dart';

class CityModel {
    CityModel({
        required this.id,
        required this.name,
        required this.zipCode,
        required this.municipalityId,
    });

    int id;
    String name;
    String zipCode;
    int municipalityId;

    factory CityModel.fromJson(String str) => CityModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory CityModel.fromMap(Map<String, dynamic> json) => CityModel(
        id: json["id"],
        name: json["name"],
        zipCode: json["zip_code"],
        municipalityId: json["municipality_id"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "zip_code": zipCode,
        "municipality_id": municipalityId,
    };

    CityModel copyCity() => CityModel(
        id: this.id,
        name: this.name,
        zipCode: this.zipCode,
        municipalityId: this.municipalityId,
    );

    //Esto es para crear una copia limpia de la ciudad
    static CityModel cleanMunicipality() => new CityModel(
      id: 1, 
      name: 'Zona Centro', 
      zipCode: '20000', 
      municipalityId: 1
    );
}
