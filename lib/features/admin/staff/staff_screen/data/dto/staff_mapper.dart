import 'package:crm/features/admin/staff/staff_screen/domain/entity/staff_model.dart';

List<StaffModel> mapStaff(List<dynamic> staff) => staff
    .map(
      (e) => StaffModel(
        id: e['id'],
        name: e['name'],
        surname: e['surname'],
      ),
    )
    .toList();
