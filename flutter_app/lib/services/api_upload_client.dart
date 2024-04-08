import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_app/models/file/file_model.dart';
import 'package:flutter_app/services/api_constant.dart';
import 'package:flutter_app/services/api_upload_interface.dart';
import 'package:flutter_app/services/dio_client.dart';

class UploadRepository implements ApiUploadInterface {
  /// Stream controller
  // make it broadcast to allow multiple subscriptions
  final StreamController<Map<String, double>> progresses =
      StreamController.broadcast();
  // Temp map
  Map<String, double> map = {};

  @override
  Future uploadFile(FileModel file) async {
    map = {file.id.toString(): 0.0};
    progresses.sink.add(map);
    // CORRECT - START
    String fileName = file.file!.path.split('/').last;
    FormData formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(file.file!.path, filename: fileName),
      "type": file.uploadType
    });
    var response = await DioClient()
        .postMultiPart(ApiConstant.baseURL, ApiConstant.uploadURL, formData,
            (sent, total) async {
      map[file.id.toString()] = sent / total;
      progresses.sink.add(map);
    }, file.cancelToken);
    // CORRECT -END
    if (file.cancelToken.isCancelled) {
      throw Exception('CancelToken');
    }
    // Response result
    if (kDebugMode) {
      print(response);
    }
    return response['media']['id'];
  }

  @override
  Future uploadFile2(FileModel file) async {
    map = {file.id.toString(): 0.0};
    progresses.sink.add(map);
    // CORRECT - START
    String fileName = file.file!.path.split('/').last;
    FormData formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(file.file!.path, filename: fileName),
      "type": file.uploadType
    });
    var response = await DioClient()
        .postMultiPart(ApiConstant.baseURL, ApiConstant.uploadURL, formData,
            (sent, total) async {
      map[file.id.toString()] = sent / total;
      progresses.sink.add(map);
    }, file.cancelToken);
    // CORRECT -END
    if (file.cancelToken.isCancelled) {
      throw Exception('CancelToken');
    }
    // Response result
    if (kDebugMode) {
      print(response);
    }
    return response['media']['id'];
  }

  @override
  Future uploadFile3(FileModel file) async {
    map = {file.id.toString(): 0.0};
    progresses.sink.add(map);
    // CORRECT - START
    String fileName = file.file!.path.split('/').last;
    FormData formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(file.file!.path, filename: fileName),
      "type": file.uploadType
    });
    var response = await DioClient()
        .postMultiPart(ApiConstant.baseURL, ApiConstant.uploadURL, formData,
            (sent, total) async {
      map[file.id.toString()] = sent / total;
      progresses.sink.add(map);
    }, file.cancelToken);
    // CORRECT -END
    if (file.cancelToken.isCancelled) {
      throw Exception('CancelToken');
    }
    // Response result
    if (kDebugMode) {
      print(response);
    }
    return response['media']['id'];
  }
}
