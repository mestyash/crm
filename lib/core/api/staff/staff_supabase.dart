import 'package:crm/core/data/data_source/supabase_client/supabase_client.dart';
import 'package:crm/core/utils/supabase/supabase_utils.dart';

class StaffSupabase {
  SupabaseClient _client;

  StaffSupabase({required SupabaseClient client}) : _client = client;

  Future<Map<String, dynamic>> getStaffData() async {
    try {
      final data = await _client.request.from('user').select().eq('role', 0);
      return SupabaseUtils.responseWrapper('users', data);
    } catch (e) {
      print(e.toString());
      throw Exception(e);
    }
  }

  Future<void> deleteStaffEmployee({required int id}) async {
    try {
      await _client.request.from('user').delete().eq('id', id);
    } catch (e) {
      print(e.toString());
      throw Exception(e);
    }
  }
}
