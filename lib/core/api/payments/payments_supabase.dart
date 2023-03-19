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
}

// class ApiStudentModel {
//   final int? id;
//   final String name;
//   final String surname;
//   final String patronymic;
//   final String birthday;

//   ApiStudentModel({
//     required this.id,
//     required this.name,
//     required this.surname,
//     required this.patronymic,
//     required this.birthday,
//   });

//   Map<String, dynamic> toJson() => {
//         'name': name,
//         'surname': surname,
//         'patronymic': patronymic,
//         'birthday': birthday,
//       };
// }
