import 'dart:convert';

class CardModel {
    CardModel({
        this.id,
        this.cardNumber,
        this.expiredDate,
        this.active,
        required this.userId,
        this.clabe,
    });

    int? id;
    String? cardNumber;
    DateTime? expiredDate;
    int? active;
    int userId;
    int? clabe;

    factory CardModel.fromJson(String str) => CardModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory CardModel.fromMap(Map<String, dynamic> json) => CardModel(
        id: json["id"],
        cardNumber: json["card_number"],
        expiredDate: json["expired_date"],
        active: json["active"],
        userId: json["user_id"],
        clabe: json["clabe"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "card_number": cardNumber,
        "expired_date": expiredDate,
        "active": active,
        "user_id": userId,
        "clabe": clabe,
    };
}


