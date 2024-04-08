import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_app/models/common/currency_model.dart';
import 'package:flutter_app/models/common/upload_file_model.dart';
import 'package:flutter_app/services/api_constant.dart';
import 'package:flutter_app/services/common/common_interface.dart';
import 'package:flutter_app/services/dio_client.dart';

class CommonRepository implements CommonInterface {
  static late CommonRepository _instance;

  CommonRepository._internal();

  static CommonRepository get instance {
    _instance = CommonRepository._internal();
    return _instance;
  }

  @override
  Future<UploadFileModel> uploadFile(
      {required UploadType type, required File file}) async {
    String fileName = file.path.split('/').last;

    final map = <String, dynamic>{};
    switch (type) {
      case UploadType.avatar:
        map['type'] = 'avatar';
        break;
      case UploadType.imgBackground:
        map['type'] = 'img_background';
        break;
      case UploadType.event:
        map['type'] = 'event';
        break;
      case UploadType.teamAvatar:
        map['type'] = 'team_avatar';
        break;
      case UploadType.teamBackground:
        map['type'] = 'team_background';
        break;
    }

    map['file'] = await MultipartFile.fromFile(
      file.path,
      filename: fileName,
    );

    var response =
        await DioClient().post(ApiConstant.upload, FormData.fromMap(map));

    return UploadFileModel.fromJson(response['media']);
  }

  @override
  Future<double> getChangeCurrency({required String query}) {
    // TODO: implement getChangeCurrency
    throw UnimplementedError();
  }

  @override
  Future<List<CurrencyModel>> getListCurrency() {
    // TODO: implement getListCurrency
    throw UnimplementedError();
  }
}
