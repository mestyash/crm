import 'package:crm/core/api/students/staff_supabase.dart';
import 'package:crm/core/data/dto/user_mapper.dart';
import 'package:crm/core/domain/entity/user_model.dart';
import 'package:crm/core/utils/date/date_utils.dart';
import 'package:crm/features/admin/students/core/domain/students_usecase.dart';

class StudentsRepository extends IStudentsRepository {
  final StudentsSupabase _supabase;

  StudentsRepository({required StudentsSupabase supabase})
      : _supabase = supabase;

  @override
  Future<List<UserModel>> getStudents() async {
    try {
      final response = await _supabase.getStudents();
      final data = response['payload']['students'] as List<dynamic>;

      return data.map((e) => mapUser(e)).toList();
    } catch (e) {
      print(e.toString());
      print('kek');
      throw Exception(e);
    }
  }

  @override
  Future<void> deleteStudent({required int id}) async {
    try {
      await _supabase.deleteStudent(id: id);
    } catch (e) {
      print(e.toString());
      throw Exception(e);
    }
  }

  @override
  Future<UserModel> getStudent({required int id}) async {
    try {
      final response = await _supabase.getStudent(id: id);
      final data = response['payload']['student'] as List<dynamic>;
      return mapUser(data);
    } catch (e) {
      print(e.toString());
      throw Exception(e);
    }
  }

  @override
  Future<void> uploadStudent(UploadStudentParams params) async {
    try {
      final apiData = ApiStudentModel(
        id: params.id,
        name: params.name,
        surname: params.surname,
        patronymic: params.patronymic,
        birthday: CustomDateUtils.prepareDateForBackend(params.birthday),
      );
      if (params.id != null) {
        await _supabase.updateStudent(apiData);
      } else {
        await _supabase.createStudent(apiData);
      }
    } catch (e) {
      print(e.toString());
      throw Exception(e);
    }
  }
}
