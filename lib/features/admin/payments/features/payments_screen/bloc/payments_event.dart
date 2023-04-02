// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'payments_bloc.dart';

abstract class PaymentsEvent extends Equatable {
  const PaymentsEvent();

  @override
  List<Object?> get props => [];
}

class PaymentsEventStartDate extends PaymentsEvent {
  final DateTime date;

  PaymentsEventStartDate({required this.date});

  @override
  List<Object> get props => [date];
}

class PaymentsEventEndDate extends PaymentsEvent {
  final DateTime date;

  PaymentsEventEndDate({required this.date});

  @override
  List<Object> get props => [date];
}

class PaymentsEventMode extends PaymentsEvent {}

class PaymentsEventSearchStudents extends PaymentsEvent {
  final String surname;

  PaymentsEventSearchStudents({required this.surname});

  @override
  List<Object> get props => [surname];
}

class PaymentsEventStudent extends PaymentsEvent {
  final UserModel student;

  PaymentsEventStudent({required this.student});

  @override
  List<Object> get props => [student];
}

class PaymentsEventSearch extends PaymentsEvent {}
