import 'package:equatable/equatable.dart';

class StaffEmployeeModel extends Equatable {
  final int id;
  final String name;
  final String surname;

  String get fullName => name + ' ' + surname;

  StaffEmployeeModel({
    required this.id,
    required this.name,
    required this.surname,
  });

  @override
  List<Object> get props => [id, name, surname];
}
