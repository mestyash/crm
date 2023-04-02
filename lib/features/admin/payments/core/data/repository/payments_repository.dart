import 'package:crm/core/api/payments/payments_supabase.dart';
import 'package:crm/core/api/students/students_supabase.dart';
import 'package:crm/core/data/dto/payment_mapper.dart';
import 'package:crm/core/data/dto/user_mapper.dart';
import 'package:crm/core/domain/entity/payment_model.dart';
import 'package:crm/core/domain/entity/user_model.dart';
import 'package:crm/core/utils/date/date_utils.dart';
import 'package:crm/features/admin/payments/core/domain/payments_usecase.dart';

class PaymentsRepository extends IPaymentsRepository {
  final StudentsSupabase _studentsSupabase;
  final PaymentsSupabase _paymentsSupabase;

  PaymentsRepository({
    required StudentsSupabase studentsSupabase,
    required PaymentsSupabase paymentsSupabase,
  })  : _studentsSupabase = studentsSupabase,
        _paymentsSupabase = paymentsSupabase;

  @override
  Future<List<PaymentModel>> getPaymentsByRange(
    GetPaymentsByRangeParams params,
  ) async {
    try {
      final List<dynamic> payments;
      if (params.studentId == null) {
        final response = await _paymentsSupabase.getPaymentsByRange(
          startDate: CustomDateUtils.prepareDateForBackend(params.startDate),
          endDate: CustomDateUtils.prepareDateForBackend(params.endDate),
        );
        payments = response['payload']['payments'] as List<dynamic>;
      } else {
        final response = await _paymentsSupabase.getStudentPaymentsByRange(
          startDate: CustomDateUtils.prepareDateForBackend(params.startDate),
          endDate: CustomDateUtils.prepareDateForBackend(params.endDate),
          id: params.studentId!,
        );
        payments = response['payload']['payments'] as List<dynamic>;
      }
      return payments.map((e) => mapPayment(e)).toList();
    } catch (e) {
      print(e.toString());
      throw Exception(e);
    }
  }

  @override
  Future<List<UserModel>> searchStudents({required String surname}) async {
    try {
      final response = await _studentsSupabase.searchStudentsBySurname(surname);
      final students = response['payload']['students'] as List<dynamic>;
      return students.map((e) => mapUser(e)).toList();
    } catch (e) {
      print(e.toString());
      throw Exception(e);
    }
  }

  @override
  Future<void> uploadPayment(UploadPaymentParams params) async {
    try {
      await _paymentsSupabase.createPayment(
        ApiPaymentModel(
            studentId: params.userId,
            sum: params.sum,
            paymentMonth: CustomDateUtils.prepareDateForBackend(params.date),
            createdAt: CustomDateUtils.prepareDateForBackend(DateTime.now())),
      );
    } catch (e) {
      print(e.toString());
      throw Exception(e);
    }
  }
}
