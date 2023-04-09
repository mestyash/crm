import 'package:crm/core/domain/entity/group_model.dart';
import 'package:crm/features/common/groups/core/domain/groups_usecase.dart';

class GroupsRepository extends IGroupsRepository {
  @override
  Future<List<GroupModel>> getGroups() async {
    try {
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
