import 'dart:convert';
class ClientModel {
    ClientModel({
        this.id,
        required this.name,
        required this.lastName,
        this.birthDate,
        this.gender,
        this.civilStatus,
        this.curp,
        this.address,
        this.salaryId,
        this.phone,
        this.email,
        this.password,
        this.institutionId,
        this.rfc,
        this.firstReferencePersonName,
        this.firstReferencePersonPhone,
        this.secondReferencePersonName,
        this.secondReferencePersonPhone,
        this.active,
        this.cityId,
        this.jobId,
        this.ine,
        this.ineBack,
        this.payStub,
        this.selfie,
        this.proofAddress,
        this.type,
        this.isPhoneVerified,
        this.isAdmonVerified,
        this.token,
        this.tokens,
        this.updatedAt,
        this.createdAt
    });

    int? id;
    String name;
    String lastName;
    DateTime? birthDate;
    String? gender;
    String? civilStatus;
    String? curp;
    String? address;
    int? salaryId;
    String? phone;
    String? email;
    String? password;
    int? institutionId;
    String? rfc;
    String? firstReferencePersonName;
    String? firstReferencePersonPhone;
    String? secondReferencePersonName;
    String? secondReferencePersonPhone;
    int? active;
    int? cityId;
    int? jobId;
    String? ine;
    String? ineBack;
    String? payStub;
    String? selfie;
    String? proofAddress;
    String? type;
    int? isPhoneVerified;
    String? isAdmonVerified;
    String? token;
    List<String>? tokens;
    DateTime? updatedAt;
    DateTime? createdAt;

    factory ClientModel.fromJson(String str) => ClientModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory ClientModel.fromMap(Map<String, dynamic> json) => ClientModel(
        id: json["id"] ?? null,
        name: json["name"],
        lastName: json["last_name"],
        birthDate: json["birth_date"] == null ? null : DateTime.parse(json["birth_date"]),
        gender: json["gender"] ?? null,
        civilStatus: json["civil_status"] ?? null,
        curp: json["curp"] ?? null,
        address: json["address"] ?? null,
        salaryId: json["salary_id"] ?? null,
        phone: json["phone"] ?? null,
        email: json["email"] ?? null,
        password: json["password"] ?? null,
        institutionId: json["institution_id"] ?? null,
        rfc: json["rfc"] ?? null,
        firstReferencePersonName: json["first_reference_person_name"] ?? null,
        firstReferencePersonPhone: json["first_reference_person_phone"] ?? null,
        secondReferencePersonName: json["second_reference_person_name"] ?? null,
        secondReferencePersonPhone: json["second_reference_person_phone"] ?? null,
        active: json["active"] ?? null,
        cityId: json["city_id"] ?? null,
        jobId: json["job_id"] ?? null,
        ine: json["ine"] ?? null,
        ineBack: json["ine_back"] ?? null,
        payStub: json["pay_stub"] ?? null,
        selfie: json["selfie"] ?? null,
        proofAddress: json["proof_address"] ?? null,
        type: json["type"] ?? null,
        isPhoneVerified: json["isPhoneVerified"] ?? null,
        isAdmonVerified: json["isAdmonVerified"] ?? null,
        token: json["token"] ?? null,
        tokens: json["tokens"] != null ? List<String>.from(json["tokens"].map((x) => x)) : null
        // updatedAt: DateTime.parse(json["updated_at"]),
        // createdAt: DateTime.parse(json["created_at"])
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "last_name": lastName,
        "birth_date": "${birthDate?.year.toString().padLeft(4, '0')}-${birthDate?.month.toString().padLeft(2, '0')}-${birthDate?.day.toString().padLeft(2, '0')}",
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
        "token": token,
        "tokens": List<dynamic>.from(tokens?.map((x) => x) ?? [])
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
      token: this.token,
      tokens: this.tokens,
      updatedAt: this.updatedAt,
      createdAt: this.updatedAt
    );

    //Esto es para crear una copia limpia del cliente
    static ClientModel cleanClient() => new ClientModel(
      name: '',
      lastName: '',
      birthDate: DateTime.now(),
      gender: 'Hombre',
      civilStatus: 'Soltero/a',
      curp: '',
      address: '',
      salaryId: 1,
      phone: '',
      email: '',
      password: '',
      rfc: '',
      firstReferencePersonName: '',
      firstReferencePersonPhone: '',
      secondReferencePersonName: '',
      secondReferencePersonPhone: '',
      cityId: 1,
      jobId: 1,
      ine: '',
      ineBack: '',
      payStub: '',
      selfie: '',
      proofAddress: ''
    );
}
