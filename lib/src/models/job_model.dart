// To parse this JSON data, do
//
//     final jobsModel = jobsModelFromMap(jsonString);
import 'dart:convert';

class JobModel {
    JobModel({
      required this.id,
      required this.name,
      required this.description,
    });

    int id;
    String name;
    String description;

    factory JobModel.fromJson(String str) => JobModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory JobModel.fromMap(Map<String, dynamic> json) => JobModel(
        id: json["id"],
        name: json["name"],
        description: json["description"] ?? '',
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "description": description,
    };
}
