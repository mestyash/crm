import 'package:crm/core/data/dto/user/user_mapper.dart';
import 'package:crm/core/domain/entity/current_user/current_user_model.dart';

CurrentUserModel mapCurrentUser(dynamic data) => CurrentUserModel(
      userData: mapUser(data),
      role: data['role'] as int,
      workplace: data['workplace'] as int,
    );
