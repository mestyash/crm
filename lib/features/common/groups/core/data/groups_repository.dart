import 'package:crm/core/api/groups/groups_supabase.dart';
import 'package:crm/core/domain/entity/group_model.dart';
import 'package:crm/features/common/groups/core/domain/groups_usecase.dart';

class GroupsRepository extends IGroupsRepository {
  final GroupsSupabase _supabase;

  GroupsRepository({required GroupsSupabase supabase}) : _supabase = supabase;

  @override
  Future<List<GroupModel>> getGroups() async {
    try {
      final response = await _supabase.getGroups();
      final groups = response['payload']['groups'] as List<dynamic>;
      print('----');
      print('----');
      print(groups);
      print('----');
      print('----');
      throw Exception('e');
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
  Future<GroupModel> getGroup({required int id}) {
    try {
      throw Exception('e');
    } catch (e) {
      print(e.toString());
      throw Exception(e);
    }
  }

  @override
  Future<void> uploadGroup(UploadGroupParams params) {
    try {
      throw Exception('e');
    } catch (e) {
      print(e.toString());
      throw Exception(e);
    }
  }
}
