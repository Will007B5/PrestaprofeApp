// To parse this JSON data, do
//
//     final salaryModel = salaryModelFromMap(jsonString);
import 'dart:convert';

class SalaryModel {
    SalaryModel({
      required this.id,
      required this.range,
    });

    int id;
    String range;

    factory SalaryModel.fromJson(String str) => SalaryModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory SalaryModel.fromMap(Map<String, dynamic> json) => SalaryModel(
        id: json["id"],
        range: json["range"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "range": range,
    };
}
