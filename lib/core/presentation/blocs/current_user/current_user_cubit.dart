import 'package:crm/core/data/repository/current_user_repository.dart';
import 'package:crm/core/domain/entity/current_user/current_user_model.dart';
import 'package:crm/core/domain/usecase/current_user_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CurrentUserCubit extends Cubit<CurrentUserModel?> {
  final CurrentUserRepository _repository;

  CurrentUserCubit({required CurrentUserRepository repository})
      : _repository = repository,
        super(null);

  Future<void> setInitialData({
    required CurrentUserModel user,
    required String login,
    required String pass,
    required bool saveUserCredentials,
  }) async {
    if (saveUserCredentials)
      await _repository.saveUserCredentials(
        SaveUserCredentialsParams(login: login, pass: pass),
      );
    emit(user);
  }

  void setUserData(CurrentUserModel user) => emit(user);

  Future<void> logOut() async {
    await _repository.logOut();
  }
}
