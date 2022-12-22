import 'dart:async';

import 'package:crm/core/presentation/blocs/current_user/current_user_cubit.dart';
import 'package:crm/features/common/app/router/router.dart';
import 'package:crm/features/common/login_screen/data/login_repository.dart';
import 'package:crm/features/common/login_screen/domain/login_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  CurrentUserCubit _currentUserCubit;
  LoginRepository _repository;

  LoginCubit({
    required LoginRepository repository,
    required CurrentUserCubit currentUserCubit,
  })  : _repository = repository,
        _currentUserCubit = currentUserCubit,
        super(LoginState());

  void onLoginChanged(String login) {
    emit(state.copyWith(isFailure: false, login: login));
  }

  void onPassChanged(String pass) {
    emit(state.copyWith(isFailure: false, pass: pass));
  }

  void onCheckboxChanged() {
    emit(state.copyWith(
      isFailure: false,
      saveUserCredentials: !state.saveUserCredentials,
    ));
  }

  Future<void> onButtonPress() async {
    try {
      emit(state.copyWith(isLoading: true, isFailure: false));
      final user = await _repository.getProfile(GetProfileParams(
        login: state.login,
        pass: state.pass,
      ));
      if (state.saveUserCredentials) _currentUserCubit.setUserData(user);
      emit(state.copyWith(
        successfullyLoggedIn: true,
        redirectRoute: user.isAdmin ? Routes.mainAdmin : Routes.mainTeacher,
      ));
    } catch (e) {
      emit(state.copyWith(isLoading: false, isFailure: true));
    }
  }
}
