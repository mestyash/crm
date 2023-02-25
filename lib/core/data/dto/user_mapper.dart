import 'package:crm/core/domain/entity/user_model.dart';

UserModel mapUser(dynamic data) => UserModel(
      id: data['id'] as int,
      name: data['name'] as String,
      surname: data['surname'] as String,
      patronymic: data['patronymic'] as String,
      birthday: DateTime.parse(data['birthday'] as String),
    );
