import 'dart:io';

import 'package:flutter_app/models/common/currency_model.dart';
import 'package:flutter_app/models/common/upload_file_model.dart';

enum UploadType { avatar, imgBackground, event, teamAvatar, teamBackground }

abstract class CommonInterface {
  Future<List<CurrencyModel>> getListCurrency();

  Future<UploadFileModel> uploadFile(
      {required UploadType type, required File file});

  Future<double> getChangeCurrency({required String query});
}
