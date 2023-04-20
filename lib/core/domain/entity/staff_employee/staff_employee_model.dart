import 'package:crm/core/domain/entity/user/user_model.dart';
import 'package:equatable/equatable.dart';

class StaffEmployeeModel extends Equatable {
  final UserModel userData;
  final String login;
  final String password;
  final int role;
  final int workplace;

  StaffEmployeeModel({
    required this.userData,
    required this.login,
    required this.password,
    required this.role,
    required this.workplace,
  });

  @override
  List<Object> get props => [
        login,
        password,
        role,
        workplace,
      ];
}
