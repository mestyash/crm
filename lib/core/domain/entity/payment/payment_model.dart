import 'package:crm/core/utils/date/date_utils.dart';
import 'package:equatable/equatable.dart';
import 'package:crm/core/domain/entity/user/user_model.dart';

class PaymentModel extends Equatable {
  final int id;
  final num sum;
  final DateTime paymentMonth;
  final DateTime createdAt;
  final UserModel student;

  PaymentModel({
    required this.id,
    required this.sum,
    required this.paymentMonth,
    required this.createdAt,
    required this.student,
  });

  String get stringCreatedAt => CustomDateUtils.prepareDateForBackend(
        createdAt,
      );

  @override
  List<Object?> get props {
    return [
      id,
      sum,
      paymentMonth,
      createdAt,
      student,
    ];
  }
}
