import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_app/services/api_constant.dart';
import 'package:flutter_app/services/app_exceptions.dart';
import 'package:flutter_app/services/custom_log_interceptor.dart';
import 'package:flutter_app/shared_pref_services.dart';

class DioClient {
  // Time out duration 20s
  static const int timeOutDuration = 20000;

  static final Dio _dio = Dio();

  static final Dio _dioFormData = Dio();

  static Future<Dio> initService() async {
    final sPref = await SharedPreferencesService.instance;
    final token = sPref.token;
    _dio
      ..options.baseUrl = ApiConstant.baseURL
      ..options.connectTimeout = timeOutDuration
      ..options.receiveTimeout = timeOutDuration
      ..options.headers = {
        "Content-Type": "application/json",
        "Accept": "application/json",
      };

    _dioFormData
      ..options.baseUrl = ApiConstant.baseURL
      ..options.connectTimeout = timeOutDuration
      ..options.receiveTimeout = timeOutDuration
      ..options.headers = {
        "Accept": "application/json",
      };
    if (kDebugMode) {
      _dio.interceptors.add(CustomLogInterceptor());
      _dioFormData.interceptors.add(CustomLogInterceptor());
    }
    if (token.isNotEmpty) {
      DioClient.setToken(token);
    }
    return _dio;
  }

  static void setToken(String token) {
    _dio.options.headers['Authorization'] = "Bearer $token";
    _dioFormData.options.headers['Authorization'] = "Bearer $token";
  }

  static void logOut() {
    _dio.interceptors.clear();
    _dio.options.headers.remove('Authorization');

    _dioFormData.interceptors.clear();
    _dioFormData.options.headers.remove('Authorization');
  }

  //GET
  Future<dynamic> get(String api) async {
    try {
      var response = await _dio.get(ApiConstant.baseURL + api);
      return _processResponse(response);
    } on DioError catch (e) {
      if (DioErrorType.receiveTimeout == e.type ||
          DioErrorType.connectTimeout == e.type) {
        throw ApiNotRespondingException('API not responded in time', api);
      } else if (DioErrorType.sendTimeout == e.type) {
        throw FetchDataException('No Internet connection', api);
      } else if (DioErrorType.response == e.type) {
        // 4xx 5xx response
        // throw exception...
        throw NotFoundException('${e.response?.data['message']}', api);
      } else if (DioErrorType.other == e.type) {
        if (e.message.contains('SocketException')) {
          throw 'No internet connection';
        } else if (e.message.contains('Unhandled Exception')) {
          throw NotFoundException('Not found exception', api);
        }
      } else if (DioErrorType.cancel == e.type) {
        throw CancelRequestException('Cancel Request', api);
      } else {
        throw Exception("Problem connecting to the server. Please try again.");
      }
    }
  }

  // DELETE
  Future<dynamic> delete(String api, {dynamic payloads}) async {
    try {
      var response =
          await _dio.delete(ApiConstant.baseURL + api, data: payloads);
      return _processResponse(response);
    } on DioError catch (e) {
      if (DioErrorType.receiveTimeout == e.type ||
          DioErrorType.connectTimeout == e.type) {
        throw ApiNotRespondingException('API not responded in time', api);
      } else if (DioErrorType.sendTimeout == e.type) {
        throw FetchDataException('No Internet connection', api);
      } else if (DioErrorType.response == e.type) {
        // 4xx 5xx response
        // throw exception...
        throw NotFoundException('${e.response?.data['message']}', api);
      } else if (DioErrorType.other == e.type) {
        if (e.message.contains('SocketException')) {
          throw 'No internet connection';
        } else if (e.message.contains('Unhandled Exception')) {
          throw NotFoundException('${e.response?.data}', api);
        }
      } else if (DioErrorType.cancel == e.type) {
        throw CancelRequestException('Cancel Request', api);
      } else {
        throw Exception("Problem connecting to the server. Please try again.");
      }
    }
  }

  //GET
  Future<dynamic> getPlace(String search) async {
    try {
      var response = await _dio.get(
          'https://api.openrouteservice.org/geocode/autocomplete?api_key=5b3ce3597851110001cf6248e36667337ad04929a46235b966c6f25c&text=$search');
      return _processResponse(response);
      // ignore: empty_catches
    } on DioError {}
  }

  //POST
  Future<dynamic> post(String api, dynamic payloadObj) async {
    var payload = payloadObj;
    if (payloadObj is! FormData) {
      payload = json.encode(payloadObj);
    }
    try {
      var response = await _dio.post(ApiConstant.baseURL + api, data: payload);
      return _processResponse(response);
    } on DioError catch (e) {
      if (DioErrorType.receiveTimeout == e.type ||
          DioErrorType.connectTimeout == e.type) {
        throw ApiNotRespondingException('API not responded in time', api);
      } else if (DioErrorType.sendTimeout == e.type) {
        throw FetchDataException('No Internet connection', api);
      } else if (DioErrorType.response == e.type) {
        // 4xx 5xx response
        // throw exception...
        throw NotFoundException('${e.response?.data['message']}', api);
      } else if (DioErrorType.other == e.type) {
        if (e.message.contains('SocketException')) {
          throw 'No internet connection';
        } else if (e.message.contains('Unhandled Exception')) {
          throw NotFoundException('${e.error} : ${e.response?.data}', api);
        }
      } else if (DioErrorType.cancel == e.type) {
        throw CancelRequestException('Cancel Request', api);
      } else {
        throw Exception("Problem connecting to the server. Please try again.");
      }
    }
  }

  //POST WITH FORM-DATA
  Future<dynamic> postFormData(String api, dynamic payloadObj) async {
    try {
      final dio = _dioFormData
        ..options.contentType = Headers.formUrlEncodedContentType;
      var response =
          await dio.post(ApiConstant.baseURL + api, data: payloadObj);
      return _processResponse(response);
    } on DioError catch (e) {
      if (DioErrorType.receiveTimeout == e.type ||
          DioErrorType.connectTimeout == e.type) {
        throw ApiNotRespondingException('API not responded in time', api);
      } else if (DioErrorType.sendTimeout == e.type) {
        throw FetchDataException('No Internet connection', api);
      } else if (DioErrorType.response == e.type) {
        // 4xx 5xx response
        // throw exception...
        throw NotFoundException('${e.response?.data['message']}', api);
      } else if (DioErrorType.other == e.type) {
        if (e.message.contains('SocketException')) {
          throw 'No internet connection';
        } else if (e.message.contains('Unhandled Exception')) {
          throw NotFoundException('${e.response?.data}', api);
        }
      } else if (DioErrorType.cancel == e.type) {
        throw CancelRequestException('Cancel Request', api);
      } else {
        throw Exception("Problem connecting to the server. Please try again.");
      }
    }
  }

  //POST - MultiPart
  Future<dynamic> postMultiPart(String baseUrl, String api, FormData formData,
      Function(int, int) onSendProgress, CancelToken cancelToken) async {
    try {
      var response = await _dio.post(baseUrl + api,
          data: formData,
          onSendProgress: onSendProgress,
          cancelToken: cancelToken);
      return _processResponse(response);
    } on DioError catch (e) {
      if (DioErrorType.receiveTimeout == e.type ||
          DioErrorType.connectTimeout == e.type) {
        throw ApiNotRespondingException('API not responded in time', api);
      } else if (DioErrorType.sendTimeout == e.type) {
        throw FetchDataException('No Internet connection', api);
      } else if (DioErrorType.response == e.type) {
        if (e.response?.statusCode == 413) {
          throw FileTooLargeException('File too large');
        }
        // 4xx 5xx response
        // throw exception...
        throw NotFoundException('${e.response?.data['message']}', api);
      } else if (DioErrorType.other == e.type) {
        if (e.message.contains('SocketException')) {
          throw 'No internet connection';
        } else if (e.message.contains('Unhandled Exception')) {
          throw NotFoundException('Not found exception', api);
        }
      } else if (DioErrorType.cancel == e.type) {
        throw CancelRequestException('Cancel Request', api);
      } else {
        throw Exception("Problem connecting to the server. Please try again.");
      }
    }
  }

  // OTHER
  dynamic _processResponse(response) {
    switch (response.statusCode) {
      case 200:
      case 201:
        return response.data;
      case 400:
        throw BadRequestException(
            utf8.decode(response.bodyBytes), response.request!.url.toString());
      case 401:
      case 403:
        throw UnAuthorizedException(
            utf8.decode(response.bodyBytes), response.request!.url.toString());
      case 404:
        throw BadRequestException(
            utf8.decode(response.bodyBytes), response.request!.url.toString());
      case 413:
        throw FileTooLargeException(utf8.decode(response.bodyBytes));
      case 500:
      default:
        throw FetchDataException(
            'Error occurred with code : ${response.statusCode}',
            response.request!.url.toString());
    }
  }

  //PUT
  Future<dynamic> put(String api, dynamic payloadObj) async {
    var payload = payloadObj;
    if (payloadObj is! FormData) {
      payload = json.encode(payloadObj);
    }
    try {
      var response = await _dio
          .put(ApiConstant.baseURL + api, data: payload)
          .timeout(const Duration(seconds: timeOutDuration));
      return _processResponse(response);
    } on DioError catch (e) {
      if (DioErrorType.receiveTimeout == e.type ||
          DioErrorType.connectTimeout == e.type) {
        throw ApiNotRespondingException('API not responded in time', api);
      } else if (DioErrorType.sendTimeout == e.type) {
        throw FetchDataException('No Internet connection', api);
      } else if (DioErrorType.response == e.type) {
        // 4xx 5xx response
        // throw exception...
        throw NotFoundException('${e.error}', api);
      } else if (DioErrorType.other == e.type) {
        if (e.message.contains('SocketException')) {
          throw 'No internet connection';
        } else if (e.message.contains('Unhandled Exception')) {
          throw NotFoundException('Not found exception', api);
        }
      } else if (DioErrorType.cancel == e.type) {
        throw CancelRequestException('Cancel Request', api);
      } else {
        throw Exception("Problem connecting to the server. Please try again.");
      }
    }
  }

  Future<dynamic> patch(String api, dynamic payloadObj) async {
    var payload = payloadObj;
    if (payloadObj is! FormData) {
      payload = json.encode(payloadObj);
    }
    try {
      var response = await _dio
          .patch(ApiConstant.baseURL + api, data: payload)
          .timeout(const Duration(seconds: timeOutDuration));
      return _processResponse(response);
    } on DioError catch (e) {
      if (DioErrorType.receiveTimeout == e.type ||
          DioErrorType.connectTimeout == e.type) {
        throw ApiNotRespondingException('API not responded in time', api);
      } else if (DioErrorType.sendTimeout == e.type) {
        throw FetchDataException('No Internet connection', api);
      } else if (DioErrorType.response == e.type) {
        // 4xx 5xx response
        // throw exception...
        throw NotFoundException('${e.response?.data['message']}', api);
      } else if (DioErrorType.other == e.type) {
        if (e.message.contains('SocketException')) {
          throw 'No internet connection';
        } else if (e.message.contains('Unhandled Exception')) {
          throw NotFoundException('Not found exception', api);
        }
      } else if (DioErrorType.cancel == e.type) {
        throw CancelRequestException('Cancel Request', api);
      } else {
        throw Exception("Problem connecting to the server. Please try again.");
      }
    }
  }
}
