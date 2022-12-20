import 'package:equatable/equatable.dart';

class CurrentUserModel extends Equatable {
  final int id;
  final String name;
  final String surname;
  final String patronymic;
  final DateTime birthday;
  final int role;
  final int workplace;

  bool get isAdmin => role == 1;

  CurrentUserModel({
    required this.id,
    required this.name,
    required this.surname,
    required this.patronymic,
    required this.birthday,
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
        role,
        workplace,
      ];
}
