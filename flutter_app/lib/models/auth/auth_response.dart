import 'package:flutter_app/constants/constant.dart';
import 'package:flutter_app/models/common/currency_model.dart';

class AuthResponse {
  String? token;
  bool? isEmailVerified;
  AuthResultData? data;

  AuthResponse({this.token, this.isEmailVerified, this.data});

  AuthResponse.fromJson(Map<String, dynamic> json) {
    token = json['token'] ?? '';
    isEmailVerified = json['is_email_verified'];
    data = json['data'] != null ? AuthResultData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['token'] = token;
    data['is_email_verified'] = isEmailVerified;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class AuthResultData {
  int? id;
  String? name;
  String? email;
  dynamic emailVerifiedAt;
  dynamic countryId;
  String? locale;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic deletedAt;
  String? firstName;
  String? lastName;
  String? status;
  dynamic gender;
  dynamic birthDate;
  String? phone;
  String? bio;
  String avatar = Constant.empty;
  String backgroundImg = Constant.empty;
  Country? country;
  CurrencyModel? currencyModel;

  AuthResultData(
      {this.id,
      this.name,
      this.email,
      this.emailVerifiedAt,
      this.countryId,
      this.locale,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.firstName,
      this.lastName,
      this.status,
      this.gender,
      this.birthDate,
      this.phone,
      this.avatar = Constant.empty,
      this.backgroundImg = Constant.empty,
      this.country,
      this.currencyModel,
      this.bio});

  AuthResultData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    locale = json['locale'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    status = json['status'];
    gender = json['gender'];
    birthDate = json['birth_date'];
    phone = json['phone_number'];
    countryId = json['country_id'];
    bio = json['bio'];
    avatar = json['avatar'] ?? Constant.empty;
    backgroundImg = json['img_background'] ?? Constant.empty;
    country =
        json['country'] != null ? Country.fromJson(json['country']) : null;
    currencyModel = json['currency'] != null
        ? CurrencyModel.fromJson(json['currency'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['email_verified_at'] = emailVerifiedAt;
    data['locale'] = locale;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['status'] = status;
    data['gender'] = gender;
    data['birth_date'] = birthDate;
    data['phone_number'] = phone;
    data['bio'] = bio;
    data['country_id'] = countryId;
    data['avatar'] = avatar;
    data['img_background'] = backgroundImg;
    if (country != null) {
      data['country'] = country!.toJson();
    }
    if (currencyModel != null) {
      data['currency'] = currencyModel!.toJson();
    }
    return data;
  }
}

class Country {
  int? id;
  String? name;
  String? code;
  String? phoneCode;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

  Country(
      {this.id,
      this.name,
      this.code,
      this.phoneCode,
      this.createdAt,
      this.updatedAt,
      this.deletedAt});

  Country.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
    phoneCode = json['phone_code'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['code'] = code;
    data['phone_code'] = phoneCode;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    return data;
  }
}
