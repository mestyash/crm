// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:crm/core/data/data_source/supabase_client/supabase_client.dart';
import 'package:crm/core/utils/supabase/supabase_utils.dart';

class LessonsSupabase {
  final SupabaseClient _client;

  LessonsSupabase({required SupabaseClient client}) : _client = client;

  Future<Map<String, dynamic>> getLessons({
    required int groupId,
  }) async {
    try {
      final data = await _client.request
          .from('lesson')
          .select('*, teacher: teacherId (*)')
          .eq('groupId', groupId);

      return SupabaseUtils.responseWrapper('lessons', data);
    } catch (e) {
      print(e.toString());
      throw Exception(e);
    }
  }

  Future<Map<String, dynamic>> getLesson({
    required int id,
  }) async {
    try {
      final data = await _client.request
          .from('lesson')
          .select('*, teacher: teacherId (*)')
          .eq('id', id);

      final studentIds = data['visitingStudentIds'] as List<int>;
      final students = await _client.request.from('student').select().in_(
            'id',
            studentIds,
          );

      return SupabaseUtils.responseWrapper(
        'lessons',
        {
          ...(data as Map<String, dynamic>),
          'students': students,
        },
      );
    } catch (e) {
      print(e.toString());
      throw Exception(e);
    }
  }

  Future<void> createLesson(ApiLessonModel data) async {
    try {
      await _client.request.from('lesson').insert(data.toJson());
    } catch (e) {
      print(e.toString());
      throw Exception(e);
    }
  }

  Future<void> deleteLesson({required int id}) async {
    try {
      await _client.request.from('lesson').delete().eq('id', id);
    } catch (e) {
      print(e.toString());
      throw Exception(e);
    }
  }
}

class ApiLessonModel {
  final int? id;
  final int teacherId;
  final int groupId;
  final List<int> visitingStudentIds;
  final num price;
  final num salary;
  final String date;
  final String comment;

  ApiLessonModel({
    this.id,
    required this.teacherId,
    required this.groupId,
    required this.visitingStudentIds,
    required this.price,
    required this.salary,
    required this.date,
    required this.comment,
  });

  Map<String, dynamic> toJson() => {
        if (id != null) 'id': id,
        'teacherId': teacherId,
        'groupId': groupId,
        'visitingStudentIds': visitingStudentIds,
        'price': price,
        'salary': salary,
        'date': date,
        'comment': comment,
      };
}
