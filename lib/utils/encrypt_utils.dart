import 'package:encrypt/encrypt.dart';

class EncryptUtils {
  static const String _private = '8080808080808080';

  static String encryptPassword(String password) {
    final key = Key.fromUtf8(_private);
    final iv = IV.fromUtf8(_private);
    final Encrypter encrypter = Encrypter(AES(key, mode: AESMode.cbc));
    final Encrypted encrypted = encrypter.encrypt(password, iv: iv);
    return encrypted.base64;
  }
}