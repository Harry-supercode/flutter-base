import 'dart:convert';
import 'dart:math';

class Crypt {
  static late Crypt _instance;

  Crypt._internal();
  // Instance
  static Crypt get instance {
    _instance = Crypt._internal();
    return _instance;
  }

  final int _randomNumb = 5;

  final _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  final Random _rnd = Random();

  // Get random string
  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  // Encrypt data
  encrypt(String credentials) {
    final afterShuffle = shuffleData(credentials.runes.toList());
    final data =
        '${getRandomString(_randomNumb)}$afterShuffle${getRandomString(_randomNumb)}';
    return base64.encode(utf8.encode(data));
  }

  // Decrypt data
  String decrypt(String encodeCredentials) {
    if (encodeCredentials.isEmpty) return encodeCredentials;
    final firstDecrypt = utf8
        .decode(base64.decode(encodeCredentials))
        .replaceRange(0, _randomNumb, '');
    final secondDecrypt = firstDecrypt.replaceRange(
        firstDecrypt.length - _randomNumb, firstDecrypt.length, '');
    return shuffleData(secondDecrypt.runes.toList());
  }
}

// Shuffle data string
String shuffleData(List<int> chars) {
  final destination =
      chars.length % 2 == 0 ? chars.length / 2 : (chars.length - 1) / 2;
  for (int i = 0; i < destination; i++) {
    final str = chars.removeAt(i);
    final strB = chars.removeAt(chars.length - 1 - i);
    chars.insert(chars.length - i, str);
    chars.insert(i, strB);
  }
  return String.fromCharCodes(chars);
}
