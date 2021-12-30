import 'dart:convert';

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
}
