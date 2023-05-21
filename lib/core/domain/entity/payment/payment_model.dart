import 'package:equatable/equatable.dart';
import 'package:crm/core/domain/entity/user/user_model.dart';
import 'package:crm/core/utils/date/date_utils.dart';
import 'package:intl/intl.dart';

class PaymentModel extends Equatable {
  final int id;
  final num sum;
  final DateTime paymentMonth;
  final DateTime createdAt;
  final UserModel student;
  final bool hasPdf;

  PaymentModel({
    required this.id,
    required this.sum,
    required this.paymentMonth,
    required this.createdAt,
    required this.student,
    required this.hasPdf,
  });

  String get stringCreatedAt => CustomDateUtils.prepareDateForBackend(
        createdAt,
      );

  String get stringPaymentMonth {
    final year = DateTime.now().year;
    final pattern = year == paymentMonth.year ? 'MMMM' : 'MMMM yyyy';

    return DateFormat(pattern).format(paymentMonth);
  }

  PaymentModel copyWith({
    int? id,
    num? sum,
    DateTime? paymentMonth,
    DateTime? createdAt,
    UserModel? student,
    bool? hasPdf,
  }) {
    return PaymentModel(
      id: id ?? this.id,
      sum: sum ?? this.sum,
      paymentMonth: paymentMonth ?? this.paymentMonth,
      createdAt: createdAt ?? this.createdAt,
      student: student ?? this.student,
      hasPdf: hasPdf ?? this.hasPdf,
    );
  }

  @override
  List<Object?> get props {
    return [
      id,
      sum,
      paymentMonth,
      createdAt,
      student,
      hasPdf,
    ];
  }
}
