import 'package:crm/features/admin/staff/core/data/dto/employee/staff_employee_mapper.dart';
import 'package:crm/features/admin/staff/core/domain/entity/staff_employee_model.dart';

List<StaffEmployeeModel> mapStaff(List<dynamic> staff) => staff
    .map(
      (e) => mapStaffEmployee(e),
    )
    .toList();
