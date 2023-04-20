import 'package:crm/core/api/groups/groups_supabase.dart';
import 'package:crm/core/data/dto/group/group_mapper.dart';
import 'package:crm/core/domain/entity/group/group_model.dart';
import 'package:crm/features/common/groups/core/domain/groups_usecase.dart';

class GroupsRepository extends IGroupsRepository {
  final GroupsSupabase _supabase;

  GroupsRepository({required GroupsSupabase supabase}) : _supabase = supabase;

  @override
  Future<List<GroupModel>> getGroups() async {
    try {
      final response = await _supabase.getGroups();
      final groups = response['payload']['groups'] as List<dynamic>;
      return groups.map((e) => mapGroup(e)).toList();
      // ..sort((a, b) => b.isActive ? 1 : -1);
    } catch (e) {
      print(e.toString());
      throw Exception(e);
    }
  }

  @override
  Future<List<GroupModel>> getGroupsByTeacherId({required int id}) {
    try {
      throw Exception('e');
    } catch (e) {
      print(e.toString());
      throw Exception(e);
    }
  }

  @override
  Future<GroupModel> getGroup({required int id}) async {
    try {
      final response = await _supabase.getGroup(id: id);
      final group = response['payload']['group'];
      return mapGroup(group);
    } catch (e) {
      print(e.toString());
      throw Exception(e);
    }
  }

  @override
  Future<void> uploadGroup(UploadGroupParams params) async {
    try {
      final data = ApiGroupModel(
        id: null,
        language: params.language,
        teacherId: params.teacherId,
        price: params.price,
        salary: params.salary,
        studentIds: params.studentIds,
        isActive: params.isActive,
      );
      params.id == null
          ? await _supabase.createGroup(data)
          : await _supabase.updateGroup(data);
    } catch (e) {
      print(e.toString());
      throw Exception(e);
    }
  }
}
