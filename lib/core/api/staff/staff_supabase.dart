import 'package:crm/core/data/data_source/supabase_client/supabase_client.dart';
import 'package:crm/core/utils/supabase/supabase_utils.dart';

class StaffSupabase {
  SupabaseClient _client;

  StaffSupabase({required SupabaseClient client}) : _client = client;

  Future<Map<String, dynamic>> getStaffData() async {
    try {
      final data = await _client.request.from('user').select().eq('role', 0);
      return SupabaseUtils.responseWrapper('users', data);
    } catch (e) {
      print(e.toString());
      throw Exception(e);
    }
  }

  Future<void> deleteStaffEmployee({required int id}) async {
    try {
      await _client.request.from('user').delete().eq('id', id);
    } catch (e) {
      print(e.toString());
      throw Exception(e);
    }
  }

  Future<Map<String, dynamic>> getEmployeeData({required int id}) async {
    try {
      final data =
          await _client.request.from('user').select().eq('id', id).single();
      return SupabaseUtils.responseWrapper('user', data);
    } catch (e) {
      print(e.toString());
      throw Exception(e);
    }
  }

  Future<void> createEmployee(ApiEmployeeModel data) async {
    try {
      await _client.request.from('user').insert(data.toJson());
    } catch (e) {
      print(e.toString());
      throw Exception(e);
    }
  }

  Future<void> updateEmployee(ApiEmployeeModel data) async {
    try {
      await _client.request
          .from('user')
          .update(data.toJson())
          .eq('id', data.id);
    } catch (e) {
      print(e.toString());
      throw Exception(e);
    }
  }
}

class ApiEmployeeModel {
  final int? id;
  final String name;
  final String surname;
  final String patronymic;
  final DateTime birthday;
  final String login;
  final String password;
  final int workplace;

  ApiEmployeeModel({
    required this.id,
    required this.name,
    required this.surname,
    required this.patronymic,
    required this.birthday,
    required this.login,
    required this.password,
    required this.workplace,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'surname': surname,
        'patronymic': patronymic,
        'birthday': birthday,
        'login': login,
        'password': password,
        'workplace': workplace,
      };
}
