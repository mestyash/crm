import 'package:crm/core/api/staff/staff_supabase.dart';
import 'package:crm/features/admin/staff/core/data/dto/staff_mapper.dart';
import 'package:crm/features/admin/staff/core/domain/entity/staff_employee_model.dart';
import 'package:crm/features/admin/staff/core/domain/usecase/staff_usecase.dart';

class StaffRepository extends IStaffRepository {
  final StaffSupabase _supabase;

  StaffRepository({required StaffSupabase supabase}) : _supabase = supabase;

  @override
  Future<List<StaffEmployeeModel>> getStaffData() async {
    try {
      final response = await _supabase.getStaffData();
      final data = response['payload']['users'] as List<dynamic>;
      return mapStaff(data);
    } catch (e) {
      print(e.toString());
      throw Exception(e);
    }
  }

  @override
  Future<void> deleteStaffEmployee({required int id}) async {
    try {
      await _supabase.deleteStaffEmployee(id: id);
    } catch (e) {
      print(e.toString());
      throw Exception(e);
    }
  }
}
