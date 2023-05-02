import 'package:crm/core/data/dto/user/user_mapper.dart';
import 'package:crm/core/domain/entity/lesson/lesson_model.dart';

LessonModel mapLesson(dynamic data) {
  return LessonModel(
    id: data['id'] as int,
    groupId: data['groupId'] as int,
    teacher: mapUser(data['teacher']),
    visitingStudents: ((data['students'] ?? []) as List<dynamic>)
        .map(
          (e) => mapUser(e),
        )
        .toList(),
    price: data['price'] as num,
    salary: data['salary'] as num,
    date: DateTime.parse(data['date'] as String),
    comment: data['comment'] as String,
    createdAt: DateTime.parse(data['date'] as String),
  );
}
