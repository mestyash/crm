import 'package:crm/core/domain/entity/group/group_model.dart';
import 'package:crm/core/domain/entity/lesson/lesson_model.dart';

abstract class ILessonsRepository {
  Future<List<LessonModel>> loadLessons({required int groupId});
  Future<GroupModel> loadGroup({required int id});
  Future<LessonModel> loadLesson({required int id});
  Future<void> createLesson(CreateLessonParams params);
  Future<void> deleteLesson({required int id});
}

class CreateLessonParams {
  final int teacherId;
  final int groupId;
  final num price;
  final num salary;
  final DateTime date;
  final List<int> visitingStudentIds;
  final String comment;

  CreateLessonParams({
    required this.teacherId,
    required this.groupId,
    required this.price,
    required this.salary,
    required this.date,
    required this.visitingStudentIds,
    required this.comment,
  });
}
