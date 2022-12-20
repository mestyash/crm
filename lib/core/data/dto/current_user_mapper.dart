import 'package:crm/core/domain/entity/current_user_model.dart';

CurrentUserModel mapCurrentUser(dynamic data) => CurrentUserModel(
      id: data['id'] as int,
      name: data['name'] as String,
      surname: data['surname'] as String,
      patronymic: data['patronymic'] as String,
      birthday: DateTime.parse(data['birthday'] as String),
      role: data['role'] as int,
      workplace: data['workplace'] as int,
    );
