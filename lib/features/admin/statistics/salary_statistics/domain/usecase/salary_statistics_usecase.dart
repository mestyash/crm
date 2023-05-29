// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:crm/features/admin/statistics/salary_statistics/domain/entity/salary_statistic_model.dart';

abstract class ISalaryStatisticsRepository {
  Future<List<SalaryStatisticModel>> getSalariesInfo(
    GetSalariesInfoParams params,
  );
}

class GetSalariesInfoParams {
  final DateTime startDate;
  final DateTime endDate;

  GetSalariesInfoParams({
    required this.startDate,
    required this.endDate,
  });
}
