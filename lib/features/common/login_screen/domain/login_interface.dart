import 'package:crm/core/domain/entity/current_user/current_user_model.dart';

abstract class ILoginRepository {
  Future<CurrentUserModel> getProfile(GetProfileParams params);
}

class GetProfileParams {
  final String login;
  final String pass;

  GetProfileParams({
    required this.login,
    required this.pass,
  });
}
