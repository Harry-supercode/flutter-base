import 'dart:async';
import 'dart:math' as math;

import 'package:flutter_app/constants/constant.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_app/components/dialogs/alert_dialog.dart';
import 'package:flutter_app/models/file/file_model.dart';
import 'package:flutter_app/main.dart';
import 'package:flutter_app/utils/log_utils.dart';
import 'package:flutter_app/services/app_exceptions.dart';
import 'package:flutter_app/services/api_upload_client.dart';

abstract class BaseBlocCustom<Event, State> extends Bloc<Event, State> {
  BaseBlocCustom(super.initialState);

  /// HANDLE ERROR EXCEPTION
  /// [BadRequestException] will throw when bad request
  /// [FetchDataException]  will throw when occurred exception during fetching data
  /// [ApiNotRespondingException] Server not responding or sending timeout
  /// [NotFoundException] will throw when URL not found
  /// [TimeoutException] will throw when request timeout
  /// [CancelRequestException] will throw when user cancel request
  /// [SocialLoginException] will throw when something went wrong with social login
  /// [FileTooLargeException] will throw when user upload file size too large
  ///
  String handleError(error) {
    if (error is BadRequestException) {
      return LogUtils().i('${error.message} - URL: ${error.url}');
    } else if (error is FetchDataException) {
      return LogUtils().i('${error.message} - URL: ${error.url}');
    } else if (error is ApiNotRespondingException) {
      return LogUtils().i('${error.message} - URL: ${error.url}');
    } else if (error is NotFoundException) {
      AlertPopup(title: 'Error', msg: error.message ?? 'Failed')
          .showAlertPopup(navigatorKey.currentState!.overlay!.context);
      return LogUtils().i('${error.message} - URL: ${error.url}');
    } else if (error is TimeoutException) {
      return LogUtils()
          .i('${error.message.toString()} - URL: ${error.duration.toString()}');
    } else if (error is CancelRequestException) {
      return LogUtils().i('${error.message.toString()} - URL: ${error.url}');
    } else if (error is SocialLoginException) {
      return LogUtils().i('${error.message.toString()} - Failed: $error');
    } else if (error is FileTooLargeException) {
      AlertPopup(title: 'Error', msg: '${error.message}')
          .showAlertPopup(navigatorKey.currentState!.overlay!.context);
      return LogUtils().i('${error.message.toString()} - Failed: $error');
    } else {
      return error.toString();
    }
  }

  /// Handle upload file in queue
  ///
  /// @param files - List [FileModel]
  /// @param apiCall - [UploadRepository] class
  uploadFilesInQueue(List<FileModel> files, UploadRepository apiCall) async {
    for (var file in files) {
      file.status = UploadStatus.uploading;
    }
    if (files.length >= Constant.queuePageSize) {
      await Future.wait([
        apiCall.uploadFile(files[0]).then((value) => files[0].idMedia = value,
            onError: (e) => onErrorUpload(e, files[0])),
        apiCall.uploadFile2(files[1]).then((value) => files[1].idMedia = value,
            onError: (e) => onErrorUpload(e, files[1])),
        apiCall.uploadFile3(files[2]).then((value) => files[2].idMedia = value,
            onError: (e) => onErrorUpload(e, files[2]))
      ]);
    } else if (files.length == 2) {
      await Future.wait([
        apiCall.uploadFile(files[0]).then((value) => files[0].idMedia = value,
            onError: (e) => onErrorUpload(e, files[0])),
        apiCall.uploadFile2(files[1]).then((value) => files[1].idMedia = value,
            onError: (e) => onErrorUpload(e, files[1])),
      ]);
    } else {
      await Future.wait([
        apiCall.uploadFile(files[0]).then((value) => files[0].idMedia = value,
            onError: (e) => onErrorUpload(e, files[0])),
      ]);
    }
  }

  /// Handle error for [UploadFile] only
  /// This will update file status and
  /// handle throw error
  onErrorUpload(err, FileModel file) {
    file.status = UploadStatus.tooLarge;
    throw err;
  }

  /// Get list in each queue (for get range list until end)
  ///
  /// @param list - List [FileModel]
  /// @param page - Page for pagination
  getQueue(List<FileModel> list, int page) {
    // Return empty list if page smaller or equals zero
    if (page <= 0) return [];
    // Get start position
    int start = (page - 1) * Constant.queuePageSize;

    // Return empty list if start position larger than list size
    if (list.length <= start) return [];

    // Return new list with range after pagination
    return list
        .getRange(start, math.min(start + Constant.queuePageSize, list.length))
        .toList();
  }
}
