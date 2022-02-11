import 'dart:convert';
class ClientModel {
    ClientModel({
        this.id,
        required this.name,
        required this.lastName,
        required this.birthDate,
        required this.gender,
        required this.civilStatus,
        required this.curp,
        required this.address,
        required this.salaryId,
        required this.phone,
        required this.email,
        this.password,
        this.institutionId,
        required this.rfc,
        required this.firstReferencePersonName,
        required this.firstReferencePersonPhone,
        required this.secondReferencePersonName,
        required this.secondReferencePersonPhone,
        this.active,
        required this.cityId,
        required this.jobId,
        required this.ine,
        required this.ineBack,
        required this.payStub,
        required this.selfie,
        required this.proofAddress,
        this.type,
        this.isPhoneVerified,
        this.isAdmonVerified,
        this.updatedAt,
        this.createdAt
    });

    int? id;
    String name;
    String lastName;
    DateTime birthDate;
    String gender;
    String civilStatus;
    String curp;
    String address;
    int salaryId;
    String phone;
    String email;
    String? password;
    int? institutionId;
    String rfc;
    String firstReferencePersonName;
    String firstReferencePersonPhone;
    String secondReferencePersonName;
    String secondReferencePersonPhone;
    int? active;
    int cityId;
    int jobId;
    String ine;
    String ineBack;
    String payStub;
    String selfie;
    String proofAddress;
    String? type;
    int? isPhoneVerified;
    String? isAdmonVerified;
    DateTime? updatedAt;
    DateTime? createdAt;

    factory ClientModel.fromJson(String str) => ClientModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory ClientModel.fromMap(Map<String, dynamic> json) => ClientModel(
        id: json["id"] ?? null,
        name: json["name"],
        lastName: json["last_name"],
        birthDate: DateTime.parse(json["birth_date"]),
        gender: json["gender"],
        civilStatus: json["civil_status"],
        curp: json["curp"],
        address: json["address"],
        salaryId: json["salary_id"],
        phone: json["phone"],
        email: json["email"],
        password: json["password"] ?? null,
        institutionId: json["institution_id"] ?? null,
        rfc: json["rfc"],
        firstReferencePersonName: json["first_reference_person_name"],
        firstReferencePersonPhone: json["first_reference_person_phone"],
        secondReferencePersonName: json["second_reference_person_name"],
        secondReferencePersonPhone: json["second_reference_person_phone"],
        active: json["id"] ?? 0,
        cityId: json["city_id"],
        jobId: json["job_id"],
        ine: json["ine"] == null ? '' : json["ine"],
        ineBack: json["ine_back"] == null ? '' : json["ine_back"],
        payStub: json["pay_stub"],
        selfie: json["selfie"],
        proofAddress: json["proof_address"],
        type: json["type"] ?? null,
        isPhoneVerified: json["isPhoneVerified"] ?? 0,
        isAdmonVerified: json["isAdmonVerified"] ?? '',
        // updatedAt: DateTime.parse(json["updated_at"]),
        // createdAt: DateTime.parse(json["created_at"])
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "last_name": lastName,
        "birth_date": "${birthDate.year.toString().padLeft(4, '0')}-${birthDate.month.toString().padLeft(2, '0')}-${birthDate.day.toString().padLeft(2, '0')}",
        "gender": gender,
        "civil_status": civilStatus,
        "curp": curp,
        "address": address,
        "salary_id": salaryId,
        "phone": phone,
        "email": email,
        "password": password,
        "institution_id": institutionId,
        "rfc": rfc,
        "first_reference_person_name": firstReferencePersonName,
        "first_reference_person_phone": firstReferencePersonPhone,
        "second_reference_person_name": secondReferencePersonName,
        "second_reference_person_phone": secondReferencePersonPhone,
        "active": active,
        "city_id": cityId,
        "job_id": jobId,
        "ine": ine,
        "ine_back": ineBack,
        "pay_stub": payStub,
        "selfie": selfie,
        "proof_address": proofAddress,
        "type": type,
        "isPhoneVerified": isPhoneVerified,
        "isAdmonVerified": isAdmonVerified,
        // "updated_at": updatedAt!.toIso8601String(),
        // "created_at": createdAt!.toIso8601String()
    };

    //Esto es para evitar modificacion de objeto principal por referencias
    ClientModel copyClient() => ClientModel(
      id: this.id,
      name: this.name,
      lastName: this.lastName,
      birthDate: this.birthDate,
      gender: this.gender,
      civilStatus: this.civilStatus,
      curp: this.curp,
      address: this.address,
      salaryId: this.salaryId,
      phone: this.phone,
      email: this.email,
      password: this.password,
      institutionId: this.institutionId,
      rfc: this.rfc,
      firstReferencePersonName: this.firstReferencePersonName,
      firstReferencePersonPhone: this.firstReferencePersonPhone,
      secondReferencePersonName: this.secondReferencePersonName,
      secondReferencePersonPhone: this.secondReferencePersonPhone,
      active: this.active,
      cityId: this.cityId,
      jobId: this.jobId,
      ine: this.ine,
      ineBack: this.ineBack,
      payStub: this.payStub,
      selfie: this.selfie,
      proofAddress: this.proofAddress,
      type: this.type,
      isPhoneVerified: this.isPhoneVerified,
      isAdmonVerified: this.isAdmonVerified,
      updatedAt: this.updatedAt,
      createdAt: this.updatedAt
    );
}
