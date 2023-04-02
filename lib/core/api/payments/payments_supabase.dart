import 'package:crm/core/data/data_source/supabase_client/supabase_client.dart';
import 'package:crm/core/utils/supabase/supabase_utils.dart';

class PaymentsSupabase {
  final SupabaseClient _client;

  PaymentsSupabase({required SupabaseClient client}) : _client = client;

  Future<Map<String, dynamic>> getPaymentsByRange({
    required String startDate,
    required String endDate,
  }) async {
    try {
      print(startDate);
      final data = await _client.request
          .from('payment')
          .select('*, student:studentId (*)')
          .gte('createdAt', startDate)
          .lte('createdAt', endDate);

      return SupabaseUtils.responseWrapper('payments', data);
    } catch (e) {
      print(e.toString());
      throw Exception(e);
    }
  }

  Future<void> createPayment(ApiPaymentModel data) async {
    try {
      await _client.request.from('payment').insert(data.toJson());
    } catch (e) {
      print(e.toString());
      throw Exception(e);
    }
  }
}

class ApiPaymentModel {
  final int studentId;
  final double sum;
  final String paymentMonth;
  final String createdAt;

  ApiPaymentModel({
    required this.studentId,
    required this.sum,
    required this.paymentMonth,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() => {
        'studentId': studentId,
        'sum': sum,
        'paymentMonth': paymentMonth,
        'createdAt': createdAt,
      };
}
