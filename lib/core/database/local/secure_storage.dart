import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:io' show Platform;

class SecureStorageService {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  Future<void> writeSecureData(String key, String value) async {
    if (Platform.isAndroid || Platform.isIOS) {
      await _secureStorage.write(key: key, value: value);
    } else {
      print('Secure storage is not supported on this platform.');
    }
  }

  Future<String?> readSecureData(String key) async {
    if (Platform.isAndroid || Platform.isIOS) {
      return await _secureStorage.read(key: key);
    } else {
      print('Secure storage is not supported on this platform.');
      return null;
    }
  }

  Future<void> deleteSecureData(String key) async {
    if (Platform.isAndroid || Platform.isIOS) {
      await _secureStorage.delete(key: key);
    } else {
      print('Secure storage is not supported on this platform.');
    }
  }

  Future<void> deleteAllSecureData() async {
    if (Platform.isAndroid || Platform.isIOS) {
      await _secureStorage.deleteAll();
    } else {
      print('Secure storage is not supported on this platform.');
    }
  }
}
