import 'package:sprintf/sprintf.dart';
import 'package:flutter_app/constants/message_constants.dart';

class ValidateUtils {
  static bool isEmail(String value) {
    final reg = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return reg.hasMatch(value);
  }

  static String? checkInputField(String value, {String? fieldName}) {
    if (value.isEmpty) {
      return sprintf(MessageConstants.mgs1, [fieldName]);
    }
    return null;
  }

  static bool isValidPassword(String value) {
    final reg = RegExp(r"^(?=.*[A-Z])(?=.*[a-z])(?=.*?[0-9]).{8,}$");
    return reg.hasMatch(value);
  }
}
