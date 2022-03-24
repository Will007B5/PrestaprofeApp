import 'dart:convert';

class StateModel {
    StateModel({
        required this.id,
        required this.name,
        required this.code,
    });

    int id;
    String name;
    String code;

    factory StateModel.fromJson(String str) => StateModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory StateModel.fromMap(Map<String, dynamic> json) => StateModel(
        id: json["id"],
        name: json["name"],
        code: json["code"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "code": code,
    };

    StateModel copyState() => StateModel(
        id: this.id,
        name: this.name,
        code: this.code,
    );

    //Esto es para crear una copia limpia del estado
    static StateModel cleanState() => new StateModel(
      id: 1, 
      name: 'Aguascalientes', 
      code: '01'
    );
}
