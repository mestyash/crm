part of 'create_payment_bloc.dart';

abstract class CreatePaymentEvent extends Equatable {
  const CreatePaymentEvent();

  @override
  List<Object?> get props => [];
}

class CreatePaymentEventSearchStudents extends CreatePaymentEvent {
  final String surname;

  CreatePaymentEventSearchStudents({required this.surname});

  @override
  List<Object> get props => [surname];
}

class CreatePaymentEventStudent extends CreatePaymentEvent {
  final UserModel student;

  CreatePaymentEventStudent({required this.student});

  @override
  List<Object> get props => [student];
}

class CreatePaymentEventSum extends CreatePaymentEvent {
  final String sum;

  CreatePaymentEventSum({required this.sum});

  @override
  List<Object> get props => [sum];
}

class CreatePaymentEventDate extends CreatePaymentEvent {
  final DateTime date;

  CreatePaymentEventDate({required this.date});

  @override
  List<Object> get props => [date];
}

class CreatePaymentEventUpload extends CreatePaymentEvent {
  CreatePaymentEventUpload();
}
