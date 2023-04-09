import 'package:equatable/equatable.dart';
import 'package:crm/core/domain/entity/staff_employee_model.dart';
import 'package:crm/core/domain/entity/user_model.dart';

class GroupModel extends Equatable {
  final int id;
  final String name;
  final int language;
  final StaffEmployeeModel teacher;
  final num price;
  final num salary;
  final List<UserModel> students;

  GroupModel({
    required this.id,
    required this.name,
    required this.language,
    required this.teacher,
    required this.price,
    required this.salary,
    this.students = const [],
  });

  @override
  List<Object> get props {
    return [
      id,
      name,
      language,
      teacher,
      price,
      salary,
      students,
    ];
  }
}
