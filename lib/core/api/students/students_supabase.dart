import 'package:crm/core/data/data_source/supabase_client/supabase_client.dart'
    as client;
import 'package:crm/core/utils/supabase/supabase_utils.dart';

class StudentsSupabase {
  final client.SupabaseClient _client;

  StudentsSupabase({required client.SupabaseClient client}) : _client = client;

  Future<Map<String, dynamic>> getStudents() async {
    try {
      final data =
          await _client.request.from('student').select().eq('isDeleted', false);
      return SupabaseUtils.responseWrapper('students', data);
    } catch (e) {
      print(e.toString());
      throw Exception(e);
    }
  }

  Future<void> deleteStudent({required int id}) async {
    try {
      await _client.request.from('student').update(
        {'isDeleted': true},
      ).eq('id', id);
    } catch (e) {
      print(e.toString());
      throw Exception(e);
    }
  }

  Future<Map<String, dynamic>> getStudent({required int id}) async {
    try {
      final data =
          await _client.request.from('student').select().eq('id', id).single();
      return SupabaseUtils.responseWrapper('student', data);
    } catch (e) {
      print(e.toString());
      throw Exception(e);
    }
  }

  Future<void> createStudent(ApiStudentModel data) async {
    try {
      await _client.request.from('student').insert(data.toJson());
    } catch (e) {
      print(e.toString());
      throw Exception(e);
    }
  }

  Future<void> updateStudent(ApiStudentModel data) async {
    try {
      await _client.request
          .from('student')
          .update(data.toJson())
          .eq('id', data.id);
    } catch (e) {
      print(e.toString());
      throw Exception(e);
    }
  }

  Future<Map<String, dynamic>> searchActiveStudentsBySurname(
    String surname,
  ) async {
    try {
      final data = await _client.request
          .from('student')
          .select()
          .is_('isDeleted', false)
          .ilike('surname', '%$surname%');
      return SupabaseUtils.responseWrapper('students', data);
    } catch (e) {
      print(e.toString());
      throw Exception(e);
    }
  }

  Future<Map<String, dynamic>> searchStudentsBySurname(
    String surname,
  ) async {
    try {
      final data = await _client.request
          .from('student')
          .select()
          .ilike('surname', '%$surname%');
      return SupabaseUtils.responseWrapper('students', data);
    } catch (e) {
      print(e.toString());
      throw Exception(e);
    }
  }
}

class ApiStudentModel {
  final int? id;
  final String name;
  final String surname;
  final String patronymic;
  final String birthday;

  ApiStudentModel({
    required this.id,
    required this.name,
    required this.surname,
    required this.patronymic,
    required this.birthday,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'surname': surname,
        'patronymic': patronymic,
        'birthday': birthday,
      };
}
