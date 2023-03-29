import 'package:crm/core/domain/entity/user_model.dart';

abstract class IPaymentsRepository {
  Future<List<UserModel>> searchStudents({required String surname});
  Future<void> uploadPayment();
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
