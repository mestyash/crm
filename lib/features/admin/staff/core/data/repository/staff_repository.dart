import 'package:crm/core/api/staff/staff_supabase.dart';
import 'package:crm/core/utils/date/date_utils.dart';
import 'package:crm/features/admin/staff/core/data/dto/employee/staff_employee_mapper.dart';
import 'package:crm/features/admin/staff/core/data/dto/staff/staff_mapper.dart';
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

  @override
  Future<StaffEmployeeModel> getEmployeeData({required int id}) async {
    try {
      final response = await _supabase.getEmployeeData(id: id);
      final data = response['payload']['user'] as dynamic;
      return mapStaffEmployee(data);
    } catch (e) {
      print(e.toString());
      throw Exception(e);
    }
  }

  @override
  Future<void> uploadStaffEmployee(UploadStaffEmployeeParams params) async {
    try {
      final apiData = ApiEmployeeModel(
        id: params.id,
        name: params.name,
        surname: params.surname,
        patronymic: params.patronymic,
        birthday: CustomDateUtils.prepareDateForBackend(params.birthday),
        login: params.login,
        password: params.password,
        workplace: params.workplace,
      );
      if (params.id != null) {
        await _supabase.updateEmployee(apiData);
      } else {
        await _supabase.createEmployee(apiData);
      }
    } catch (e) {
      print(e.toString());
      throw Exception(e);
    }
  }
}
