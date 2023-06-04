import 'package:crm/core/data/data_source/user_credentials_storage/user_credentials_storage.dart';
import 'package:crm/core/domain/interfaces/current_user_interfaces.dart';
import 'package:crm/features/common/app/router/router.dart';
import 'package:flutter/material.dart';

class CurrentUserRepository extends ICurrentUserRepository {
  final UserCredentialsStorage _storage;
  final GlobalKey<NavigatorState> _navigator;

  CurrentUserRepository({
    required UserCredentialsStorage storage,
    required GlobalKey<NavigatorState> navigator,
  })  : _storage = storage,
        _navigator = navigator;

  @override
  Future<void> logOut() async {
    try {
      await _storage.deleteCredentials();
      await _navigator.currentState!.pushNamedAndRemoveUntil(
        Routes.login,
        (route) => false,
      );
    } catch (e) {
      print(e.toString());
      throw Exception(e);
    }
  }

  @override
  Future<void> saveUserCredentials(SaveUserCredentialsParams params) async {
    try {
      await _storage.uploadCredentials(
        login: params.login,
        pass: params.pass,
      );
    } catch (e) {
      print(e.toString());
      throw Exception(e);
    }
  }
}
