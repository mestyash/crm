import 'package:crm/core/domain/entity/user_model.dart';
import 'package:equatable/equatable.dart';

class PaymentModel extends Equatable {
  final int id;
  final UserModel student;
  final double sum;
  final DateTime paymentMonth;
  final DateTime date;

  PaymentModel({
    required this.id,
    required this.student,
    required this.sum,
    required this.paymentMonth,
    required this.date,
  });

  @override
  List<Object> get props => [
        id,
        student,
        sum,
        paymentMonth,
        date,
      ];
}
