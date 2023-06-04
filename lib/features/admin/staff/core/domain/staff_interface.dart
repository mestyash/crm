
import 'package:crm/core/domain/entity/staff_employee/staff_employee_model.dart';

abstract class IStaffRepository {
  Future<List<StaffEmployeeModel>> getStaffData();
  Future<void> deleteStaffEmployee({required int id});
  Future<StaffEmployeeModel> getEmployeeData({required int id});
  Future<void> uploadStaffEmployee(UploadStaffEmployeeParams params);
}

class UploadStaffEmployeeParams {
  final int? id;
  final String name;
  final String surname;
  final String patronymic;
  final DateTime birthday;
  final String login;
  final String password;
  final int workplace;

  UploadStaffEmployeeParams({
    required this.id,
    required this.name,
    required this.surname,
    required this.patronymic,
    required this.birthday,
    required this.login,
    required this.password,
    required this.workplace,
  });
}
