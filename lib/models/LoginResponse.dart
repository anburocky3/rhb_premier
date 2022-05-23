class LoginResponse {
  String? token;
  User? user;

  LoginResponse({this.token, this.user});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? accountNumber;
  String? firstname;
  String? lastname;
  String? username;
  String? email;
  String? countryCode;
  String? mobile;
  int? refBy;
  String? balance;
  String? image;
  Address? address;
  int? status;
  KycData? kycData;
  int? kycv;
  int? ev;
  int? sv;
  Null? verCode;
  Null? verCodeSendAt;
  int? ts;
  int? tv;
  Null? tsc;
  String? createdAt;
  String? updatedAt;

  User(
      {this.id,
      this.accountNumber,
      this.firstname,
      this.lastname,
      this.username,
      this.email,
      this.countryCode,
      this.mobile,
      this.refBy,
      this.balance,
      this.image,
      this.address,
      this.status,
      this.kycData,
      this.kycv,
      this.ev,
      this.sv,
      this.verCode,
      this.verCodeSendAt,
      this.ts,
      this.tv,
      this.tsc,
      this.createdAt,
      this.updatedAt});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    accountNumber = json['account_number'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    username = json['username'];
    email = json['email'];
    countryCode = json['country_code'];
    mobile = json['mobile'];
    refBy = json['ref_by'];
    balance = json['balance'];
    image = json['image'];
    address =
        json['address'] != null ? new Address.fromJson(json['address']) : null;
    status = json['status'];
    kycData = json['kyc_data'] != null
        ? new KycData.fromJson(json['kyc_data'])
        : null;
    kycv = json['kycv'];
    ev = json['ev'];
    sv = json['sv'];
    verCode = json['ver_code'];
    verCodeSendAt = json['ver_code_send_at'];
    ts = json['ts'];
    tv = json['tv'];
    tsc = json['tsc'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['account_number'] = this.accountNumber;
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['username'] = this.username;
    data['email'] = this.email;
    data['country_code'] = this.countryCode;
    data['mobile'] = this.mobile;
    data['ref_by'] = this.refBy;
    data['balance'] = this.balance;
    data['image'] = this.image;
    if (this.address != null) {
      data['address'] = this.address!.toJson();
    }
    data['status'] = this.status;
    if (this.kycData != null) {
      data['kyc_data'] = this.kycData!.toJson();
    }
    data['kycv'] = this.kycv;
    data['ev'] = this.ev;
    data['sv'] = this.sv;
    data['ver_code'] = this.verCode;
    data['ver_code_send_at'] = this.verCodeSendAt;
    data['ts'] = this.ts;
    data['tv'] = this.tv;
    data['tsc'] = this.tsc;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Address {
  String? country;
  String? city;
  String? zip;
  String? address;

  Address({this.country, this.city, this.zip, this.address});

  Address.fromJson(Map<String, dynamic> json) {
    country = json['country'];
    city = json['city'];
    zip = json['zip'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['country'] = this.country;
    data['city'] = this.city;
    data['zip'] = this.zip;
    data['address'] = this.address;
    return data;
  }
}

class KycData {
  Photo? photo;
  Photo? fullName;
  Photo? fatherSName;
  Photo? motherSName;
  Photo? nid;

  KycData(
      {this.photo,
      this.fullName,
      this.fatherSName,
      this.motherSName,
      this.nid});

  KycData.fromJson(Map<String, dynamic> json) {
    photo = json['photo'] != null ? new Photo.fromJson(json['photo']) : null;
    fullName = json['full_name'] != null
        ? new Photo.fromJson(json['full_name'])
        : null;
    fatherSName = json["father's_name"] != null
        ? new Photo.fromJson(json["father's_name"])
        : null;
    motherSName = json["mother's_name"] != null
        ? new Photo.fromJson(json["mother's_name"])
        : null;
    nid = json['nid'] != null ? new Photo.fromJson(json['nid']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.photo != null) {
      data['photo'] = this.photo!.toJson();
    }
    if (this.fullName != null) {
      data['full_name'] = this.fullName!.toJson();
    }
    if (this.fatherSName != null) {
      data["father's_name"] = this.fatherSName!.toJson();
    }
    if (this.motherSName != null) {
      data["mother's_name"] = this.motherSName!.toJson();
    }
    if (this.nid != null) {
      data['nid'] = this.nid!.toJson();
    }
    return data;
  }
}

class Photo {
  String? type;
  String? value;

  Photo({this.type, this.value});

  Photo.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['value'] = this.value;
    return data;
  }
}
//
// class KycData {
//   Photo? photo;
//   Photo? fullName;
//   Photo? fatherSName;
//   Photo? motherSName;
//   Photo? nid;
//
//   KycData({this.photo, this.fullName, this.fatherSName, this.motherSName, this.nid});
//
//   KycData.fromJson(Map<String, dynamic> json) {
//     photo = json['photo'] != null ? new Photo.fromJson(json['photo']) : null;
//     fullName = json['full_name'] != null ? new Photo.fromJson(json['full_name']) : null;
//     fatherSName = json["father's_name"] != null ? new Photo.fromJson(json["father's_name"]) : null;
//     motherSName = json["mother's_name"] != null ? new Photo.fromJson(json["mother's_name"]) : null;
//     nid = json['nid'] != null ? new Photo.fromJson(json['nid']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.photo != null) {
//       data['photo'] = this.photo!.toJson();
//     }
//     if (this.fullName != null) {
//       data['full_name'] = this.fullName!.toJson();
//     }
//     if (this.fatherSName != null) {
//       data["father's_name"] = this.fatherSName!.toJson();
//     }
//     if (this.motherSName != null) {
//       data["mother's_name"] = this.motherSName!.toJson();
//     }
//     if (this.nid != null) {
//       data['nid'] = this.nid!.toJson();
//     }
//     return data;
//   }
// }
