import 'package:equatable/equatable.dart';

class StaffEmployeeModel extends Equatable {
  final int id;
  final String name;
  final String surname;
  final String patronymic;
  final DateTime birthday;
  final String login;
  final String password;
  final int role;
  final int workplace;

  String get fullName => surname + ' ' + name;

  StaffEmployeeModel({
    required this.id,
    required this.name,
    required this.surname,
    required this.patronymic,
    required this.birthday,
    required this.login,
    required this.password,
    required this.role,
    required this.workplace,
  });

  @override
  List<Object> get props => [
        id,
        name,
        surname,
        patronymic,
        birthday,
        login,
        password,
        role,
        workplace,
      ];
}
