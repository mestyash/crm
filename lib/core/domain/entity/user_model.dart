import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final int id;
  final String name;
  final String surname;
  final String patronymic;
  final DateTime birthday;

  UserModel({
    required this.id,
    required this.name,
    required this.surname,
    required this.patronymic,
    required this.birthday,
  });

  String get fullName => surname + ' ' + name;

  @override
  List<Object?> get props => [id, name, surname, patronymic, birthday];
}
