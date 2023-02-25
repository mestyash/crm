import 'package:crm/core/api/profile/profile_supabase.dart';
import 'package:crm/core/data/data_source/user_credentials_storage/user_credentials_storage.dart';
import 'package:crm/core/data/dto/current_user_mapper.dart';
import 'package:crm/core/domain/entity/current_user_model.dart';
import 'package:crm/features/common/splash_screen/domain/splash_usecase.dart';

class SplashRepository extends ISplashRepository {
  ProfileSupabase _supabase;
  UserCredentialsStorage _storage;

  SplashRepository({
    required ProfileSupabase supabase,
    required UserCredentialsStorage storage,
  })  : _supabase = supabase,
        _storage = storage;

  @override
  Future<CurrentUserModel?> getProfile() async {
    try {
      final userData = await _storage.getCredentials();
      if (userData != null) {
        final login = userData['login']!;
        final pass = userData['pass']!;

        final response = await _supabase.getProfile(
          login: login,
          pass: pass,
        );
        final data = response['payload']['user'];

        return mapCurrentUser(data);
      } else {
        throw Exception('no storage data');
      }
    } catch (e) {
      print(e.toString());
      throw Exception(e);
    }
  }
}
