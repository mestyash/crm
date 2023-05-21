import 'package:crm/core/api/groups/groups_supabase.dart';
import 'package:crm/core/api/lessons/lessons_supabase.dart';
import 'package:crm/core/data/dto/group/group_mapper.dart';
import 'package:crm/core/data/dto/lesson/lesson_mapper.dart';
import 'package:crm/core/domain/entity/lesson/lesson_model.dart';
import 'package:crm/core/domain/entity/group/group_model.dart';
import 'package:crm/core/utils/date/date_utils.dart';
import 'package:crm/features/common/lessons/core/domain/lessons_usecase.dart';

class LessonsRepository extends ILessonsRepository {
  final LessonsSupabase _lessonsSupabase;
  final GroupsSupabase _groupsSupabase;

  LessonsRepository({
    required LessonsSupabase lessonsSupabase,
    required GroupsSupabase groupsSupabase,
  })  : _lessonsSupabase = lessonsSupabase,
        _groupsSupabase = groupsSupabase;

  @override
  Future<List<LessonModel>> loadLessons({required int groupId}) async {
    try {
      final response = await _lessonsSupabase.getLessons(groupId: groupId);
      final lessons = response['payload']['lessons'] as List<dynamic>;
      return lessons.map((e) => mapLesson(e)).toList()
        ..sort((b, a) => a.date.compareTo(b.date));
    } catch (e) {
      print(e.toString());
      throw Exception(e);
    }
  }

  @override
  Future<GroupModel> loadGroup({required int id}) async {
    try {
      final response = await _groupsSupabase.getGroup(id: id);
      final group = response['payload']['group'] as dynamic;
      return mapGroup(group);
    } catch (e) {
      print(e.toString());
      throw Exception(e);
    }
  }

  @override
  Future<LessonModel> loadLesson({required int id}) async {
    try {
      final response = await _lessonsSupabase.getLesson(id: id);
      final lesson = response['payload']['lesson'] as dynamic;
      return mapLesson(lesson);
    } catch (e) {
      print(e.toString());
      throw Exception(e);
    }
  }

  @override
  Future<void> createLesson(CreateLessonParams params) async {
    try {
      await _lessonsSupabase.createLesson(ApiLessonModel(
        teacherId: params.teacherId,
        groupId: params.groupId,
        visitingStudentIds: params.visitingStudentIds,
        price: params.price,
        salary: params.salary,
        date: CustomDateUtils.prepareDateForBackend(params.date),
        comment: params.comment,
      ));
    } catch (e) {
      print(e.toString());
      throw Exception(e);
    }
  }

  @override
  Future<void> deleteLesson({required int id}) async {
    try {
      await _lessonsSupabase.deleteLesson(id: id);
    } catch (e) {
      print(e.toString());
      throw Exception(e);
    }
  }
}
