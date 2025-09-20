import 'dart:developer';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../constants/const_keys.dart';

abstract class TokenStorage {
  static AndroidOptions _getAndroidOptions() =>
      const AndroidOptions(encryptedSharedPreferences: true);
  static final _storage = FlutterSecureStorage(aOptions: _getAndroidOptions());

  static Future<void> saveToken(String token) async {
    try {
      await _storage.write(key: ConstKeys.keyUserToken, value: token);
    } catch (e) {
      log('SecureStorage error: $e');
      await _storage.deleteAll();
      await _storage.write(key: ConstKeys.keyUserToken, value: token);
    }
  }

  static Future<String?> getToken() async {
    return await _storage.read(key: ConstKeys.keyUserToken);
  }

  static Future<void> deleteToken() async {
    await _storage.delete(key: ConstKeys.keyUserToken);
  }

}
