// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:crm/core/api/lessons/lessons_supabase.dart';
import 'package:crm/core/utils/date/date_utils.dart';
import 'package:crm/features/admin/statistics/salary_statistics/data/dto/salary_statistics_mapper.dart';
import 'package:crm/features/admin/statistics/salary_statistics/domain/entity/salary_statistic_model.dart';
import 'package:crm/features/admin/statistics/salary_statistics/domain/usecase/salary_statistics_usecase.dart';

class SalaryStatisticsRepository extends ISalaryStatisticsRepository {
  final LessonsSupabase _supabase;

  SalaryStatisticsRepository({
    required LessonsSupabase supabase,
  }) : _supabase = supabase;

  @override
  Future<List<SalaryStatisticModel>> getSalariesInfo(
    GetSalariesInfoParams params,
  ) async {
    try {
      final response = await _supabase.getLessonsInfoByRange(
        startDate: CustomDateUtils.prepareDateForBackend(params.startDate),
        endDate: CustomDateUtils.prepareDateForBackend(params.endDate),
      );

      final lessons = response['payload']['lessons'] as List<dynamic>;

      return mapSalaryStatistics(lessons);
    } catch (e) {
      print(e.toString());
      throw Exception(e);
    }
  }
}
