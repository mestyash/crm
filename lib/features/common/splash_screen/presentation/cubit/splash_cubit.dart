import 'dart:async';
import 'package:crm/core/presentation/blocs/current_user/current_user_cubit.dart';
import 'package:crm/features/common/app/router/router.dart';
import 'package:crm/features/common/splash_screen/domain/splash_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  CurrentUserCubit _currentUserCubit;
  ISplashRepository _repository;

  SplashCubit({
    required CurrentUserCubit currentUserCubit,
    required ISplashRepository repository,
  })  : _currentUserCubit = currentUserCubit,
        _repository = repository,
        super(SplashState());

  Future<void> onLogin() async {
    try {
      final data = await _repository.getProfile();
      if (data != null) {
        _currentUserCubit.setUserData(data);
        emit(state.copyWith(
          isAuthenticated: true,
          redirectRoute: data.isAdmin ? Routes.mainAdmin : Routes.mainTeacher,
        ));
      } else {
        emit(state.copyWith(isUnauthenticated: true));
      }
    } catch (e) {
      emit(state.copyWith(isUnauthenticated: true));
    }
  }
}
