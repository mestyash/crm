import 'package:equatable/equatable.dart';

class StaffModel extends Equatable {
  final int id;
  final int name;
  final int surname;

  StaffModel({
    required this.id,
    required this.name,
    required this.surname,
  });

  @override
  List<Object> get props => [id, name, surname];
}
