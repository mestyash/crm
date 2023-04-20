import 'package:crm/core/domain/entity/current_user/current_user_model.dart';

abstract class ISplashRepository {
  Future<CurrentUserModel?> getProfile();
}
