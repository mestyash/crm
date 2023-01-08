import 'package:crm/features/admin/staff/staff_screen/domain/entity/staff_model.dart';

abstract class IStaffRepository {
  Future<List<StaffModel>> getStaffData();
}
