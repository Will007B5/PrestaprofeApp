import 'dart:convert';

class MunicipalityModel {
    MunicipalityModel({
        required this.id,
        required this.name,
        required this.code,
        required this.stateId,
    });

    int id;
    String name;
    String code;
    int stateId;

    factory MunicipalityModel.fromJson(String str) => MunicipalityModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory MunicipalityModel.fromMap(Map<String, dynamic> json) => MunicipalityModel(
        id: json["id"],
        name: json["name"],
        code: json["code"],
        stateId: json["state_id"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "code": code,
        "state_id": stateId,
    };

    //Esto es para crear una copia limpia del municipio
    static MunicipalityModel cleanMunicipality() => new MunicipalityModel(
      id: 1, 
      name: 'Aguascalientes', 
      code: '001', 
      stateId: 1
    );
}
