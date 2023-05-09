abstract class ICurrentUserRepository {
  Future<void> saveUserCredentials(SaveUserCredentialsParams params);
  Future<void> logOut();
}

class SaveUserCredentialsParams {
  final String login;
  final String pass;

  SaveUserCredentialsParams({
    required this.login,
    required this.pass,
  });
}
