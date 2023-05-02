// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:crm/core/domain/entity/payment/payment_model.dart';
import 'package:crm/core/domain/entity/user/user_model.dart';

abstract class IPaymentsRepository {
  Future<List<PaymentModel>> getPaymentsByRange(
    GetPaymentsByRangeParams params,
  );
  Future<List<UserModel>> searchStudents({required String surname});
  Future<void> uploadPayment(UploadPaymentParams params);
  Future<void> deletePayment({required int id});
  Future<void> setPdfStatus({required int id});
}

class GetPaymentsByRangeParams {
  final DateTime startDate;
  final DateTime endDate;
  final int? studentId;

  GetPaymentsByRangeParams({
    required this.startDate,
    required this.endDate,
    this.studentId,
  });
}

class UploadPaymentParams {
  final int userId;
  final double sum;
  final DateTime date;

  UploadPaymentParams({
    required this.userId,
    required this.sum,
    required this.date,
  });
}
