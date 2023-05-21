import 'package:crm/core/data/dto/user/user_mapper.dart';
import 'package:crm/core/domain/entity/group/group_model.dart';

GroupModel mapGroup(
  dynamic data,
) =>
    GroupModel(
      id: data['id'] as int,
      name: data['name'] as String,
      language: data['language'] as int,
      teacher: data['teacher'] != null ? mapUser(data['teacher']) : null,
      price: data['price'] as num,
      salary: data['salary'] as num,
      students:
          (data['students'] as List<dynamic>).map((e) => mapUser(e)).toList()
            ..sort(
              (a, b) => a.fullName.compareTo(b.name),
            ),
      isActive: data['isActive'] as bool,
    );
