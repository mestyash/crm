import 'package:crm/core/data/dto/current_user_mapper.dart';
import 'package:crm/core/domain/entity/current_user_model.dart';
import 'package:crm/core/api/login/login_supabase.dart';
import 'package:crm/core/data/data_source/user_credentials_storage/user_credentials_storage.dart';
import 'package:crm/features/common/login_screen/domain/login_usecase.dart';

class LoginRepository extends ILoginRepository {
  ProfileSupabase _supabase;
  UserCredentialsStorage _storage;

  LoginRepository({
    required ProfileSupabase supabase,
    required UserCredentialsStorage storage,
  })  : _supabase = supabase,
        _storage = storage;

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

  @override
  Future<void> saveUserCredentials(SaveUserCredentialsParams params) async {
    try {
      await _storage.uploadCredentials(
        login: params.login,
        pass: params.pass,
      );
    } catch (e) {
      print(e.toString());
      throw Exception(e);
    }
  }
}
