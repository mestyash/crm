import 'package:crm/core/api/groups/groups_supabase.dart';
import 'package:crm/core/api/staff/staff_supabase.dart';
import 'package:crm/core/api/students/students_supabase.dart';
import 'package:crm/core/data/dto/group/group_mapper.dart';
import 'package:crm/core/data/dto/user/user_mapper.dart';
import 'package:crm/core/domain/entity/group/group_model.dart';
import 'package:crm/core/domain/entity/user/user_model.dart';
import 'package:crm/features/common/groups/core/domain/groups_interface.dart';

class GroupsRepository extends IGroupsRepository {
  final GroupsSupabase _groupsSupabase;
  final StudentsSupabase _studentsSupabase;
  final StaffSupabase _staffSupabase;

  GroupsRepository({
    required GroupsSupabase groupsSupabase,
    required StudentsSupabase studentsSupabase,
    required StaffSupabase staffSupabase,
  })  : _groupsSupabase = groupsSupabase,
        _studentsSupabase = studentsSupabase,
        _staffSupabase = staffSupabase;

  @override
  Future<List<GroupModel>> getGroups() async {
    try {
      final response = await _groupsSupabase.getGroups();
      final groups = response['payload']['groups'] as List<dynamic>;
      return groups.map((e) => mapGroup(e)).toList();
    } catch (e) {
      print(e.toString());
      throw Exception(e);
    }
  }

  @override
  Future<List<GroupModel>> getGroupsByTeacherId({required int id}) async {
    try {
      final response = await _groupsSupabase.getGroupsByTeacherId(id: id);
      final groups = response['payload']['groups'] as List<dynamic>;
      return groups.map((e) => mapGroup(e)).toList();
    } catch (e) {
      print(e.toString());
      throw Exception(e);
    }
  }

  @override
  Future<GroupModel> getGroup({required int id}) async {
    try {
      final response = await _groupsSupabase.getGroup(id: id);
      final group = response['payload']['group'];
      return mapGroup(group);
    } catch (e) {
      print(e.toString());
      throw Exception(e);
    }
  }

  @override
  Future<List<UserModel>> searchTeacher({required String surname}) async {
    try {
      final response = await _staffSupabase.searchActiveEmployeeBySurname(
        surname,
      );
      final students = response['payload']['users'] as List<dynamic>;
      return students.map((e) => mapUser(e)).toList();
    } catch (e) {
      print(e.toString());
      throw Exception(e);
    }
  }

  @override
  Future<List<UserModel>> searchStudent({required String surname}) async {
    try {
      final response = await _studentsSupabase.searchActiveStudentsBySurname(
        surname,
      );
      final students = response['payload']['students'] as List<dynamic>;
      return students.map((e) => mapUser(e)).toList();
    } catch (e) {
      print(e.toString());
      throw Exception(e);
    }
  }

  @override
  Future<void> uploadGroup(UploadGroupParams params) async {
    try {
      final data = ApiGroupModel(
        id: params.id,
        name: params.name,
        language: params.language,
        teacherId: params.teacherId,
        price: params.price,
        salary: params.salary,
        studentIds: params.studentIds,
        isActive: params.isActive,
      );
      params.id == null
          ? await _groupsSupabase.createGroup(data)
          : await _groupsSupabase.updateGroup(data);
    } catch (e) {
      print(e.toString());
      throw Exception(e);
    }
  }
}
