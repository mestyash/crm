import 'package:crm/core/domain/entity/current_user_model.dart';
import 'package:equatable/equatable.dart';

abstract class ILoginRepository {
  Future<CurrentUserModel> getProfile(GetProfileParams params);

  Future<void> saveUserCredentials(SaveUserCredentialsParams params);
}

class GetProfileParams extends Equatable {
  final String login;
  final String pass;

  GetProfileParams({
    required this.login,
    required this.pass,
  });

  @override
  List<Object> get props => [login, pass];
}

class SaveUserCredentialsParams extends Equatable {
  final String login;
  final String pass;

  SaveUserCredentialsParams({
    required this.login,
    required this.pass,
  });

  @override
  List<Object> get props => [login, pass];
}
