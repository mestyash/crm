import 'package:crm/core/data/data_source/supabase_client/supabase_client.dart';
import 'package:crm/core/utils/supabase/supabase_utils.dart';

class LoginSupabase {
  SupabaseClient _client;

  LoginSupabase({required SupabaseClient client}) : _client = client;

  Future<Map<String, dynamic>> login({
    required String login,
    required String pass,
  }) async {
    try {
      final data = await _client.request
          .from('user')
          .select()
          .eq('login', login)
          .eq('password', pass)
          .maybeSingle();
      return SupabaseUtils.responseWrapper('user', data);
    } catch (e) {
      print(e.toString());
      throw Exception(e);
    }
  }
}
