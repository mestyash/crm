import 'package:crm/core/data/dto/lesson/lesson_mapper.dart';
import 'package:crm/core/domain/entity/user/user_model.dart';
import 'package:crm/features/admin/statistics/salary_statistics/domain/entity/salary_statistic_model.dart';

// example
// {
//   '2': {
//     'user': userModel,
//     'salary': 2000,
//   }
// }

List<SalaryStatisticModel> mapSalaryStatistics(List<dynamic> data) {
  final lessons = data.map((e) => mapLesson(e)).toList();

  final Map<int, Map<String, dynamic>> statistics = {};

  lessons.forEach((e) {
    print(e);
    print('---');
    final teacherId = e.teacher.id;

    if (statistics.containsKey(teacherId)) {
      final currentData = statistics[teacherId]!;
      final currentSalary = currentData['salary'] as num;
      currentData['salary'] = currentSalary + e.salary;

      statistics[teacherId] = currentData;
    } else {
      statistics[teacherId] = {
        'user': e.teacher,
        'salary': e.salary,
      };
    }
  });

  return statistics.values
      .map(
        (e) => SalaryStatisticModel(
          teacher: e['user'] as UserModel,
          salary: e['salary'] as num,
        ),
      )
      .toList();
}
