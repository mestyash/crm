import 'package:crm/core/domain/entity/user/user_model.dart';
import 'package:equatable/equatable.dart';

class CurrentUserModel extends Equatable {
  final UserModel userData;
  final int role;
  final int workplace;

  bool get isAdmin => role == 1;

  CurrentUserModel({
    required this.userData,
    required this.role,
    required this.workplace,
  });

  @override
  List<Object> get props => [
        userData,
        role,
        workplace,
      ];
}
