import 'package:crm/core/data/dto/current_user/current_user_mapper.dart';
import 'package:crm/core/domain/entity/current_user/current_user_model.dart';
import 'package:crm/core/api/profile/profile_supabase.dart';
import 'package:crm/features/common/login_screen/domain/login_interface.dart';

class LoginRepository extends ILoginRepository {
  ProfileSupabase _supabase;

  LoginRepository({
    required ProfileSupabase supabase,
  }) : _supabase = supabase;

  @override
  Future<CurrentUserModel> getProfile(GetProfileParams params) async {
    try {
      final response = await _supabase.getProfile(
        login: params.login,
        pass: params.pass,
      );
      final user = response['payload']['user'];
      if (user == null) {
        throw Exception('no data');
      }
      return mapCurrentUser(user);
    } catch (e) {
      print(e.toString());
      throw Exception(e);
    }
  }
}
