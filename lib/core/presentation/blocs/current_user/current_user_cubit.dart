import 'package:crm/core/domain/entity/current_user_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CurrentUserCubit extends Cubit<CurrentUserModel?> {
  CurrentUserCubit() : super(null);

  void setUserData(CurrentUserModel user) => emit(user);
}
