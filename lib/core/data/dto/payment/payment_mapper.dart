import 'package:crm/core/data/dto/user/user_mapper.dart';
import 'package:crm/core/domain/entity/payment/payment_model.dart';

PaymentModel mapPayment(dynamic data) {
  return PaymentModel(
    id: data['id'] as int,
    sum: data['sum'] as num,
    paymentMonth: DateTime.parse(data['paymentMonth'] as String),
    createdAt: DateTime.parse(data['createdAt'] as String),
    student: mapUser(data['student']),
    hasPdf: data['hasPdf'] as bool,
  );
}
