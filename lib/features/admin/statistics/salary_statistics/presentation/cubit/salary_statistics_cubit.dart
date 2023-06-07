import 'dart:async';

import 'package:crm/features/admin/statistics/salary_statistics/domain/entity/salary_statistic_model.dart';
import 'package:crm/features/admin/statistics/salary_statistics/domain/interfaces/salary_statistics_interface.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'salary_statistics_state.dart';

class SalaryStatisticsCubit extends Cubit<SalaryStatisticsState> {
  ISalaryStatisticsRepository _repository;

  SalaryStatisticsCubit({
    required ISalaryStatisticsRepository repository,
  })  : _repository = repository,
        super(SalaryStatisticsState());

  void onStartDateChange(DateTime date) {
    emit(state.copyWith(startDate: date));
    _getStatistics();
  }

  void onEndDateChange(DateTime date) {
    emit(state.copyWith(endDate: date));
    _getStatistics();
  }

  Future<void> _getStatistics() async {
    if (state.canSearch)
      try {
        emit(state.copyWith(isLoading: true));
        final data = await _repository.getSalariesInfo(
          GetSalariesInfoParams(
            startDate: state.startDate!,
            endDate: state.endDate!,
          ),
        );
        emit(state.copyWith(isLoading: false, statistics: data));
      } catch (e) {
        emit(state.copyWith(isLoading: false, isFailure: true));
      }
  }
}
