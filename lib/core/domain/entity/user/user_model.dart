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
  String get fullName1 => surname + ' ' + name[0] + '.' + patronymic[0] + '.';

  @override
  List<Object?> get props => [id, name, surname, patronymic, birthday];
}
