import 'package:crm/features/admin/staff/core/domain/entity/staff_employee_model.dart';

StaffEmployeeModel mapStaffEmployee(dynamic employee) => StaffEmployeeModel(
      id: employee['id'] as int,
      name: employee['name'] as String,
      surname: employee['surname'] as String,
      patronymic: employee['patronymic'] as String,
      birthday: DateTime.parse(employee['birthday'] as String),
      login: employee['login'] as String,
      password: employee['password'] as String,
      role: employee['role'] as int,
      workplace: employee['workplace'] as int,
    );
