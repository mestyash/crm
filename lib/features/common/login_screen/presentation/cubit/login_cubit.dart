import 'dart:async';

import 'package:crm/core/presentation/blocs/current_user/current_user_cubit.dart';
import 'package:crm/features/common/app/router/router.dart';
import 'package:crm/features/common/login_screen/domain/login_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  CurrentUserCubit _currentUserCubit;
  ILoginRepository _repository;

  LoginCubit({
    required ILoginRepository repository,
    required CurrentUserCubit currentUserCubit,
  })  : _repository = repository,
        _currentUserCubit = currentUserCubit,
        super(LoginState());

  void onLoginChanged(String login) {
    emit(state.copyWith(login: login));
  }

  void onPassChanged(String pass) {
    emit(state.copyWith(pass: pass));
  }

  void onCheckboxChanged() {
    emit(state.copyWith(saveUserCredentials: !state.saveUserCredentials));
  }

  Future<void> onButtonPress() async {
    try {
      emit(state.copyWith(isLoading: true));
      final user = await _repository.getProfile(GetProfileParams(
        login: state.login,
        pass: state.pass,
      ));
      _currentUserCubit.setInitialData(
        user: user,
        login: state.login,
        pass: state.pass,
        saveUserCredentials: state.saveUserCredentials,
      );
      emit(state.copyWith(
        successfullyLoggedIn: true,
        redirectRoute: user.isAdmin ? Routes.mainAdmin : Routes.mainTeacher,
      ));
    } catch (e) {
      emit(state.copyWith(isLoading: false, isFailure: true));
      addError(e);
    }
  }
}
