import 'package:crm/core/domain/entity/current_user_model.dart';
import 'package:equatable/equatable.dart';

abstract class ILoginRepository {
  Future<CurrentUserModel> getProfile(GetProfileParams params);

  Future<void> saveUserCredentials(SaveUserCredentialsParams params);
}

class GetProfileParams {
  final String login;
  final String pass;

  GetProfileParams({
    required this.login,
    required this.pass,
  });
}

class SaveUserCredentialsParams {
  final String login;
  final String pass;

  SaveUserCredentialsParams({
    required this.login,
    required this.pass,
  });
}
