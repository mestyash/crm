import 'package:crm/core/data/data_source/supabase_client/supabase_client.dart'
    as client;
import 'package:crm/core/utils/supabase/supabase_utils.dart';

class GroupsSupabase {
  final client.SupabaseClient _client;

  GroupsSupabase({required client.SupabaseClient client}) : _client = client;

  Future<Map<String, dynamic>> getGroups() async {
    try {
      final data = await _client.request.from('group').select();
      return SupabaseUtils.responseWrapper('groups', data);
    } catch (e) {
      print(e.toString());
      throw Exception(e);
    }
  }

  Future<Map<String, dynamic>> getGroupsByTeacherId({required int id}) async {
    try {
      final data = await _client.request
          .from('group')
          .select('*, user:teacherId (*)')
          .eq('teacherId', id);
      return SupabaseUtils.responseWrapper('groups', data);
    } catch (e) {
      print(e.toString());
      throw Exception(e);
    }
  }

  Future<Map<String, dynamic>> getGroup({required int id}) async {
    try {
      final groupData = await _client.request
          .from('group')
          .select('*, user:teacherId (*)')
          .eq('id', id)
          .single();
      final studentIds = groupData['studentIds'] as List<int>;
      final students =
          await _client.request.from('student').select().in_('id', studentIds);

      return SupabaseUtils.responseWrapper(
        'group',
        {
          ...(groupData as Map<String, dynamic>),
          'students': students,
        },
      );
    } catch (e) {
      print(e.toString());
      throw Exception(e);
    }
  }

  Future<void> createGroup(ApiStudentModel data) async {
    try {
      await _client.request.from('group').insert(data.toJson());
    } catch (e) {
      print(e.toString());
      throw Exception(e);
    }
  }

  Future<void> uploadGroup(ApiStudentModel data) async {
    try {
      await _client.request
          .from('group')
          .update(data.toJson())
          .eq('id', data.id);
    } catch (e) {
      print(e.toString());
      throw Exception(e);
    }
  }
}

class ApiStudentModel {
  final int? id;
  final int language;
  final int teacherId;
  final num price;
  final num salary;
  final List<int> studentIds;
  final bool isActive;

  ApiStudentModel({
    required this.id,
    required this.language,
    required this.teacherId,
    required this.price,
    required this.salary,
    required this.studentIds,
    required this.isActive,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'language': language,
      'teacherId': teacherId,
      'price': price,
      'salary': salary,
      'studentIds': studentIds,
      'isActive': isActive,
    };
  }
}
