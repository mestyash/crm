import 'dart:convert';

import 'package:crm/core/data/data_source/secure_storage/secure_storage.dart';

const LOGIN_CREDENTIALS = 'loginCredentials';

class LoginStorage {
  final SecureStorage storage;

  LoginStorage({required this.storage});

  Future<Map<String, String>?>? getCredentials() async {
    final jsonCredential = await storage.read<String>(key: LOGIN_CREDENTIALS);
    if (jsonCredential != null) {
      return Map.castFrom(jsonDecode(jsonCredential) as Map<String, dynamic>);
    }
    return null;
  }

  Future<void> uploadCredentials({
    required String login,
    required String pass,
  }) async {
    await storage.write<String>(
      key: LOGIN_CREDENTIALS,
      value: jsonEncode({
        'login': login,
        'pass': pass,
      }),
    );
  }

  Future<void> deleteCredentials() async {
    await storage.delete(key: LOGIN_CREDENTIALS);
  }
}
