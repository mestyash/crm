import 'package:crm/core/domain/entity/group_model.dart';

abstract class IGroupsRepository {
  Future<List<GroupModel>> getGroups();
  Future<List<GroupModel>> getGroupsByTeacherId({required int id});
  Future<GroupModel> getGroup({required int id});
  Future<void> uploadGroup(UploadGroupParams params);
}

class UploadGroupParams {
  final int? id;
  final int language;
  final int teacherId;
  final num price;
  final num salary;
  final List<int> studentIds;
  final bool isActive;

  UploadGroupParams({
    this.id,
    required this.language,
    required this.teacherId,
    required this.price,
    required this.salary,
    required this.studentIds,
    required this.isActive,
  });
}
