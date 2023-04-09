import 'package:crm/core/data/dto/user_mapper.dart';
import 'package:crm/core/domain/entity/staff_employee_model.dart';

StaffEmployeeModel mapStaffEmployee(dynamic employee) => StaffEmployeeModel(
      userData: mapUser(employee),
      login: employee['login'] as String,
      password: employee['password'] as String,
      role: employee['role'] as int,
      workplace: employee['workplace'] as int,
    );
