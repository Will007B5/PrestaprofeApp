import 'dart:convert';

class ErrorModel {
    ErrorModel({
        this.name,
        this.lastName,
        this.curp,
        this.address,
        this.phone,
        this.email,
        this.password,
        this.rfc,
        this.firstReferencePersonName,
        this.firstReferencePersonPhone,
        this.secondReferencePersonName,
        this.secondReferencePersonPhone,
        this.ine,
        this.ineBack,
        this.payStub,
        this.selfie,
        this.proofAddress,
        this.expiredDate
    });

    List<String>? name;
    List<String>? lastName;
    List<String>? curp;
    List<String>? address;
    List<String>? phone;
    List<String>? email;
    List<String>? password;
    List<String>? rfc;
    List<String>? firstReferencePersonName;
    List<String>? firstReferencePersonPhone;
    List<String>? secondReferencePersonName;
    List<String>? secondReferencePersonPhone;
    List<String>? ine;
    List<String>? ineBack;
    List<String>? payStub;
    List<String>? selfie;
    List<String>? proofAddress;
    List<String>? expiredDate;

    factory ErrorModel.fromJson(String str) => ErrorModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory ErrorModel.fromMap(Map<String, dynamic> json) => ErrorModel(
        name: json["name"] != null ? List<String>.from(json["name"].map((x) => x)) : null,
        lastName: json["last_name"] != null ? List<String>.from(json["last_name"].map((x) => x)) : null,
        curp: json["curp"] != null ? List<String>.from(json["curp"].map((x) => x)) : null,
        address: json["address"] != null ? List<String>.from(json["address"].map((x) => x)) : null,
        phone: json["phone"] != null ? List<String>.from(json["phone"].map((x) => x)) : null,
        email: json["email"] != null ? List<String>.from(json["email"].map((x) => x)) : null,
        password: json["password"] != null ? List<String>.from(json["password"].map((x) => x)) : null,
        rfc: json["rfc"] != null ? List<String>.from(json["rfc"].map((x) => x)) : null,
        firstReferencePersonName: json["first_reference_person_name"] != null ? List<String>.from(json["first_reference_person_name"].map((x) => x)) : null,
        firstReferencePersonPhone: json["first_reference_person_phone"] != null ? List<String>.from(json["first_reference_person_phone"].map((x) => x)) : null,
        secondReferencePersonName: json["second_reference_person_name"] != null ? List<String>.from(json["second_reference_person_name"].map((x) => x)) : null,
        secondReferencePersonPhone: json["second_reference_person_phone"] != null ? List<String>.from(json["second_reference_person_phone"].map((x) => x)) : null,
        ine: json["ine"] != null ? List<String>.from(json["ine"].map((x) => x)) : null,
        ineBack: json["ine_back"] != null ? List<String>.from(json["ine_back"].map((x) => x)) : null,
        payStub: json["pay_stub"] != null ? List<String>.from(json["pay_stub"].map((x) => x)) : null,
        selfie: json["selfie"] != null ? List<String>.from(json["selfie"].map((x) => x)) : null,
        proofAddress: json["proof_address"] != null ? List<String>.from(json["proof_address"].map((x) => x)) : null,
        expiredDate: json["expired_date"] != null ? List<String>.from(json["expired_date"].map((x) => x)) : null
    );

    Map<String, dynamic> toMap() => {
        "name": List<dynamic>.from(name?.map((x) => x) ?? []),
        "last_name": List<dynamic>.from(lastName?.map((x) => x) ?? []),
        "curp": List<dynamic>.from(curp?.map((x) => x) ?? []),
        "address": List<dynamic>.from(address?.map((x) => x) ?? []),
        "phone": List<dynamic>.from(phone?.map((x) => x) ?? []),
        "email": List<dynamic>.from(email?.map((x) => x) ?? []),
        "password": List<dynamic>.from(password?.map((x) => x) ?? []),
        "rfc": List<dynamic>.from(rfc?.map((x) => x) ?? []),
        "first_reference_person_name": List<dynamic>.from(firstReferencePersonName?.map((x) => x) ?? []),
        "first_reference_person_phone": List<dynamic>.from(firstReferencePersonPhone?.map((x) => x) ?? []),
        "second_reference_person_name": List<dynamic>.from(secondReferencePersonName?.map((x) => x) ?? []),
        "second_reference_person_phone": List<dynamic>.from(secondReferencePersonPhone?.map((x) => x) ?? []),
        "ine": List<dynamic>.from(ine?.map((x) => x) ?? []),
        "ine_back": List<dynamic>.from(ineBack?.map((x) => x) ?? []),
        "pay_stub": List<dynamic>.from(payStub?.map((x) => x) ?? []),
        "selfie": List<dynamic>.from(selfie?.map((x) => x) ?? []),
        "proof_address": List<dynamic>.from(proofAddress?.map((x) => x) ?? []),
        "expired_date": List<dynamic>.from(expiredDate?.map((x) => x) ?? [])
    };

    Map<String, dynamic> toMapErrorsText() => {
        "Nombre": List<dynamic>.from(name?.map((x) => x) ?? []),
        "Apellidos": List<dynamic>.from(lastName?.map((x) => x) ?? []),
        "CURP": List<dynamic>.from(curp?.map((x) => x) ?? []),
        "Dirección": List<dynamic>.from(address?.map((x) => x) ?? []),
        "Teléfono": List<dynamic>.from(phone?.map((x) => x) ?? []),
        "Email": List<dynamic>.from(email?.map((x) => x) ?? []),
        "Contraseña": List<dynamic>.from(password?.map((x) => x) ?? []),
        "RFC": List<dynamic>.from(rfc?.map((x) => x) ?? []),
        "Nombre Referencia 1": List<dynamic>.from(firstReferencePersonName?.map((x) => x) ?? []),
        "Teléfono Referencia 1": List<dynamic>.from(firstReferencePersonPhone?.map((x) => x) ?? []),
        "Nombre Referencia 2": List<dynamic>.from(secondReferencePersonName?.map((x) => x) ?? []),
        "Teléfono Referencia 2": List<dynamic>.from(secondReferencePersonPhone?.map((x) => x) ?? []),
        "INE Anverso": List<dynamic>.from(ine?.map((x) => x) ?? []),
        "INE Reverso": List<dynamic>.from(ineBack?.map((x) => x) ?? []),
        "Talón de cheque": List<dynamic>.from(payStub?.map((x) => x) ?? []),
        "Selfie": List<dynamic>.from(selfie?.map((x) => x) ?? []),
        "Comprobante de domicilio": List<dynamic>.from(proofAddress?.map((x) => x) ?? []),
        "Fecha de expiración": List<dynamic>.from(expiredDate?.map((x) => x) ?? [])
    };
}
