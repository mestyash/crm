import 'package:equatable/equatable.dart';
import 'package:crm/core/domain/entity/user/user_model.dart';

class GroupModel extends Equatable {
  final int id;
  final String name;
  final int language;
  final UserModel? teacher;
  final num price;
  final num salary;
  final bool isActive;
  final List<UserModel> students;

  GroupModel({
    required this.id,
    required this.name,
    required this.language,
    required this.teacher,
    required this.price,
    required this.salary,
    required this.isActive,
    this.students = const [],
  });

  @override
  List<Object?> get props {
    return [
      id,
      name,
      language,
      teacher,
      price,
      salary,
      isActive,
      students,
    ];
  }
}
