import 'package:equatable/equatable.dart';

import 'package:crm/core/domain/entity/user/user_model.dart';

class SalaryStatisticModel extends Equatable {
  final UserModel teacher;
  final num salary;

  SalaryStatisticModel({
    required this.teacher,
    required this.salary,
  });

  @override
  List<Object> get props => [teacher, salary];
}
