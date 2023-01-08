import 'package:crm/core/api/staff/staff_supabase.dart';
import 'package:crm/features/admin/staff/staff_screen/data/dto/staff_mapper.dart';
import 'package:crm/features/admin/staff/staff_screen/domain/entity/staff_model.dart';
import 'package:crm/features/admin/staff/staff_screen/domain/usecase/staff_usecase.dart';

class StaffRepository extends IStaffRepository {
  final StaffSupabase _supabase;

  StaffRepository({required StaffSupabase supabase}) : _supabase = supabase;

  @override
  Future<List<StaffModel>> getStaffData() async {
    try {
      final response = await _supabase.getStaffData();
      return mapStaff(response['payload']['users']);
    } catch (e) {
      print(e.toString());
      throw Exception(e);
    }
  }
}
