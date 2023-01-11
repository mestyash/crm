import 'package:crm/features/admin/staff/staff_screen/domain/entity/staff_employee_model.dart';

List<StaffEmployeeModel> mapStaff(List<dynamic> staff) => staff
    .map(
      (e) => StaffEmployeeModel(
        id: e['id'] as int,
        name: e['name'] as String,
        surname: e['surname'] as String,
      ),
    )
    .toList();
