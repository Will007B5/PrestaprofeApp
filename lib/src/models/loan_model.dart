import 'dart:convert';

class LoanModel {
    LoanModel({
        this.id,
        this.paymentReference,
        required this.amount,
        required this.paymentSchema,
        this.applicationDate,
        // this.paymentProof,
        // this.expiredDate,
        this.acceptedDate,
        this.frozenDate,
        required this.cardId,
        required this.userId
    });

    int? id;
    String? paymentReference;
    double amount; //debe ser int
    String paymentSchema;
    DateTime? applicationDate;
    // String? paymentProof;
    // DateTime? expiredDate;
    DateTime? acceptedDate;
    DateTime? frozenDate;
    int cardId;
    int userId;

    factory LoanModel.fromJson(String str) => LoanModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory LoanModel.fromMap(Map<String, dynamic> json) => LoanModel(
        id: json["id"],
        paymentReference: json["payment_reference"],
        amount: json["amount"].toDouble(),
        paymentSchema: json["payment_schema"],
        applicationDate: DateTime.parse(json["application_date"]),
        // paymentProof: json["payment_proof"],
        // expiredDate: DateTime.parse(json["expired_date"]),
        acceptedDate: DateTime.parse(json["accepted_date"]),
        frozenDate: json["frozen_date"],
        cardId: json["card_id"],
        userId: json["user_id"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "payment_reference": paymentReference,
        "amount": amount,
        "payment_schema": paymentSchema,
        // "application_date": applicationDate.toIso8601String(),
        // "payment_proof": paymentProof,
        // "expired_date": expiredDate.toIso8601String(),
        // "accepted_date": acceptedDate.toIso8601String(),
        "frozen_date": frozenDate,
        "card_id": cardId,
        "user_id": userId,
    };
}

