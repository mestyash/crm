import 'package:crm/core/data/data_source/supabase_client/supabase_client.dart'
    as client;
import 'package:crm/core/utils/supabase/supabase_utils.dart';

class GroupsSupabase {
  final client.SupabaseClient _client;

  GroupsSupabase({required client.SupabaseClient client}) : _client = client;

  Future<Map<String, dynamic>> getGroups() async {
    try {
      final data = await _client.request
          .from('group')
          .select('*, teacher:teacherId (*)')
          .in_('isActive', [true]) as List<dynamic>;

      final groupsWithStudents = [
        ...data.map(
          (e) => {
            ...(e as Map<String, dynamic>),
            'students': [],
          },
        )
      ];

      return SupabaseUtils.responseWrapper(
        'groups',
        groupsWithStudents,
      );
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
          .match(
        {
          'teacherId': id,
          'isActive': true,
        },
      );

      final groupsWithStudents = [
        ...data.map(
          (e) => {
            ...(e as Map<String, dynamic>),
            'students': [],
          },
        )
      ];

      return SupabaseUtils.responseWrapper(
        'groups',
        groupsWithStudents,
      );
    } catch (e) {
      print(e.toString());
      throw Exception(e);
    }
  }

  Future<Map<String, dynamic>> getGroup({required int id}) async {
    try {
      final groupData = await _client.request
          .from('group')
          .select('*, teacher:teacherId (*)')
          .eq('id', id)
          .single();
      final studentIds = groupData['studentIds'] as List<dynamic>;

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

  Future<void> createGroup(ApiGroupModel data) async {
    try {
      await _client.request.from('group').insert(data.toJson());
    } catch (e) {
      print(e.toString());
      throw Exception(e);
    }
  }

  Future<void> updateGroup(ApiGroupModel data) async {
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

class ApiGroupModel {
  final int? id;
  final String name;
  final int language;
  final int teacherId;
  final num price;
  final num salary;
  final List<int> studentIds;
  final bool isActive;

  ApiGroupModel({
    required this.id,
    required this.name,
    required this.language,
    required this.teacherId,
    required this.price,
    required this.salary,
    required this.studentIds,
    required this.isActive,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      if (id != null) 'id': id,
      'name': name,
      'language': language,
      'teacherId': teacherId,
      'price': price,
      'salary': salary,
      'studentIds': studentIds,
      'isActive': isActive,
    };
  }
}
