import 'package:flutter/cupertino.dart';
// import 'package:flutter_app/models/common/country_model.dart';
// import 'package:flutter_app/models/common/sport_model.dart';
import 'package:flutter_app/models/file/file_model.dart';

class SetupAccountModel {
  TextEditingController? firstNameController = TextEditingController();
  TextEditingController? lastNameController = TextEditingController();
  TextEditingController? emailController = TextEditingController();
  TextEditingController? passwordController = TextEditingController();
  GenderModel? gender;
  String? birthDay;
  // CountryModel? country;
  TextEditingController? phoneController = TextEditingController();
  String? phoneCode;
  String? phoneCodeId;
  bool? agree;
  FileModel? avatar;
  // List<SportModel>? listSports;
  bool isSocial = false;

  SetupAccountModel(
      {this.firstNameController,
      this.lastNameController,
      this.gender,
      this.birthDay,
      // this.country,
      this.phoneController,
      this.avatar,
      // this.listSports,
      this.phoneCode = '',
      this.phoneCodeId = '163',
      this.isSocial = false,
      this.agree = false});
}

class GenderModel {
  String? value;
  String? id;

  GenderModel({this.value, this.id});
}
