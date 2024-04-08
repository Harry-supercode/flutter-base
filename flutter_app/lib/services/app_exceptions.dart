class AppException implements Exception {
  final String? message;
  final String? prefix;
  final String? url;

  AppException([this.message, this.prefix, this.url]);
}

class BadRequestException extends AppException {
  BadRequestException([String? message, String? url])
      : super(message, 'Bad Request', url);
}

class FetchDataException extends AppException {
  FetchDataException([String? message, String? url])
      : super(message, 'Unable to process', url);
}

class ApiNotRespondingException extends AppException {
  ApiNotRespondingException([String? message, String? url])
      : super(message, 'Api not responded in time', url);
}

class UnAuthorizedException extends AppException {
  UnAuthorizedException([String? message, String? url])
      : super(message, 'UnAuthorized request', url);
}

class NotFoundException extends AppException {
  NotFoundException([String? message, String? url])
      : super(message, 'Request Not Found', url);
}

class CancelRequestException extends AppException {
  CancelRequestException([String? message, String? url])
      : super(message, 'Cancel Request', url);
}

class LoginSocialException extends AppException {
  LoginSocialException({String? message, String? url})
      : super(message, 'Login Social', url);
}

class SocialLoginException extends AppException {
  SocialLoginException([String? message])
      : super(message, 'Social Login Failed');
}

class SocialNotRegisterException extends AppException {
  final String token;
  final Map<String, dynamic>? userInfo;

  SocialNotRegisterException({required this.token, this.userInfo});
}

class FileTooLargeException extends AppException {
  FileTooLargeException([String? message]) : super(message, 'File too large');
}
