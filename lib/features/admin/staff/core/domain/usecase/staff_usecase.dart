import 'package:crm/features/admin/staff/core/domain/entity/staff_employee_model.dart';

abstract class IStaffRepository {
  Future<List<StaffEmployeeModel>> getStaffData();
  Future<void> deleteStaffEmployee({required int id});
}
