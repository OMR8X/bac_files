import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenManager {
  //
  static bool tempLog = false;
  static String? _token;
  // Singleton instance of FlutterSecureStorage
  static const _storage = FlutterSecureStorage();

  // Private constructor
  TokenManager._privateConstructor();

  static final TokenManager instance = TokenManager._privateConstructor();

  String? get token => _token;
  //
  Future<String?> init() async {
    try {
      final response = await _storage.read(key: "token");
      _token = response ?? _token;
      return response;
    } catch (e) {
      return null;
    }
  }

  // Set token
  Future<void> setToken({
    required String newToken,
    bool tempLog = false,
  }) async {
    _token = newToken;

    if (!tempLog) {
      await _storage.write(key: "token", value: token);
    }
  }

  // Delete token
  Future<void> deleteToken() async {
    _token = null;
    await _storage.delete(key: "token");
  }
}
